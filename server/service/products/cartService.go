package products

import (
	"errors"
	"fmt"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/products"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type CartService struct{}

func (cartService *CartService) GetCart(id uint) (res *dto.CartResponse, err error) {
	entity := []products.CartEntity{}
	err = global.GVA_DB.Table("user_cart_items ui").
		Select(`ui.sku_id,p.id as product_id, p.product_code,p.name as product_name, ui.quantity,pri.price as original_amount,
			CONCAT(FORMAT(pri.price, 0), '円') as formatted_original_amount,ranked.price as amount,CONCAT(FORMAT(ranked.price, 0), '円') as formatted_amount,
			ranked.type_code as type,ranked.name as type_name, CONCAT(FORMAT(ui.quantity * ranked.price, 0), '円') as subtotal_formatted,
			si.id as image_id, si.thumbnail_url as url , si.alt_text,
			case
				when SUM(i.quantity - i.reserved_quantity) >= 10 then '在庫あり'
				when SUM(i.quantity - i.reserved_quantity) > 0 && SUM(i.quantity - i.reserved_quantity) <10 then '残りわずか'
				when SUM(i.quantity - i.reserved_quantity) = 0 then '在庫切れ'
			end as stock_status,
			a.id AS attribute_id, a.name AS attribute_name,
							CASE a.input_type
								WHEN 'select' THEN ao.value
								WHEN 'text' THEN sv.value_string
								WHEN 'number' THEN sv.value_number
								WHEN 'boolean' THEN sv.value_boolean
								WHEN 'textarea' THEN sv.value_text
								ELSE NULL
							END AS value`).
		Joins("left join product_skus ps on ui.sku_id = ps.id").
		Joins("left join products p on ps.product_id = p.id").
		Joins("left join prices pri on ui.sku_id = pri.sku_id").
		Joins("left join sku_images si on ui.sku_id = si.sku_id").
		Joins("left join sku_values sv on ui.sku_id = sv.sku_id").
		Joins("left join attributes a on a.id = sv.attribute_id").
		Joins("left join attribute_options ao on a.id = ao.attribute_id").
		Joins("left join inventory i on i.sku_id = ui.sku_id").
		Joins(`left join (select sku_id, price,type_code,name
					from
						(select sku_id, price,type_code,name,
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
                            join price_types pt on prices.price_type_id = pt.id
							where ((start_date IS NOT NULL AND end_date IS NOT NULL AND NOW() BETWEEN start_date AND end_date) OR price_type_id = 1)
						) as ranked
					where rn = 1) as ranked on ui.sku_id = ranked.sku_id`).
		Where("pri.price_type_id = 1 and ui.user_id = ?", id).
		Group(`ui.sku_id,p.id , p.product_code,p.name , ui.quantity,pri.price ,
	ranked.price ,ranked.type_code ,ranked.name,a.id,a.name,a.input_type,
	ao.value,sv.value_string,sv.value_number,sv.value_boolean,sv.value_text,
	si.id , si.thumbnail_url, si.alt_text`).
		Find(&entity).Error

	if err != nil {
		fmt.Println("sql语句执行失败")
		return
	}

	cartResponse := &dto.CartResponse{}
	cartItemsMap := make(map[string]*dto.CartItemInfo)
	attributeMap := make(map[string]map[int]struct{})
	for _, v := range entity {
		if _, ok := cartItemsMap[v.SkuID]; !ok {
			cartItemsMap[v.SkuID] = &dto.CartItemInfo{
				SkuID:             v.SkuID,
				ProductID:         v.ProductID,
				ProductName:       v.ProductName,
				ProductCode:       v.ProductCode,
				Quantity:          v.Quantity,
				SubtotalFormatted: v.SubtotalFormatted,
				StockStatus:       v.StockStatus,
				Price: &dto.PriceInfo{
					Amount:                  v.Amount,
					FormattedAmount:         v.FormattedAmount,
					Type:                    v.Type,
					TypeName:                v.TypeName,
					OriginalAmount:          v.OriginalAmount,
					FormattedOriginalAmount: v.FormattedOriginalAmount,
				},
				PrimaryImage: &dto.ImageInfo{
					ID:      v.ImageID,
					URL:     v.URL,
					AltText: v.AltText,
				},
				Attributes: []dto.AttributeInfo{},
			}
			attributeMap[v.SkuID] = make(map[int]struct{})
		}
		if _, ok := attributeMap[v.SkuID][v.AttributeID]; !ok {
			cartItemsMap[v.SkuID].Attributes = append(cartItemsMap[v.SkuID].Attributes, dto.AttributeInfo{
				AttributeID:   v.AttributeID,
				AttributeName: v.AttributeName,
				Value:         v.Value,
			})
			attributeMap[v.SkuID][v.AttributeID] = struct{}{}
		}
	}

	for _, v := range cartItemsMap {
		cartResponse.Items = append(cartResponse.Items, *v)
	}

	for _, v := range cartResponse.Items {
		cartResponse.TotalItemsCount += v.Quantity
		cartResponse.TotalAmount += (v.Price.Amount * float64(v.Quantity))
		if v.Price.Type == "regular" {
			v.Price.OriginalAmount = nil
			v.Price.FormattedOriginalAmount = nil
		}
	}

	cartResponse.TotalAmountFormatted = FormatPrice(cartResponse.TotalAmount) + "円"

	return cartResponse, err

}

func (cartService *CartService) AddCart(id uint, skuId string, quantity int) (err error) {
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

	var inventory int
	err = global.GVA_DB.Table("inventory").Select(`SUM(quantity - reserved_quantity) as inventory`).
		Where("sku_id = ?", skuId).
		Group("sku_id").Scan(&inventory).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if inventory < quantity {
		return errors.New("ErrInsufficientStock")
	}

	item := map[string]interface{}{
		"user_id":    id,
		"sku_id":     skuId,
		"quantity":   quantity,
		"added_at":   time.Now(),
		"updated_at": time.Now(),
	}

	err = global.GVA_DB.Table("user_cart_items").Clauses(clause.OnConflict{
		Columns: []clause.Column{{Name: "user_id"}, {Name: "sku_id"}},
		DoUpdates: clause.Assignments(map[string]interface{}{
			"quantity":   gorm.Expr("quantity + ?", quantity),
			"updated_at": time.Now(),
		}),
	}).Create(&item).Error

	return
}

func (cartService *CartService) SetCart(id uint, skuId string, quantity int) (err error) {
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

	var inventory int
	err = global.GVA_DB.Table("inventory").Select(`SUM(quantity - reserved_quantity) as inventory`).
		Where("sku_id = ?", skuId).
		Group("sku_id").Scan(&inventory).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if inventory < quantity {
		return errors.New("ErrInsufficientStock")
	}

	item := map[string]interface{}{
		"user_id":    id,
		"sku_id":     skuId,
		"quantity":   quantity,
		"added_at":   time.Now(),
		"updated_at": time.Now(),
	}

	err = global.GVA_DB.Table("user_cart_items").Clauses(clause.OnConflict{
		Columns: []clause.Column{{Name: "user_id"}, {Name: "sku_id"}},
		DoUpdates: clause.Assignments(map[string]interface{}{
			"quantity":   quantity,
			"updated_at": time.Now(),
		}),
	}).Create(&item).Error

	return
}

func (cartService *CartService) DeleteCart(id uint, skuId string) (err error) {
	result := global.GVA_DB.Exec(`DELETE FROM user_cart_items WHERE user_id = ? AND sku_id = ?`, id, skuId)
	if result.RowsAffected == 0 {
		return errors.New("ErrCartItemNotFound")
	}

	return
}
