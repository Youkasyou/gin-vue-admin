package products

import (
	"errors"
	"fmt"
	"log"
	"math"
	"strconv"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/payjp/payjp-go/v1"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type OrdersService struct{}

func (ordersService *OrdersService) GetInfo(id uint) (res *dto.CheckoutInfoResponse, err error) {
	cartService := &CartService{}
	cartInfo, _ := cartService.GetCart(id)

	checkoutInfoResponse := &dto.CheckoutInfoResponse{}
	entity := &dto.CurrentCheckoutStateEntity{}
	result := global.GVA_DB.Table("checkout_sessions").
		Select(`cart_subtotal as cart_subtotal_amount, coupon_discount_amount,points_discount_amount,shipping_fee,total_amount,used_points,
			id as coupon_id, coupon_code,name,coupon_discount_amount as discount_amount, 
			CONCAT(FORMAT(cart_subtotal, 0), '円') as cart_subtotal_amount_formatted,
			CONCAT(FORMAT(coupon_discount_amount, 0), '円') as coupon_discount_amount_formatted,
			CONCAT(FORMAT(coupon_discount_amount, 0), '円') as formatted_discount_amount,
			CONCAT(FORMAT(points_discount_amount, 0), '円') as points_discount_amount_formatted,
			CONCAT(FORMAT(shipping_fee, 0), '円') as shipping_fee_formatted,
			CONCAT(FORMAT(total_amount, 0), '円') as total_amount_formatted`).
		Joins("left join coupons on applied_coupon_id = id").
		Where("user_id = ?", id).Limit(1).Find(&entity)

	if errors.Is(result.Error, gorm.ErrRecordNotFound) || entity.CartSubtotalAmount != cartInfo.TotalAmount {
		session := map[string]interface{}{
			"user_id":                id,
			"cart_subtotal":          cartInfo.TotalAmount,
			"applied_coupon_id":      nil,
			"coupon_discount_amount": 0.00,
			"used_points":            0,
			"points_discount_amount": 0,
			"shipping_fee":           500,
			"total_amount":           cartInfo.TotalAmount + 500,
			"last_updated_at":        time.Now(),
		}

		err = global.GVA_DB.Table("checkout_sessions").Clauses(clause.OnConflict{
			Columns: []clause.Column{{Name: "user_id"}},
			DoUpdates: clause.Assignments(map[string]interface{}{
				"cart_subtotal":          cartInfo.TotalAmount,
				"applied_coupon_id":      nil,
				"coupon_discount_amount": 0.00,
				"used_points":            0,
				"points_discount_amount": 0,
				"shipping_fee":           500,
				"total_amount":           cartInfo.TotalAmount + 500,
				"last_updated_at":        time.Now(),
			}),
		}).Create(&session).Error

		global.GVA_DB.Table("checkout_sessions").
			Select(`cart_subtotal as cart_subtotal_amount, coupon_discount_amount,points_discount_amount,shipping_fee,total_amount,used_points,
			id as coupon_id, coupon_code,name,coupon_discount_amount as discount_amount, 
			CONCAT(FORMAT(cart_subtotal, 0), '円') as cart_subtotal_amount_formatted,
			CONCAT(FORMAT(coupon_discount_amount, 0), '円') as coupon_discount_amount_formatted,
			CONCAT(FORMAT(coupon_discount_amount, 0), '円') as formatted_discount_amount,
			CONCAT(FORMAT(points_discount_amount, 0), '円') as points_discount_amount_formatted,
			CONCAT(FORMAT(shipping_fee, 0), '円') as shipping_fee_formatted,
			CONCAT(FORMAT(total_amount, 0), '円') as total_amount_formatted`).
			Joins("left join coupons on applied_coupon_id = id").
			Where("user_id = ?", id).Limit(1).Find(&entity)

	}

	checkoutInfoResponse.CurrentCheckoutState = &dto.CurrentCheckoutState{
		CartSubtotalAmountFormatted: entity.CartSubtotalAmountFormatted,
		AppliedCouponInfo: &dto.AppliedCouponInfo{
			CouponID:                entity.CouponID,
			CouponCode:              entity.CouponCode,
			Name:                    entity.Name,
			DiscountAmount:          entity.DiscountAmount,
			FormattedDiscountAmount: entity.FormattedDiscountAmount,
		},
		CouponDiscountAmountFormatted: entity.CouponDiscountAmountFormatted,
		UsedPoints:                    entity.UsedPoints,
		PointsDiscountAmountFormatted: entity.PointsDiscountAmountFormatted,
		ShippingFeeFormatted:          entity.ShippingFeeFormatted,
		TotalAmountFormatted:          entity.TotalAmountFormatted,
		CartSubtotalAmount:            entity.CartSubtotalAmount,
		CouponDiscountAmount:          entity.CouponDiscountAmount,
		PointsDiscountAmount:          entity.PointsDiscountAmount,
		ShippingFee:                   entity.ShippingFee,
		TotalAmount:                   entity.TotalAmount,
	}

	userpoints := &dto.UserPointInfo{}
	global.GVA_DB.Table("user_points").Select("available_points").
		Where("user_id = ?", id).First(&userpoints)

	availableCoupons := []dto.AvailableCouponInfo{}
	global.GVA_DB.Table("coupons").Select(`coupon_id,coupon_code,name,description,
case
	when discount_type = 'percentage' and max_discount_amount is not null then CONCAT(discount_value, '%OFF （最大',FORMAT(max_discount_amount, 0),'円引）')
    when discount_type = 'percentage' and max_discount_amount is null then CONCAT(discount_value, '%OFF')
    when discount_type = 'fixed' then CONCAT(FORMAT(discount_value, 0), '円引き')
end as discount_text`).
		Joins("join user_coupons on coupon_id = coupons.id").
		Where("user_id = ? and min_purchase_amount <= ?", id, entity.TotalAmount).
		Find(&availableCoupons)

	checkoutInfoResponse.AvailableCoupons = availableCoupons
	checkoutInfoResponse.UserPoints = userpoints
	checkoutInfoResponse.CartItems = cartInfo.Items

	return checkoutInfoResponse, err
}

func (ordersService *OrdersService) ApplyCoupon(id uint, couponReq dto.ApplyCouponRequest) (res *dto.CheckoutInfoResponse, err error) {
	res, _ = ordersService.GetInfo(id)
	coupon := &dto.Coupon{}
	result := global.GVA_DB.Table("coupons").Select("*").Where("coupon_code = ?", couponReq.CouponCode).
		Find(&coupon)
	if result.Error != nil {
		return nil, result.Error
	}
	if !coupon.IsActive {
		return nil, response.ErrCouponInvalid
	}
	if time.Now().After(coupon.EndDate) || time.Now().Before(coupon.StartDate) {
		return nil, response.ErrCouponExpired
	}
	if res.CurrentCheckoutState.TotalAmount < coupon.MinPurchaseAmount {
		return nil, response.ErrCouponMinPurchase
	}

	userCoupon := &dto.UserCoupon{}
	result = global.GVA_DB.Table("user_coupons").Select("*").
		Where("user_id = ? and coupon_id = ?", id, res.CurrentCheckoutState.AppliedCouponInfo.CouponID).
		Find(&userCoupon)
	if result.Error != nil || userCoupon.IsUsed {
		return nil, response.ErrCouponInvalid
	}

	if coupon.DiscountType == "fixed" {
		global.GVA_DB.Table("checkout_sessions").Where("user_id = ?", id).Updates(map[string]interface{}{
			"applied_coupon_id":      coupon.ID,
			"coupon_discount_amount": coupon.DiscountValue,
			"total_amount": res.CurrentCheckoutState.CartSubtotalAmount -
				coupon.DiscountValue - res.CurrentCheckoutState.PointsDiscountAmount + res.CurrentCheckoutState.ShippingFee,
			"last_updated_at": time.Now(),
		})
	}
	if coupon.DiscountType == "percentage" {
		var coupon_discount_amount float64
		calculated_discount := res.CurrentCheckoutState.CartSubtotalAmount * (coupon.DiscountValue / 100.00)
		if coupon.MaxDiscountAmount == 0 {
			coupon_discount_amount = calculated_discount
		} else {
			coupon_discount_amount = min(calculated_discount, coupon.MaxDiscountAmount)
		}

		global.GVA_DB.Table("checkout_sessions").Where("user_id = ?", id).Updates(map[string]interface{}{
			"applied_coupon_id":      coupon.ID,
			"coupon_discount_amount": coupon_discount_amount,
			"total_amount": res.CurrentCheckoutState.CartSubtotalAmount -
				coupon_discount_amount - res.CurrentCheckoutState.PointsDiscountAmount + res.CurrentCheckoutState.ShippingFee,
			"last_updated_at": time.Now(),
		})
	}

	res, err = ordersService.GetInfo(id)

	return
}

func (ordersService *OrdersService) RemoveCoupon(id uint) (res *dto.CheckoutInfoResponse, err error) {
	entity := &dto.CurrentCheckoutStateEntity{}
	//現在の cart_subtotal, applied_coupon_id, 既存の used_points, points_discount_amount, shipping_fee を取得
	global.GVA_DB.Table("checkout_sessions").
		Select(`cart_subtotal as cart_subtotal_amount, points_discount_amount,shipping_fee,used_points,
                        applied_coupon_id as coupon_id`).
		Where("user_id = ?", id).Limit(1).Find(&entity)
	if entity.CouponID == 0 {
		res, _ = ordersService.GetInfo(id)
		return
	}
	// checkout_sessions テーブルを更新
	global.GVA_DB.Table("checkout_sessions").Where("user_id = ?", id).Updates(map[string]interface{}{
		"applied_coupon_id":      nil,
		"coupon_discount_amount": 0.00,
		"total_amount":           entity.CartSubtotalAmount - entity.PointsDiscountAmount + entity.ShippingFee,
		"last_updated_at":        time.Now(),
	})
	//最新チェックアウト情報取得
	res, _ = ordersService.GetInfo(id)

	return
}

func (ordersService *OrdersService) UsePoints(id uint, pointsReq dto.UsePointsRequest) (res *dto.CheckoutInfoResponse, err error) {
	res, _ = ordersService.GetInfo(id)
	userPointInfo := &dto.UserPointInfo{}
	global.GVA_DB.Table("user_points").Select("available_points").
		Where("user_id = ?", id).Find(&userPointInfo)
	if userPointInfo.AvailablePoints < pointsReq.PointsToUse ||
		pointsReq.PointsToUse > int(res.CurrentCheckoutState.TotalAmount)-int(res.CurrentCheckoutState.CouponDiscountAmount)+int(res.CurrentCheckoutState.ShippingFee) {
		return nil, response.ErrInsufficientPoints
	}

	global.GVA_DB.Table("checkout_sessions").Where("user_id = ?", id).Updates(map[string]interface{}{
		"used_points":            pointsReq.PointsToUse,
		"points_discount_amount": pointsReq.PointsToUse,
		"total_amount": res.CurrentCheckoutState.CartSubtotalAmount -
			float64(pointsReq.PointsToUse) - res.CurrentCheckoutState.CouponDiscountAmount + res.CurrentCheckoutState.ShippingFee,
		"last_updated_at": time.Now(),
	})

	res, _ = ordersService.GetInfo(id)
	return
}

func (ordersService *OrdersService) RemovePoints(id uint) (res *dto.CheckoutInfoResponse, err error) {
	entity := &dto.CurrentCheckoutStateEntity{}
	//現在の cart_subtotal, 既存の applied_coupon_id, coupon_discount_amount, used_points (解除するポイント数), shipping_fee を取得
	global.GVA_DB.Table("checkout_sessions").
		Select(`cart_subtotal as cart_subtotal_amount, applied_coupon_id as coupon_id,shipping_fee,used_points,
                        coupon_discount_amount`).
		Where("user_id = ?", id).Limit(1).Find(&entity)
	if entity.UsedPoints == 0 {
		res, _ = ordersService.GetInfo(id)
		return
	}

	// checkout_sessions テーブルを更新
	global.GVA_DB.Table("checkout_sessions").Where("user_id = ?", id).Updates(map[string]interface{}{
		"used_points":            0,
		"points_discount_amount": 0.00,
		"total_amount":           entity.CartSubtotalAmount - entity.CouponDiscountAmount + entity.ShippingFee,
		"last_updated_at":        time.Now(),
	})
	//最新チェックアウト情報取得
	res, _ = ordersService.GetInfo(id)

	return
}

func (ordersService *OrdersService) OrderPay(id uint, orderReq dto.CreateOrderRequest) (res *dto.OrderInfo, err error) {
	session, _ := ordersService.GetInfo(id)

	skuidMap := make(map[string]int)
	var skuids []string
	for _, v := range session.CartItems {
		skuidMap[v.SkuID] = v.Quantity
		skuids = append(skuids, v.SkuID)
	}

	type SKUInventory struct {
		SKUID     string `gorm:"column:sku_id"`
		Inventory int    `gorm:"column:inventory"`
	}

	var inventory []SKUInventory
	err = global.GVA_DB.Table("inventory").Select(`sku_id,SUM(quantity - reserved_quantity) as inventory`).
		Where("sku_id in ?", skuids).
		Group("sku_id").Scan(&inventory).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}

	for _, v := range inventory {
		if v.Inventory < skuidMap[v.SKUID] {
			return nil, response.ErrInsufficientStock
		}
	}

	// 初始化 Pay.jp 客户端（建议用环境变量）
	client := payjp.New("sk_test_5ffdde2bf7cec1437979510c", nil)

	// 发起支付
	charge, err := client.Charge.Create(int(session.CurrentCheckoutState.TotalAmount), payjp.Charge{
		Currency:  "jpy",
		CardToken: *orderReq.PayjpToken,
		Capture:   true,
	})
	if err != nil {
		log.Println("Pay.jp error:", err)
		return nil, response.ErrPaymentGatewayFailed
	}

	tx := global.GVA_DB.Begin()
	if tx.Error != nil {
		return nil, tx.Error
	}
	defer func() {
		if r := recover(); r != nil { //recover函数捕获异常
			tx.Rollback()
			log.Println("Recoverd in OrderPay:", r)
		}
	}()

	//创建订单记录
	var coupon_ID *uint64 = nil
	if session.CurrentCheckoutState.AppliedCouponInfo != nil && session.CurrentCheckoutState.AppliedCouponInfo.CouponID != 0 {
		coupon_ID = &session.CurrentCheckoutState.AppliedCouponInfo.CouponID
	}
	orderCode := strconv.Itoa(int(id)) + time.Now().Format(time.RFC3339)
	order := &dto.Order{
		OrderCode:            orderCode,
		UserID:               uint64(id),
		OrderStatus:          "payment_confirmed",
		SubtotalAmount:       session.CurrentCheckoutState.CartSubtotalAmount,
		CouponID:             coupon_ID,
		CouponDiscountAmount: session.CurrentCheckoutState.CouponDiscountAmount,
		PointsUsed:           uint(session.CurrentCheckoutState.UsedPoints),
		PointsDiscountAmount: session.CurrentCheckoutState.PointsDiscountAmount,
		ShippingFee:          session.CurrentCheckoutState.ShippingFee,
		TotalAmount:          session.CurrentCheckoutState.TotalAmount,
		PayjpChargeID:        &charge.ID,
		OrderedAt:            time.Now(),
		PaidAt:               &charge.CapturedAt,
		Notes:                orderReq.Notes,
		CreatedAt:            time.Now(),
		UpdatedAt:            time.Now(),
	}
	err = tx.Table("orders").Create(&order).Error
	if err != nil {
		tx.Rollback()
		return nil, err
	}

	//创建订单item记录
	orderItems := []dto.OrderItem{}
	for _, v := range session.CartItems {
		orderItems = append(orderItems, dto.OrderItem{
			OrderID:       order.ID,
			ProductID:     v.ProductID,
			SkuID:         v.SkuID,
			ProductName:   v.ProductName,
			Quantity:      uint(v.Quantity),
			UnitPrice:     v.Price.Amount,
			SubtotalPrice: v.Price.Amount * float64(v.Quantity),
			CreatedAt:     time.Now(),
		})
	}
	err = tx.Table("order_items").Create(&orderItems).Error
	if err != nil {
		tx.Rollback()
		return nil, err
	}

	//在库更新
	for k, v := range skuidMap {
		err = tx.Exec(`
			UPDATE inventory
			SET quantity = quantity - ?,
				reserved_quantity = reserved_quantity + ?
			WHERE sku_id = ? 
			LIMIT 1
		`, v, v, k).Error
		if err != nil {
			tx.Rollback()
			return nil, err
		}
	}

	//クーポン使用記録更新
	if session.CurrentCheckoutState.AppliedCouponInfo.CouponID != 0 {
		err = tx.Table("user_coupons").
			Where("user_id = ? and coupon_id = ?", id, session.CurrentCheckoutState.AppliedCouponInfo.CouponID).
			Updates(map[string]interface{}{
				"is_used":  1,
				"order_id": order.ID,
			}).
			Error
		if err != nil {
			tx.Rollback()
			return nil, err
		}
	}

	//ポイント消費
	if session.CurrentCheckoutState.UsedPoints > 0 {
		err = tx.Table("user_points").Where("user_id = ? ", id).
			Update("available_points", gorm.Expr("available_points - ?", session.CurrentCheckoutState.UsedPoints)).Error
		if err != nil {
			tx.Rollback()
			return nil, err
		}
	}

	//user_cart_items テーブルクリア
	err = tx.Table("user_cart_items").Where("user_id = ?", id).Delete(nil).Error
	if err != nil {
		tx.Rollback()
		return nil, err
	}
	//checkout_sessions テーブルクリア
	err = tx.Table("checkout_sessions").Where("user_id = ?", id).Delete(nil).Error
	if err != nil {
		tx.Rollback()
		return nil, err
	}

	//操作成功，提交事务
	err = tx.Commit().Error
	if err != nil {
		return nil, err
	}

	//OrderInfo
	orderInfo := &dto.OrderInfo{
		OrderID:              order.ID,
		OrderCode:            order.OrderCode,
		OrderStatus:          order.OrderStatus,
		TotalAmount:          order.TotalAmount,
		FormattedTotalAmount: FormatPrice(order.TotalAmount) + "円",
		OrderedAtFormatted:   time.Now().Format("2006年01月02日 15时04分05秒"),
	}

	return orderInfo, err
}

