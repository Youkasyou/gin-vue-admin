package products

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"sort"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/products"
	"go.uber.org/zap"
)

const (
	productQuery = `
WITH selected_price AS (
    SELECT 
        pr.sku_id,
        pr.price,
        pr.price_type_id,
        pt.type_code,
        pt.name
    FROM prices pr
    JOIN price_types pt ON pr.price_type_id = pt.id
    WHERE pr.sku_id = ?
    AND (
        (pr.start_date IS NOT NULL AND pr.end_date IS NOT NULL AND NOW() BETWEEN pr.start_date AND pr.end_date)
        OR pr.price_type_id = 1
    )
    ORDER BY 
        CASE 
            WHEN pr.start_date IS NOT NULL AND pr.end_date IS NOT NULL AND NOW() BETWEEN pr.start_date AND pr.end_date THEN 1
            WHEN pr.price_type_id = 1 THEN 2
            ELSE 3
        END
    LIMIT 1
),
original_price AS (
    SELECT sku_id, price AS original_amount
    FROM prices
    WHERE price_type_id = 1
),

selected_sku AS (
    SELECT 
        i.sku_id
    FROM inventory i
    GROUP BY sku_id
	HAVING SUM(quantity - reserved_quantity) = 0
)


	SELECT 
		p.id,
		p.name,
		p.description,
		p.product_code,
		p.is_taxable,
		p.meta_title,
		p.meta_description,
		
		-- Target SKU Info
		JSON_OBJECT(
			'sku_id', ps.id,
			'price', IFNULL((
				SELECT JSON_OBJECT(
					'amount', sp.price,
					'formatted_amount',CONCAT(FORMAT(sp.price, 0), '円'),
					'type', sp.type_code,
					'type_name', sp.name,
					'original_amount', CASE 
                						WHEN (SELECT COUNT(*) FROM prices WHERE sku_id = ps.id AND price_type_id = 2) > 0
                						THEN op.original_amount
                						ELSE NULL
           							 END,
					'formatted_original_amount', CASE 
                						WHEN (SELECT COUNT(*) FROM prices WHERE sku_id = ps.id AND price_type_id = 2) > 0
                						THEN CONCAT(FORMAT(op.original_amount, 0), '円')
                						ELSE NULL
            						END
				)
				FROM prices pr
				JOIN price_types pt ON pr.price_type_id = pt.id
				LEFT JOIN selected_price sp ON sp.sku_id = ps.id
				LEFT JOIN original_price op ON op.sku_id = ps.id
				WHERE pr.sku_id = ps.id AND pr.is_active = TRUE
				ORDER BY 
					CASE pt.type_code 
						WHEN 'regular' THEN 1 
						WHEN 'sale' THEN 2 
						ELSE 3 
					END
				LIMIT 1
			), NULL),
			'primary_image', IFNULL((
				SELECT JSON_OBJECT(
					'id', si.id,
					'url', si.main_image_url,
					'alt_text', si.alt_text
				)
				FROM sku_images si
				WHERE si.sku_id = ps.id
				ORDER BY si.sort_order
				LIMIT 1
			), NULL),
			'attributes', (
				SELECT JSON_ARRAYAGG(
					JSON_OBJECT(
						'attribute_id', a.id,
						'attribute_name', a.name,
						'value', 
						CASE a.input_type
							WHEN 'select' THEN ao.value
							WHEN 'text' THEN sv.value_string
							WHEN 'number' THEN sv.value_number
							WHEN 'boolean' THEN sv.value_boolean
							WHEN 'textarea' THEN sv.value_text
							ELSE NULL
						END
					)
				)
				FROM sku_values sv
				JOIN attributes a ON sv.attribute_id = a.id
				LEFT JOIN attribute_options ao ON sv.option_id = ao.id
				WHERE sv.sku_id = ps.id
			)
		) AS target_sku_info,
		
		-- Variant Options
		(
			SELECT JSON_ARRAYAGG(
				JSON_OBJECT(
					'attribute_id', a.id,
					'attribute_name', a.name,
					'attribute_code', a.attribute_code,
					'display_type', a.input_type,
					'options', (
						SELECT JSON_ARRAYAGG(option_json)
							FROM (
								SELECT
									
									JSON_OBJECT(
										'option_id', ao.id,
										'option_value', ao.value,
										'option_code', ao.option_code,
										'image_url', IFNULL((
											SELECT si.main_image_url
											FROM sku_images si
											WHERE si.sku_id IN (
												SELECT sv2.sku_id
												FROM sku_values sv2
												WHERE sv2.attribute_id = a.id AND sv2.option_id = ao.id
											)
											LIMIT 1
										), NULL),
										'linked_sku_ids', (
											SELECT JSON_ARRAYAGG(sv3.sku_id)
											FROM sku_values sv3
											WHERE sv3.option_id = ao.id
											AND sv3.attribute_id = a.id
											AND sv3.sku_id IN (
												SELECT id
												FROM product_skus ps6
												WHERE ps6.product_id = (
													SELECT product_id FROM product_skus WHERE id = ?
												)
											)
											AND NOT EXISTS (
												SELECT 1
												FROM selected_sku ss
												WHERE ss.sku_id = sv3.sku_id
											)
										)
									) AS option_json, ao.sort_order
								FROM (
									SELECT DISTINCT ao.id, ao.value, ao.option_code, ao.sort_order
									FROM attribute_options ao
									JOIN sku_values sv4 ON sv4.option_id = ao.id
									JOIN product_skus ps3 ON ps3.id = sv4.sku_id
									WHERE ao.attribute_id = a.id
									AND sv4.attribute_id = a.id
									AND ps3.product_id = ps.product_id
									AND NOT EXISTS (
										SELECT 1
										FROM selected_sku ss1
										WHERE ss1.sku_id = sv4.sku_id
										)
								) ao
								ORDER BY ao.sort_order
							) t
					)
				)
			)
			FROM category_attributes ca
			JOIN attributes a ON ca.attribute_id = a.id
			WHERE ca.category_id = p.category_id AND ca.is_variant_attribute = TRUE
		) AS variant_options,
		
		-- Category Info
		JSON_OBJECT(
			'id', c.id,
			'name', c.name,
			'level', c.level,
			'parent_id', c.parent_id,
			'same_level_category',(
				select JSON_ARRAYAGG(categories.name)
				from categories 
				where parent_id in (select parent_id from categories where id = p.category_id)
			)
		) AS category_info	
	FROM products p
	JOIN product_skus ps ON p.id = ps.product_id
	LEFT JOIN categories c ON p.category_id = c.id
	WHERE ps.id = ? AND p.status = 'active' AND ps.status = 'active';
`
)

