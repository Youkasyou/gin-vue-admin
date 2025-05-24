package dto

// OrderListResponse 注文履歴一覧APIのルートレスポンス
type OrderListResponse struct {
	Orders     []OrderSummaryInfo `json:"orders"`
	Pagination PaginationInfo     `json:"pagination"`
}

// OrderSummaryInfo 注文履歴一覧の各注文概要
type OrderSummaryInfo struct {
	OrderID                uint64  `json:"order_id"`
	OrderCode              string  `json:"order_code"`
	OrderedAtFormatted     string  `json:"ordered_at_formatted"`
	TotalAmountFormatted   string  `json:"total_amount_formatted"`
	OrderStatus            string  `json:"order_status"`                       // 注文ステータスコード
	OrderStatusDisplay     string  `json:"order_status_display"`               // 注文ステータス表示名
	RepresentativeImageURL *string `json:"representative_image_url,omitempty"` // 代表商品画像
}

// OrderDetailResponse 注文詳細取得APIのルートレスポンス
type OrderDetailResponse struct {
	OrderInfo  *OrderHeaderInfo      `json:"order_info"`
	OrderItems []OrderDetailItemInfo `json:"order_items"`
}

// OrderHeaderInfo 注文詳細のヘッダ情報
type OrderHeaderInfo struct {
	OrderID                       uint64  `json:"order_id"`
	OrderCode                     string  `json:"order_code"`
	OrderedAtFormatted            string  `json:"ordered_at_formatted"`
	OrderStatus                   string  `json:"order_status"`
	OrderStatusDisplay            string  `json:"order_status_display"`
	SubtotalAmountFormatted       string  `json:"subtotal_amount_formatted"` // 商品小計 (割引適用後)
	CouponDiscountAmountFormatted string  `json:"coupon_discount_amount_formatted"`
	PointsDiscountAmountFormatted string  `json:"points_discount_amount_formatted"`
	ShippingFeeFormatted          string  `json:"shipping_fee_formatted"` // 固定送料
	TotalAmountFormatted          string  `json:"total_amount_formatted"`
	AppliedCouponName             *string `json:"applied_coupon_name,omitempty"` // 適用クーポン名
	PointsUsed                    int     `json:"points_used"`
	PaymentMethodName             string  `json:"payment_method_name"`       // 固定: "クレジットカード"
	PayjpChargeID                 *string `json:"payjp_charge_id,omitempty"` // Pay.jp取引ID
	Notes                         *string `json:"notes,omitempty"`
	// (配送先情報は含めない)
}

// OrderDetailItemInfo 注文詳細の商品明細情報
type OrderDetailItemInfo struct {
	SkuID              string          `json:"sku_id"`
	ProductID          string          `json:"product_id"`
	ProductName        string          `json:"product_name"` // 省略後
	SkuCode            *string         `json:"sku_code,omitempty"`
	Quantity           int             `json:"quantity"`
	UnitPriceFormatted string          `json:"unit_price_formatted"` // 単価 (表示用)
	SubtotalFormatted  string          `json:"subtotal_formatted"`   // 小計 (表示用)
	PrimaryImageURL    *string         `json:"primary_image_url,omitempty"`
	Attributes         []AttributeInfo `json:"attributes"`
}

type OrderDetailEntity struct {
	OrderID                       uint64  `json:"order_id"`
	OrderCode                     string  `json:"order_code"`
	OrderedAtFormatted            string  `json:"ordered_at_formatted"`
	OrderStatus                   string  `json:"order_status"`
	OrderStatusDisplay            string  `json:"order_status_display"`
	SubtotalAmountFormatted       string  `json:"subtotal_amount_formatted"` // 商品小計 (割引適用後)
	CouponDiscountAmountFormatted string  `json:"coupon_discount_amount_formatted"`
	PointsDiscountAmountFormatted string  `json:"points_discount_amount_formatted"`
	ShippingFeeFormatted          string  `json:"shipping_fee_formatted"` // 固定送料
	TotalAmountFormatted          string  `json:"total_amount_formatted"`
	AppliedCouponName             *string `json:"applied_coupon_name,omitempty"` // 適用クーポン名
	PointsUsed                    int     `json:"points_used"`
	PaymentMethodName             string  `json:"payment_method_name"`       // 固定: "クレジットカード"
	PayjpChargeID                 *string `json:"payjp_charge_id,omitempty"` // Pay.jp取引ID
	Notes                         *string `json:"notes,omitempty"`
	SkuID                         string  `json:"sku_id"`
	ProductID                     string  `json:"product_id"`
	ProductName                   string  `json:"product_name"` // 省略後
	SkuCode                       *string `json:"sku_code,omitempty"`
	Quantity                      int     `json:"quantity"`
	UnitPriceFormatted            string  `json:"unit_price_formatted"` // 単価 (表示用)
	SubtotalFormatted             string  `json:"subtotal_formatted"`   // 小計 (表示用)
	PrimaryImageURL               *string `json:"primary_image_url,omitempty"`
	AttributeID                   int     `json:"attribute_id"`
	AttributeName                 string  `json:"attribute_name"`
	Value                         *string `json:"value"`
}