func (ordersService *OrdersService) GetOrders(id uint, page int, limit int, status string) (res *dto.OrderListResponse, err error) {

	offset := (page - 1) * limit

	orders := []dto.OrderSummaryInfo{}
	if status == "" {
		global.GVA_DB.Table("orders").Select(`id as order_id, order_code,DATE_FORMAT(ordered_at, '%%Y年%%m月%%d日') as ordered_at_formatted,
	CONCAT(FORMAT(total_amount, 0), '円') as total_amount_formatted,order_status,
	case
		when order_status = 'pending_payment' then '待付款'
		when order_status = 'payment_confirmed' then '已付款'
		when order_status = 'delivered' then '配送中'
		when order_status = 'cancelled' then '已取消'
		when order_status = 'shipped' then '运输中'
		when order_status = 'processing' then '处理中'
	end as order_status_display`).
			Where("user_id = ?", id).
			Limit(limit).Offset(offset).Scan(&orders)
	} else {
		global.GVA_DB.Table("orders").Select(`id as order_id, order_code,DATE_FORMAT(ordered_at, '%%Y年%%m月%%d日') as ordered_at_formatted,
	CONCAT(FORMAT(total_amount, 0), '円') as total_amount_formatted,order_status,
	case
		when order_status = 'pending_payment' then '待付款'
		when order_status = 'payment_confirmed' then '已付款'
		when order_status = 'delivered' then '配送中'
		when order_status = 'cancelled' then '已取消'
		when order_status = 'shipped' then '运输中'
		when order_status = 'processing' then '处理中'
	end as order_status_display`).
			Where("user_id = ? and order_status = ?", id, status).
			Limit(limit).Offset(offset).Scan(&orders)
	}

	var totalCount int64
	err = global.GVA_DB.Table("orders").
		Where("user_id = ? and order_status = ?", id, status).Count(&totalCount).Error
	if err != nil {
		return
	}
	pagenation := dto.PaginationInfo{
		CurrentPage: page,
		Limit:       limit,
		TotalCount:  int(totalCount),
		TotalPages:  int(math.Ceil(float64(totalCount) / float64(limit))),
	}

	resOrderList := &dto.OrderListResponse{}
	resOrderList.Orders = orders
	resOrderList.Pagination = pagenation

	return resOrderList, err
}