func PriceRange(lowPrice float64, highPrice float64) string {
	if lowPrice == highPrice {
		return FormatPrice(highPrice) + "円"
	} else {
		return FormatPrice(lowPrice) + "~" + FormatPrice(highPrice) + "円"
	}
}

func TruncateRuneString(s string, maxRunes int) string {
	runes := []rune(s)
	if len(runes) <= maxRunes {
		return s
	}
	if maxRunes > 3 {
		return string(runes[:maxRunes]) + "..."
	}
	return string(runes[:maxRunes+3])
}

type ProductsService struct{}

func (productsService *ProductsService) GetProductInfoByProSkuId(productCode string, skuId string) (res *dto.ProductInfoResponse, err error) {
	if skuId == "" {
		err = global.GVA_DB.Model(&products.Product{}).
			Where("product_code = ?", productCode).
			Select("default_sku_id").Scan(&skuId).Error
		if err != nil {
			fmt.Println("未找到该 Product")
			return
		}
	}

	ctx := context.Background()
	cacheKey := fmt.Sprintf("sku_id:%s", skuId)

	//先从redis查
	cached, err := global.GVA_REDIS.Get(ctx, cacheKey).Result()
	if err == nil && cached != "" {
		result := &dto.ProductInfoResponse{}
		if err := json.Unmarshal([]byte(cached), &result); err == nil {
			fmt.Println("从redis找到数据")
			return result, nil
		}
	}

	//如果redis没有，从MySQL查
	//JSON聚合查询
	var projection products.ProductProjection
	err = global.GVA_DB.Raw(productQuery, skuId, skuId, skuId).Scan(&projection).Error
	if err != nil {
		fmt.Println("未找到该 SKU")
		return
	}
	response := &dto.ProductInfoResponse{
		ID:              projection.ID,
		ProductCode:     *projection.ProductCode,
		Name:            TruncateRuneString(projection.Name, 20),
		Description:     projection.Description,
		IsTaxable:       projection.IsTaxable,
		MetaTitle:       projection.MetaTitle,
		MetaDescription: projection.MetaDescription,
	}
	*response.Description = TruncateRuneString(*projection.Description, 20)

	if len(projection.TargetSKUInfo) > 0 {
		targetSKUInfo := &dto.TargetSKUInfo{}
		if err := json.Unmarshal(projection.TargetSKUInfo, &targetSKUInfo); err != nil {
			return nil, err
		}
		response.TargetSKUInfo = targetSKUInfo
	}

	if len(projection.VariantOptions) > 0 {
		variantOptions := []dto.VariantOptionGroup{}
		if err := json.Unmarshal(projection.VariantOptions, &variantOptions); err != nil {
			return nil, err
		}
		response.VariantOptions = variantOptions
	}

	if len(projection.CategoryInfo) > 0 {
		categoryInfo := &dto.CategoryInfo{}
		if err := json.Unmarshal(projection.CategoryInfo, &categoryInfo); err != nil {
			return nil, err
		}
		response.Category = categoryInfo
	}

	// var brandInfo dto.BrandInfo
	// if err := json.Unmarshal(projection.BrandInfo, &brandInfo); err != nil {
	// 	return nil, fmt.Errorf("failed to unmarshal brand_info: %v", err)
	// }
	// response.Brand = &brandInfo

	//查完放进redis
	bytes, _ := json.Marshal(response)
	err = global.GVA_REDIS.Set(ctx, cacheKey, bytes, time.Hour).Err()
	if err != nil {
		global.GVA_LOG.Warn("写入 Redis 缓存失败", zap.Error(err))
	}

	// 在Go代码中打印原始数据
	//log.Printf("Raw JSON: %s", string(projection.VariantOptions))
	//fmt.Println(response)

	return response, err
}

