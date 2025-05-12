package products

import (
	"errors"
	"fmt"
	"math"
	"sort"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/products"
)

type HistoryService struct{}

func (historyService *HistoryService) AddHistory(id uint, skuId string) (err error) {
	var EXISTS bool
	err = global.GVA_DB.
		Table("product_skus").Select("1").Where("id = ?", skuId).Limit(1).Scan(&EXISTS).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if !EXISTS {
		fmt.Println("未找到该sku")
		return errors.New("not found")
	}

	err = global.GVA_DB.Table("user_viewed_skus").
		Create(map[string]interface{}{
			"user_id":   id,
			"sku_id":    skuId,
			"viewed_at": time.Now(),
		}).Error

	return
}

func (historyService *HistoryService) GetHistory(id uint, page int, limit int) (res *dto.ViewedSKUListResponse, err error) {
	offset := (page - 1) * limit

	paginationInfo := &dto.PaginationInfo{}
	var totalCount int64
	err = global.GVA_DB.Table("user_viewed_skus us").
		Joins("LEFT JOIN product_skus ps ON us.sku_id = ps.id").
		Where("us.user_id = ? AND ps.status = 'active'", id).Count(&totalCount).Error
	if err != nil {
		return
	}
	paginationInfo.CurrentPage = page
	paginationInfo.Limit = limit
	paginationInfo.TotalCount = int(totalCount)
	paginationInfo.TotalPages = int(math.Ceil(float64(totalCount) / float64(limit)))

	entity := []products.ViewedSKUInfoEntity{}
	err = global.GVA_DB.Table("user_viewed_skus us").
		Select(`us.sku_id as sku_id, p.id as product_id, p.name as product_name, p.product_code as product_code, si.id as image_id, 
		si.thumbnail_url as image_url, si.alt_text as alt_text, rs.average_rating,rs.review_count,
		DATE_FORMAT(us.viewed_at, '%Y年%m月%d日 %H:%i') as viewed_at_formatted,
		max(price) AS highest_price, min(price) as lowest_price`).
		Joins("left join products p on us.sku_id = p.default_sku_id").
		Joins("left join product_skus ps on p.id = ps.product_id").
		Joins("left join prices pri on ps.id = pri.sku_id").
		Joins("left join sku_images si on si.sku_id = us.sku_id").
		Joins("left join review_summaries rs on rs.product_id = p.id").
		Where(`us.user_id = 1 and si.sort_order = 0 and pri.id in 
				(select id
					from
						(select *,
							row_number() over(
								partition by sku_id
								ORDER BY 
									CASE 
										WHEN start_date IS NOT NULL AND end_date IS NOT NULL AND NOW() BETWEEN start_date AND end_date THEN 1
										WHEN price_type_id = 1 THEN 2
										ELSE 3
									END
							) as rn
							from prices
							where ((start_date IS NOT NULL AND end_date IS NOT NULL AND NOW() BETWEEN start_date AND end_date) OR price_type_id = 1)
						) as ranked
					where rn = 1
				)`).
		Group(`us.sku_id , p.id , p.name , p.product_code , si.id , 
		si.thumbnail_url , si.alt_text , rs.average_rating,rs.review_count,us.viewed_at`).
		Order("us.viewed_at desc").
		Find(&entity).Error
	if err != nil {
		fmt.Println("sql语句执行失败")
		return
	}

	viewedSKUListResponse := &dto.ViewedSKUListResponse{}
	viewedMap := make(map[string]*dto.ViewedSKUInfo)
	for _, v := range entity {
		if _, ok := viewedMap[v.SkuID]; !ok {
			viewedMap[v.SkuID] = &dto.ViewedSKUInfo{
				SkuID:               v.SkuID,
				ProductID:           v.ProductID,
				ProductName:         TruncateRuneString(v.ProductName, 20),
				ProductCode:         v.ProductCode,
				PriceRangeFormatted: PriceRange(v.LowestPrice, v.HighestPrice),
				PrimaryImage: &dto.ImageInfo{
					ID:      v.ImageID,
					URL:     v.ImageURL,
					AltText: v.AltText,
				},
				ReviewSummary: &dto.ReviewSummaryInfo{
					AverageRating: v.AverageRating,
					ReviewCount:   v.ReviewCount,
				},
				ViewedAtFormatted: v.ViewedAtFormatted,
			}
		}
	}

	for _, v := range viewedMap {
		viewedSKUListResponse.History = append(viewedSKUListResponse.History, *v)
	}
	sort.Slice(viewedSKUListResponse.History, func(i, j int) bool {
		return viewedSKUListResponse.History[i].ViewedAtFormatted >
			viewedSKUListResponse.History[j].ViewedAtFormatted
	})

	total := len(viewedSKUListResponse.History)
	if offset >= total {
		viewedSKUListResponse.History = []dto.ViewedSKUInfo{}
	} else {
		end := offset + limit
		if end > total {
			end = total
		}
		viewedSKUListResponse.History = viewedSKUListResponse.History[offset:end]
	}

	viewedSKUListResponse.Pagination = *paginationInfo

	return viewedSKUListResponse, err
}