func (ordersService *OrdersService) GetOrderDetail(id uint, orderId string) (res *dto.OrderDetailResponse, err error) {
	entity := []dto.OrderDetailEntity{}
	result := global.GVA_DB.Table("orders o").
		Select(`o.id as order_id, order_code,DATE_FORMAT(ordered_at, '%%Y年%%m月%%d日') as ordered_at_formatted,order_status,
	case
		when order_status = 'pending_payment' then '待付款'
		when order_status = 'payment_confirmed' then '已付款'
		when order_status = 'delivered' then '配送中'
		when order_status = 'cancelled' then '已取消'
		when order_status = 'shipped' then '运输中'
		when order_status = 'processing' then '处理中'
	end as order_status_display,
	CONCAT(FORMAT(subtotal_amount, 0), '円') as subtotal_amount_formatted,
	CONCAT(FORMAT(coupon_discount_amount, 0), '円') as coupon_discount_amount_formatted,
	CONCAT(FORMAT(points_discount_amount, 0), '円') as points_discount_amount_formatted,
	CONCAT(FORMAT(shipping_fee, 0), '円') as shipping_fee_formatted,
	CONCAT(FORMAT(total_amount, 0), '円') as total_amount_formatted,
	c.name as applied_coupon_name,points_used,'クレジットカード' as payment_method_name,
	payjp_charge_id,notes,oi.sku_id as sku_id,product_id,product_name,sku_code,quantity,
	CONCAT(FORMAT(unit_price, 0), '円') as unit_price_formatted,
	CONCAT(FORMAT(subtotal_price, 0), '円') as subtotal_formatted,
	si.thumbnail_url as primary_image_url,
	a.id AS attribute_id, a.name AS attribute_name,
								CASE a.input_type
									WHEN 'select' THEN ao.value
									WHEN 'text' THEN sv.value_string
									WHEN 'number' THEN sv.value_number
									WHEN 'boolean' THEN sv.value_boolean
									WHEN 'textarea' THEN sv.value_text
									ELSE NULL
								END AS value`).
		Where("user_id = ? and o.id = ?", id, orderId).
		Joins("left join order_items oi on o.id = oi.order_id").
		Joins("left join coupons c on c.id = o.coupon_id").
		Joins("left join sku_images si on si.sku_id = oi.sku_id").
		Joins("left join sku_values sv on sv.sku_id = oi.sku_id").
		Joins("left join attributes a on a.id = sv.attribute_id").
		Joins("left join attribute_options ao on a.id = ao.attribute_id").Scan(&entity)
	if result.Error != nil {
		return nil, result.Error
	}

	orderRes := &dto.OrderDetailResponse{
		OrderInfo: &dto.OrderHeaderInfo{},
	}
	orderRes.OrderInfo.OrderID = entity[0].OrderID
	orderRes.OrderInfo.OrderCode = entity[0].OrderCode
	orderRes.OrderInfo.OrderedAtFormatted = entity[0].OrderedAtFormatted
	orderRes.OrderInfo.OrderStatus = entity[0].OrderStatus
	orderRes.OrderInfo.OrderStatusDisplay = entity[0].OrderStatusDisplay
	orderRes.OrderInfo.SubtotalAmountFormatted = entity[0].SubtotalAmountFormatted
	orderRes.OrderInfo.CouponDiscountAmountFormatted = entity[0].CouponDiscountAmountFormatted
	orderRes.OrderInfo.PointsDiscountAmountFormatted = entity[0].PointsDiscountAmountFormatted
	orderRes.OrderInfo.ShippingFeeFormatted = entity[0].ShippingFeeFormatted
	orderRes.OrderInfo.TotalAmountFormatted = entity[0].TotalAmountFormatted
	orderRes.OrderInfo.AppliedCouponName = entity[0].AppliedCouponName
	orderRes.OrderInfo.PointsUsed = entity[0].PointsUsed
	orderRes.OrderInfo.PaymentMethodName = entity[0].PaymentMethodName
	orderRes.OrderInfo.PayjpChargeID = entity[0].PayjpChargeID
	orderRes.OrderInfo.Notes = entity[0].Notes

	orderItemsMap := make(map[uint64]*dto.OrderDetailItemInfo)
	attributeMap := make(map[uint64]map[int]struct{})
	for _, v := range entity {
		if _, ok := orderItemsMap[v.OrderID]; !ok {
			orderItemsMap[v.OrderID] = &dto.OrderDetailItemInfo{
				SkuID:              v.SkuID,
				ProductID:          v.ProductID,
				ProductName:        v.ProductName,
				SkuCode:            v.SkuCode,
				Quantity:           v.Quantity,
				UnitPriceFormatted: v.UnitPriceFormatted,
				SubtotalFormatted:  v.SubtotalFormatted,
				PrimaryImageURL:    v.PrimaryImageURL,
				Attributes:         []dto.AttributeInfo{},
			}
			attributeMap[v.OrderID] = make(map[int]struct{})
		}
		if _, ok := attributeMap[v.OrderID][v.AttributeID]; !ok {
			orderItemsMap[v.OrderID].Attributes = append(orderItemsMap[v.OrderID].Attributes, dto.AttributeInfo{
				AttributeID:   v.AttributeID,
				AttributeName: v.AttributeName,
				Value:         v.Value,
			})
			attributeMap[v.OrderID][v.AttributeID] = struct{}{}
		}
	}

	for _, v := range orderItemsMap {
		orderRes.OrderItems = append(orderRes.OrderItems, *v)
	}

	return orderRes, err
}