func (productsService *ProductsService) GetReviews(productCode string, page int, limit int, sort string, rating int) (res *dto.ReviewListResponse, err error) {
	//先根据product_code查到product_id
	var productId string
	err = global.GVA_DB.Raw("SELECT id FROM products WHERE product_code = ?", productCode).Scan(&productId).Error
	if err != nil {
		fmt.Println("数据库错误")
		return nil, err
	}
	if productId == "" {
		fmt.Println("未找到该product")
		return nil, errors.New("not found")
	}

	offset := (page - 1) * limit
	var orderBy string
	switch sort {
	case "newest":
		orderBy = "pr.created_at DESC"
	case "oldest":
		orderBy = "pr.created_at ASC"
	case "highest_rating":
		orderBy = "pr.rating DESC,pr.created_at DESC"
	case "lowest_rating":
		orderBy = "pr.rating ASC,pr.created_at DESC"
	case "most_helpful":
		orderBy = "(SELECT COUNT(*) FROM user_review_helpful_votes uv WHERE uv.review_id = pr.id) DESC,pr.created_at DESC"
	default:
		orderBy = "pr.created_at DESC"
	}

	var ratingStr string
	var ratingStr2 string
	if rating != 0 {
		ratingStr = fmt.Sprintf("AND pr.rating = %d", rating)
		ratingStr2 = fmt.Sprintf("AND rating = %d", rating)
	}

	reviewQuery := fmt.Sprintf(`
	SELECT
	(
		SELECT JSON_OBJECT (
			'average_rating', rs.average_rating,
			'review_count',rs.review_count,
			'rating_1_count', rs.rating_1_count,
			'rating_2_count', rs.rating_2_count,
			'rating_3_count', rs.rating_3_count,
			'rating_4_count', rs.rating_4_count,
			'rating_5_count', rs.rating_5_count
		)
		FROM review_summaries rs
		WHERE rs.product_id = ?
	) AS summary,
	(
		SELECT JSON_ARRAYAGG(reviews_object)
		FROM(
			SELECT 
			JSON_OBJECT(
				'id',pr.id,
				'nickname',pr.nickname,
				'rating',pr.rating,
				'title',pr.title,
				'comment',pr.comment,
				'created_at_formatted',DATE_FORMAT(created_at, '%%Y年%%m月%%d日'),
				'image_urls',(
					SELECT JSON_ARRAYAGG(ri.image_url)
					FROM review_images ri
					WHERE ri.review_id = pr.id
				),
				'helpful_count',(
					SELECT COUNT(*)
					FROM user_review_helpful_votes urhv
           			WHERE urhv.review_id = pr.id
				)
			) AS reviews_object
			FROM product_reviews pr
			WHERE pr.product_id = ? AND pr.status = 'approved' %s
			ORDER BY %s
			LIMIT ? OFFSET ?
		) t		
	) AS reviews,
	JSON_OBJECT(
		'current_page',?,
		'limit',?,
		'total_count',(SELECT COUNT(*) FROM product_reviews WHERE product_id = ? AND status = 'approved' %s),
		'total_pages',(SELECT CEIL(COUNT(*) / ?) FROM product_reviews WHERE product_id = ? AND status = 'approved' %s)
	) AS pagination
	`, ratingStr, orderBy, ratingStr2, ratingStr2)

	reviewProjection := &products.ReviewProjection{}
	err = global.GVA_DB.Raw(reviewQuery, productId, productId, limit, offset, page, limit, productId, limit, productId).Scan(&reviewProjection).Error
	if err != nil {
		fmt.Println("未找到review")
		return
	}

	reviewListResponse := &dto.ReviewListResponse{}
	summary := &dto.ReviewSummary{}
	if len(reviewProjection.Summary) > 0 {
		err := json.Unmarshal(reviewProjection.Summary, &summary)
		if err != nil {
			return nil, err
		}
	}
	reviewListResponse.Summary = summary

	reviewInfo := []dto.ReviewInfo{}
	if len(reviewProjection.Reviews) > 0 {
		err := json.Unmarshal(reviewProjection.Reviews, &reviewInfo)
		if err != nil {
			return nil, err
		}
	}
	reviewListResponse.Reviews = reviewInfo

	paginationInfo := dto.PaginationInfo{}
	if len(reviewProjection.Pagination) > 0 {
		err := json.Unmarshal(reviewProjection.Pagination, &paginationInfo)
		if err != nil {
			return nil, err
		}
	}
	reviewListResponse.Pagination = paginationInfo

	return reviewListResponse, err
}

