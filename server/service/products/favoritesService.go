package products

import (
	"fmt"
	"math"
	"sort"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/products"
	"golang.org/x/text/language"
	"golang.org/x/text/message"
)

func FormatPrice(price float64) string {
	p := message.NewPrinter(language.Japanese)
	return p.Sprintf("%.0f", price)
	// return fmt.Sprintf("%,.2f円", price)
}

type FavoritesService struct{}

func (favoritesService *FavoritesService) GetFavoriteSku(id uint, page int, limit int, sortOrder string) (res *dto.FavoriteSKUListResponse, err error) {
	offset := (page - 1) * limit
	var orderBy string
	switch sortOrder {
	case "newest":
		orderBy = "us.created_at DESC,a.sort_order"
	case "oldest":
		orderBy = "us.created_at ASC,a.sort_order"
	default:
		orderBy = "us.created_at DESC,a.sort_order"
	}
	paginationInfo := &dto.PaginationInfo{}
	var totalCount int64
	err = global.GVA_DB.Table("user_favorite_skus us").
		Joins("LEFT JOIN product_skus ps ON us.sku_id = ps.id").
		Where("us.user_id = ? AND ps.status = 'active'", id).Count(&totalCount).Error
	if err != nil {
		return
	}
	paginationInfo.CurrentPage = page
	paginationInfo.Limit = limit
	paginationInfo.TotalCount = int(totalCount)
	paginationInfo.TotalPages = int(math.Ceil(float64(totalCount) / float64(limit)))

	entity := []products.FavoriteSKUInfoEntity{}
	err = global.GVA_DB.Table("user_favorite_skus us").
		Select(`us.sku_id AS sku_id,p.id AS product_id,p.name AS product_name,p.product_code AS product_code,
			pri.price AS amount, pri.price_type_id AS type,pri.currency_code AS type_name,si.id AS image_id,
			si.main_image_url AS image_url, si.alt_text AS alt_text, 
			a.id AS attribute_id, a.name AS attribute_name,
				CASE a.input_type
					WHEN 'select' THEN ao.value
					WHEN 'text' THEN sv.value_string
					WHEN 'number' THEN sv.value_number
					WHEN 'boolean' THEN sv.value_boolean
					WHEN 'textarea' THEN sv.value_text
					ELSE NULL
				END AS value ,
			DATE_FORMAT(us.created_at, '%Y年%m月%d日') AS added_at_formatted
	`).
		Joins("LEFT JOIN product_skus ps ON us.sku_id = ps.id").
		Joins("LEFT JOIN products p ON p.id = ps.product_id").
		Joins("LEFT JOIN prices pri ON ps.id = pri.sku_id").
		Joins("LEFT JOIN sku_images si ON ps.id = si.sku_id").
		Joins("LEFT JOIN sku_values sv ON us.sku_id = sv.sku_id").
		Joins("LEFT JOIN attributes a ON sv.attribute_id = a.id").
		Joins("LEFT JOIN attribute_options ao ON ao.id = sv.option_id").
		Where("us.user_id = ? AND ps.status = 'active' ", id).
		Order(orderBy).Find(&entity).Error
	if err != nil {
		fmt.Println("sql语句执行失败")
		return
	}

	favoriteSKUListResponse := &dto.FavoriteSKUListResponse{}
	favoriteMap := make(map[string]*dto.FavoriteSKUInfo)
	attributeMap := make(map[string]map[int]struct{})
	for _, v := range entity {
		if _, ok := favoriteMap[v.SkuID]; !ok {
			favoriteMap[v.SkuID] = &dto.FavoriteSKUInfo{
				SkuID:       v.SkuID,
				ProductID:   v.ProductID,
				ProductName: v.ProductName,
				ProductCode: v.ProductCode,
				Price: &dto.PriceInfo{
					Amount:                  v.Amount,
					FormattedAmount:         FormatPrice(v.Amount) + "円",
					Type:                    v.Type,
					TypeName:                v.TypeName,
					OriginalAmount:          &v.Amount,
					FormattedOriginalAmount: func(s string) *string { return &s }(FormatPrice(v.Amount) + "円"),
				},
				PrimaryImage: &dto.ImageInfo{
					ID:      v.ImageID,
					URL:     v.ImageURL,
					AltText: v.AltText,
				},
				Attributes:       []dto.AttributeInfo{},
				AddedAtFormatted: v.AddedAtFormatted,
			}
			attributeMap[v.SkuID] = make(map[int]struct{})
		}
		if _, ok := attributeMap[v.SkuID][v.AttributeID]; !ok {
			favoriteMap[v.SkuID].Attributes = append(favoriteMap[v.SkuID].Attributes, dto.AttributeInfo{
				AttributeID:   v.AttributeID,
				AttributeName: v.AttributeName,
				Value:         v.Value,
			})
			attributeMap[v.SkuID][v.AttributeID] = struct{}{}
		}
	}

	for _, v := range favoriteMap {
		favoriteSKUListResponse.Favorites = append(favoriteSKUListResponse.Favorites, *v)
	}

	favoriteSKUListResponse.Pagination = *paginationInfo

	switch sortOrder {
	case "newest":
		sort.Slice(favoriteSKUListResponse.Favorites, func(i, j int) bool {
			return favoriteSKUListResponse.Favorites[i].AddedAtFormatted >
				favoriteSKUListResponse.Favorites[j].AddedAtFormatted
		})
	case "oldest":
		sort.Slice(favoriteSKUListResponse.Favorites, func(i, j int) bool {
			return favoriteSKUListResponse.Favorites[i].AddedAtFormatted <
				favoriteSKUListResponse.Favorites[j].AddedAtFormatted
		})
	}

	total := len(favoriteSKUListResponse.Favorites)
	if offset >= total {
		favoriteSKUListResponse.Favorites = []dto.FavoriteSKUInfo{}
	} else {
		end := offset + limit
		if end > total {
			end = total
		}
		favoriteSKUListResponse.Favorites = favoriteSKUListResponse.Favorites[offset:end]
	}

	return favoriteSKUListResponse, err
}

func (favoritesService *FavoritesService) AddFavoriteSku(id uint, skuId string) (err error) {
	var EXISTS bool
	err = global.GVA_DB.Raw(`SELECT EXISTS(SELECT 1 FROM product_skus WHERE id = ?) AS exist`, skuId).Scan(&EXISTS).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if !EXISTS {
		fmt.Println("未找到该sku")
		return response.ErrNotFound
	}

	err = global.GVA_DB.Exec(`INSERT INTO user_favorite_skus(user_id,sku_id,created_at) 
		SELECT ?,?,NOW()
		WHERE NOT EXISTS (
			SELECT 1 FROM user_favorite_skus WHERE user_id = ? AND sku_id = ?
		)
	`, id, skuId, id, skuId).Error

	return
}

func (favoritesService *FavoritesService) DeleteFavoriteSku(id uint, skuId string) (err error) {
	var EXISTS bool
	err = global.GVA_DB.Raw(`SELECT EXISTS(SELECT 1 FROM product_skus WHERE id = ?) AS exist`, skuId).Scan(&EXISTS).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if !EXISTS {
		fmt.Println("未找到该sku")
		return response.ErrNotFound
	}

	result := global.GVA_DB.Exec(`DELETE FROM user_favorite_skus WHERE user_id = ? AND sku_id = ?`, id, skuId)
	if result.RowsAffected == 0 {
		return response.ErrNotFound
	}

	return
}
