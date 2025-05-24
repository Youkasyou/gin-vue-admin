package products

import (
	"errors"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func setupMockDB(t *testing.T) (sqlmock.Sqlmock, func()) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)

	gormDB, err := gorm.Open(mysql.New(mysql.Config{
		Conn:                      db,
		SkipInitializeWithVersion: true,
	}), &gorm.Config{})
	assert.NoError(t, err)

	// 替换 global.GVA_DB 为 mock DB
	global.GVA_DB = gormDB

	// 返回 mock 和清理函数
	return mock, func() {
		db.Close()
	}
}

func TestGetImage(t *testing.T) {
	mock, close := setupMockDB(t)
	defer close()

	productService := &ProductsService{}

	tests := []struct {
		name       string
		skuID      string
		mockSetup  func()
		wantErr    error
		wantImages int
	}{
		{
			name:  "valid SKU with images",
			skuID: "123",
			mockSetup: func() {
				mock.ExpectQuery(`SELECT EXISTS\(SELECT 1 FROM product_skus WHERE id = \?\) AS exist`).
					WithArgs("123").
					WillReturnRows(sqlmock.NewRows([]string{"exist"}).AddRow(true))

				mock.ExpectQuery(`SELECT JSON_ARRAYAGG\(`).
					WithArgs("123").
					WillReturnRows(sqlmock.NewRows([]string{"images"}).AddRow(`[
                        {"id":1,"main_image_url":"img1.jpg","thumbnail_url":"thumb1.jpg","alt_text":"alt1","sort_order":1},
                        {"id":2,"main_image_url":"img2.jpg","thumbnail_url":"thumb2.jpg","alt_text":"alt2","sort_order":2}
                    ]`))
			},
			wantErr:    nil,
			wantImages: 2,
		},
		{
			name:  "SKU not exist",
			skuID: "999",
			mockSetup: func() {
				mock.ExpectQuery(`SELECT EXISTS\(SELECT 1 FROM product_skus WHERE id = \?\) AS exist`).
					WithArgs("999").
					WillReturnRows(sqlmock.NewRows([]string{"exist"}).AddRow(false))
			},
			wantErr:    response.ErrNotFound,
			wantImages: 0,
		},
		{
			name:  "DB error on SKU check",
			skuID: "123",
			mockSetup: func() {
				mock.ExpectQuery(`SELECT EXISTS\(SELECT 1 FROM product_skus WHERE id = \?\) AS exist`).
					WithArgs("123").
					WillReturnError(errors.New("db error"))
			},
			wantErr:    errors.New("db error"),
			wantImages: 0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tt.mockSetup()

			res, err := productService.GetImage(tt.skuID)

			if tt.wantErr != nil {
				require.Error(t, err)
				assert.Contains(t, err.Error(), tt.wantErr.Error())
			} else {
				require.NoError(t, err)
				assert.Len(t, res.Images, tt.wantImages)
			}

			// 验证 mock 是否都执行完了
			err = mock.ExpectationsWereMet()
			require.NoError(t, err)
		})
	}
}