func (productsService *ProductsService) GetQA(productCode string, page int, limit int, sort string) (res *dto.QAListResponse, err error) {
	//先根据product_code查到product_id
	var productId string
	err = global.GVA_DB.Raw("SELECT id FROM products WHERE product_code = ?", productCode).Scan(&productId).Error
	if err != nil {
		fmt.Println("数据库错误")
		return nil, err
	}
	if productId == "" {
		fmt.Println("未找到该product")
		return nil, errors.New("not found")
	}

	offset := (page - 1) * limit
	var orderBy string
	switch sort {
	case "newest":
		orderBy = "pq.created_at DESC"
	case "oldest":
		orderBy = "pq.created_at ASC"
	case "most_helpful":
		orderBy = "COUNT(uv.answer_id) DESC,pq.created_at DESC"
	default:
		orderBy = "pq.created_at DESC"
	}

	qaQuery := fmt.Sprintf(`
	SELECT
	(
		SELECT JSON_ARRAYAGG(qa_list)
		FROM (
			SELECT
			JSON_OBJECT(
				'question', JSON_OBJECT(
					'id',pq.id,
					'question_text',pq.question_text,
					'created_at_formatted',DATE_FORMAT(pq.created_at, '%%Y年%%m月%%d日')
				),
				'answer',JSON_OBJECT(
					'id',qa.id,
					'answerer_name',qa.answerer_name,
					'answer_text',qa.answer_text,
					'helpful_count',COUNT(uv.answer_id),
					'created_at_formatted',DATE_FORMAT(qa.created_at, '%%Y年%%m月%%d日')
				)
			) AS qa_list
			FROM product_questions pq
			JOIN question_answers qa ON pq.id = qa.question_id
			LEFT JOIN user_answer_helpful_votes uv ON qa.id = uv.answer_id
			WHERE pq.product_id = ? AND pq.status = 'approved'
			GROUP BY pq.id,pq.question_text,pq.created_at,qa.id,qa.answerer_name,qa.answer_text,qa.created_at
			ORDER BY %s
			LIMIT ? OFFSET ?
		)t
	) AS qa_list,
	JSON_OBJECT(
		'current_page',?,
		'limit',?,
		'total_count',(SELECT COUNT(*) FROM product_questions pq1 JOIN question_answers qa1 ON pq1.id = qa1.question_id WHERE pq1.product_id = ? AND pq1.status = 'approved'),
		'total_pages',(SELECT CEIL(COUNT(*) / ?) FROM product_questions pq2 JOIN question_answers qa2 ON pq2.id = qa2.question_id WHERE pq2.product_id = ? AND pq2.status = 'approved')
	) AS pagination
	`, orderBy)

	qAListProjection := &products.QAListProjection{}
	err = global.GVA_DB.Raw(qaQuery, productId, limit, offset, page, limit, productId, limit, productId).Scan(&qAListProjection).Error
	if err != nil {
		fmt.Println("未找到Q&A")
		return
	}

	qAListResponse := &dto.QAListResponse{}
	qAList := []dto.QAInfo{}
	if len(qAListProjection.QAList) > 0 {
		err := json.Unmarshal(qAListProjection.QAList, &qAList)
		if err != nil {
			return nil, err
		}
	}
	qAListResponse.QAList = qAList

	paginationInfo := dto.PaginationInfo{}
	if len(qAListProjection.Pagination) > 0 {
		err := json.Unmarshal(qAListProjection.Pagination, &paginationInfo)
		if err != nil {
			return nil, err
		}
	}
	qAListResponse.Pagination = paginationInfo

	return qAListResponse, err
}

func (productsService *ProductsService) GetImage(skuId string) (res *dto.SKUImageListResponse, err error) {
	var EXISTS bool
	err = global.GVA_DB.Raw(`SELECT EXISTS(SELECT 1 FROM product_skus WHERE id = ?) AS exist`, skuId).Scan(&EXISTS).Error
	if err != nil {
		fmt.Println("数据库错误")
		return nil, err
	}
	if !EXISTS {
		fmt.Println("未找到该sku")
		return nil, errors.New("not found")
	}

	imageQuery := `
		SELECT JSON_ARRAYAGG(
			JSON_OBJECT(
				'id',id,
				'main_image_url',main_image_url,
				'thumbnail_url',thumbnail_url,
				'alt_text',alt_text,
				'sort_order',sort_order
			)
		) AS images
		FROM sku_images
		WHERE sku_id = ?
		ORDER BY sort_order ASC
	`
	sKUImageListProjection := &products.SKUImageListProjection{}
	err = global.GVA_DB.Raw(imageQuery, skuId).Scan(&sKUImageListProjection).Error
	if err != nil {
		fmt.Println("未找到sku")
		return
	}

	sKUImageListResponse := &dto.SKUImageListResponse{}
	sKUImageInfo := []dto.SKUImageInfo{}
	if len(sKUImageListProjection.Images) > 0 {
		err := json.Unmarshal(sKUImageListProjection.Images, &sKUImageInfo)
		if err != nil {
			return nil, err
		}
	}
	sKUImageListResponse.Images = sKUImageInfo

	return sKUImageListResponse, err

}

func (productsService *ProductsService) GetRelated(productCode string, limit int) (res *dto.RelatedProductListResponse, err error) {

	//先根据product_code查到product_id
	var productId string
	err = global.GVA_DB.Raw("SELECT id FROM products WHERE product_code = ?", productCode).Scan(&productId).Error
	if err != nil {
		fmt.Println("数据库错误")
		return nil, err
	}
	if productId == "" {
		fmt.Println("未找到该product")
		return nil, errors.New("not found")
	}

	entity := []products.RelatedProductInfoEntity{}
	err = global.GVA_DB.Table("products p").
		Select(`
			p.id as product_id, p.product_code as product_code, p.name as product_name,
			max(price) AS highest_price, min(price) as lowest_price,
			max(case when pri.price_type_id = 2 then true else false end) as is_on_sale, 
			rs.average_rating as average_rating, rs.review_count as review_count, 
			si.thumbnail_url as thumbnail_image_url`).
		Joins("left join product_skus ps on ps.product_id = p.id").
		Joins("left join prices pri on pri.sku_id = ps.id").
		Joins("left join sku_images si on si.sku_id = p.default_sku_id").
		Joins("left join review_summaries rs on rs.product_id = p.id").
		Where(`p.category_id in (select category_id from products where id = ? ) 
				and pri.id in 
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
				)`, productId).
		Group(`p.id , p.product_code , p.name ,rs.average_rating , rs.review_count , si.thumbnail_url`).
		Find(&entity).Error
	if err != nil {
		fmt.Println("sql语句执行失败")
		return
	}

	relatedProductListResponse := &dto.RelatedProductListResponse{}
	relatedMap := make(map[string]*dto.RelatedProductInfo)
	for _, v := range entity {
		if _, ok := relatedMap[v.ProductID]; !ok {
			relatedMap[v.ProductID] = &dto.RelatedProductInfo{
				ProductID:           v.ProductID,
				ProductCode:         v.ProductCode,
				ProductName:         TruncateRuneString(v.ProductName, 20),
				PriceRangeFormatted: PriceRange(v.LowestPrice, v.HighestPrice),
				IsOnSale:            v.IsOnSale,
				ReviewSummary: &dto.ReviewSummaryInfo{
					AverageRating: v.AverageRating,
					ReviewCount:   v.ReviewCount,
				},
				ThumbnailImageURL: v.ThumbnailImageURL,
			}
		}
	}
	for _, v := range relatedMap {
		relatedProductListResponse.RelatedProducts = append(relatedProductListResponse.RelatedProducts, *v)
	}

	sort.Slice(relatedProductListResponse.RelatedProducts, func(i, j int) bool {
		return relatedProductListResponse.RelatedProducts[i].ProductID <
			relatedProductListResponse.RelatedProducts[j].ProductID
	})

	if limit > len(relatedProductListResponse.RelatedProducts) {
		limit = len(relatedProductListResponse.RelatedProducts)
	}

	relatedProductListResponse.RelatedProducts = relatedProductListResponse.RelatedProducts[:limit]

	return relatedProductListResponse, err
}

func (productsService *ProductsService) GetCoordinates(productCode string, limit int) (res *dto.CoordinateSetTeaserListResponse, err error) {
	//先根据product_code查到product_id
	var productId string
	err = global.GVA_DB.Raw("SELECT id FROM products WHERE product_code = ?", productCode).Scan(&productId).Error
	if err != nil {
		fmt.Println("数据库错误")
		return nil, err
	}
	if productId == "" {
		fmt.Println("未找到该product")
		return nil, errors.New("not found")
	}

	entity := []dto.CoordinateSetTeaserInfo{}
	err = global.GVA_DB.Table("coordinate_sets cs").
		Select(`
		cs.id as set_id, cs.theme_image_url as set_theme_image_url,
		cs.contributor_nickname as contributor_nickname,
		cs.contributor_avatar_url as contributor_avatar_url,
		cs.contributor_store_name as contributor_store_name
	`).
		Joins("left join coordinate_set_items csi on csi.coordinate_set_id = cs.id").
		Where("csi.product_id = ?", productId).
		Order("cs.sort_order asc").
		Find(&entity).Error

	list := &dto.CoordinateSetTeaserListResponse{}
	list.Coordinates = entity

	if limit > len(list.Coordinates) {
		limit = len(list.Coordinates)
	}

	list.Coordinates = list.Coordinates[:limit]

	return list, err
}
