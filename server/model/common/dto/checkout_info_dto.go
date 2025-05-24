package dto

import "time"

// CheckoutInfoResponseV1_1 クーポン・ポイント情報取得APIのルートレスポンス (修正版)
type CheckoutInfoResponse struct {
	AvailableCoupons     []AvailableCouponInfo `json:"available_coupons"`
	UserPoints           *UserPointInfo        `json:"user_points,omitempty"`
	CurrentCheckoutState *CurrentCheckoutState `json:"current_checkout_state"`
	CartItems            []CartItemInfo        `json:"cart_items"`
}

// AvailableCouponInfo 利用可能なクーポン情報
type AvailableCouponInfo struct {
	CouponID     uint64  `json:"coupon_id"`
	CouponCode   string  `json:"coupon_code"`
	Name         string  `json:"name"`
	Description  *string `json:"description,omitempty"`
	DiscountText string  `json:"discount_text"` // 例: "10% OFF (最大2,000円引)", "500円引き"
}

// UserPointInfo ユーザー保有ポイント情報
type UserPointInfo struct {
	AvailablePoints int `json:"available_points"`
}

// CurrentCheckoutState 現在のチェックアウト状態を表すDTO
type CurrentCheckoutState struct {
	CartSubtotalAmountFormatted   string             `json:"cart_subtotal_formatted"`          // カート商品小計 (割引前、表示用)
	AppliedCouponInfo             *AppliedCouponInfo `json:"applied_coupon_info,omitempty"`    // 適用中クーポン情報 (Nullable)
	CouponDiscountAmountFormatted string             `json:"coupon_discount_amount_formatted"` // クーポン割引額 (表示用)
	UsedPoints                    int                `json:"used_points"`                      // 利用ポイント数
	PointsDiscountAmountFormatted string             `json:"points_discount_amount_formatted"` // ポイント割引額 (表示用)
	ShippingFeeFormatted          string             `json:"shipping_fee_formatted"`           // 送料 (表示用、別途計算の場合あり)
	TotalAmountFormatted          string             `json:"total_amount_formatted"`           // ★最終支払総額 (表示用)

	// 内部計算用の数値も保持 (JSONには含めないか、開発用に含めるかは選択)
	CartSubtotalAmount   float64 `json:"-"`
	CouponDiscountAmount float64 `json:"-"`
	PointsDiscountAmount float64 `json:"-"`
	ShippingFee          float64 `json:"-"`
	TotalAmount          float64 `json:"-"`
}

// AppliedCouponInfo 適用中クーポン情報
type AppliedCouponInfo struct {
	CouponID                uint64  `json:"coupon_id"`
	CouponCode              string  `json:"coupon_code"`
	Name                    string  `json:"name"`
	DiscountAmount          float64 `json:"discount_amount"`           // この注文での実際の割引額 (計算用)
	FormattedDiscountAmount string  `json:"formatted_discount_amount"` // 表示用
}

// CreateOrderRequest 注文確定APIのリクエストボディ
type CreateOrderRequest struct {
	PayjpToken *string `json:"payjp_token" binding:"required"` // クレジットカード支払いの場合は必須
	Notes      *string `json:"notes,omitempty"`
}

// OrderInfo 作成された注文情報のDTO
type OrderInfo struct {
	OrderID              uint64  `json:"order_id"`
	OrderCode            string  `json:"order_code"`
	OrderStatus          string  `json:"order_status"`
	TotalAmount          float64 `json:"total_amount"`           // 支払総額 (計算用数値)
	FormattedTotalAmount string  `json:"formatted_total_amount"` // 表示用支払総額
	OrderedAtFormatted   string  `json:"ordered_at_formatted"`   // 表示用注文日時
}

// ApplyCouponRequest クーポン適用APIのリクエストボディ
type ApplyCouponRequest struct {
	CouponCode string `json:"coupon_code" binding:"required"`
}

// UsePointsRequest ポイント利用APIのリクエストボディ
type UsePointsRequest struct {
	PointsToUse int `json:"points_to_use" binding:"required,min=1"`
}

type CurrentCheckoutStateEntity struct {
	CartSubtotalAmountFormatted   string  `json:"cart_subtotal_formatted"` // カート商品小計 (割引前、表示用)
	CouponID                      uint64  `json:"coupon_id"`
	CouponCode                    string  `json:"coupon_code"`
	Name                          string  `json:"name"`
	DiscountAmount                float64 `json:"discount_amount"`                  // この注文での実際の割引額 (計算用)
	FormattedDiscountAmount       string  `json:"formatted_discount_amount"`        // 表示用
	CouponDiscountAmountFormatted string  `json:"coupon_discount_amount_formatted"` // クーポン割引額 (表示用)
	UsedPoints                    int     `json:"used_points"`                      // 利用ポイント数
	PointsDiscountAmountFormatted string  `json:"points_discount_amount_formatted"` // ポイント割引額 (表示用)
	ShippingFeeFormatted          string  `json:"shipping_fee_formatted"`           // 送料 (表示用、別途計算の場合あり)
	TotalAmountFormatted          string  `json:"total_amount_formatted"`           // ★最終支払総額 (表示用)

	// 内部計算用の数値も保持 (JSONには含めないか、開発用に含めるかは選択)
	CartSubtotalAmount   float64 `json:"-"`
	CouponDiscountAmount float64 `json:"-"`
	PointsDiscountAmount float64 `json:"-"`
	ShippingFee          float64 `json:"-"`
	TotalAmount          float64 `json:"-"`
}

type Coupon struct {
	ID                uint64    `gorm:"primaryKey;autoIncrement;column:id" json:"id"`
	CouponCode        string    `gorm:"type:varchar(50);column:coupon_code" json:"coupon_code"`
	Name              string    `gorm:"type:varchar(255);column:name" json:"name"`
	Description       string    `gorm:"type:text;column:description" json:"description"`
	DiscountType      string    `gorm:"type:enum('fixed','percentage');column:discount_type" json:"discount_type"` // 可使用 string 映射 enum 类型
	DiscountValue     float64   `gorm:"type:decimal(10,2);column:discount_value" json:"discount_value"`
	MinPurchaseAmount float64   `gorm:"type:decimal(12,2);column:min_purchase_amount" json:"min_purchase_amount"`
	MaxDiscountAmount float64   `gorm:"type:decimal(10,2);column:max_discount_amount" json:"max_discount_amount"`
	StartDate         time.Time `gorm:"type:datetime;column:start_date" json:"start_date"`
	EndDate           time.Time `gorm:"type:datetime;column:end_date" json:"end_date"`
	UsageLimitPerUser uint      `gorm:"type:int unsigned;column:usage_limit_per_user" json:"usage_limit_per_user"`
	TotalUsageLimit   uint      `gorm:"type:int unsigned;column:total_usage_limit" json:"total_usage_limit"`
	IsActive          bool      `gorm:"type:tinyint(1);column:is_active" json:"is_active"`
	CreatedAt         time.Time `gorm:"column:created_at" json:"created_at"`
	UpdatedAt         time.Time `gorm:"column:updated_at" json:"updated_at"`
}

// TableName 自定义表名
func (Coupon) TableName() string {
	return "coupons"
}

type UserCoupon struct {
	ID         uint64     `gorm:"primaryKey;autoIncrement;column:id" json:"id"`
	UserID     uint64     `gorm:"column:user_id;not null" json:"user_id"`
	CouponID   uint64     `gorm:"column:coupon_id;not null" json:"coupon_id"`
	IsUsed     bool       `gorm:"column:is_used;type:tinyint(1)" json:"is_used"`
	UsedAt     *time.Time `gorm:"column:used_at" json:"used_at"`         // 使用时间，可为 NULL
	ObtainedAt time.Time  `gorm:"column:obtained_at" json:"obtained_at"` // 领取时间
}

// TableName 自定义表名
func (UserCoupon) TableName() string {
	return "user_coupons"
}

type Order struct {
	ID                   uint64     `gorm:"primaryKey;autoIncrement;comment:注文ID"`
	OrderCode            string     `gorm:"size:50;unique;not null;comment:注文コード"`
	UserID               uint64     `gorm:"not null;comment:購入ユーザーID"`
	OrderStatus          string     `gorm:"type:enum('pending_payment','payment_confirmed','processing','shipped','delivered','cancelled','refunded');default:'pending_payment';not null;comment:注文ステータス"`
	SubtotalAmount       float64    `gorm:"type:decimal(12,2);not null;comment:商品小計"`
	CouponID             *uint64    `gorm:"comment:使用クーポンID"`
	CouponDiscountAmount float64    `gorm:"type:decimal(10,2);not null;default:0.00;comment:クーポン割引額"`
	PointsUsed           uint       `gorm:"not null;default:0;comment:利用ポイント数"`
	PointsDiscountAmount float64    `gorm:"type:decimal(10,2);not null;default:0.00;comment:ポイントによる割引額"`
	ShippingFee          float64    `gorm:"type:decimal(10,2);not null;default:0.00;comment:送料"`
	TotalAmount          float64    `gorm:"type:decimal(12,2);not null;comment:支払総額"`
	PayjpChargeID        *string    `gorm:"size:255;unique;comment:Pay.jp 支払いID"`
	OrderedAt            time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP;comment:注文日時"`
	PaidAt               *time.Time `gorm:"comment:支払い完了日時"`
	CancelledAt          *time.Time `gorm:"comment:キャンセル日時"`
	Notes                *string    `gorm:"type:text;comment:備考欄"`
	CreatedAt            time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt            time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"`

	OrderItems          []OrderItem          `gorm:"foreignKey:OrderID"`
	PaymentTransactions []PaymentTransaction `gorm:"foreignKey:OrderID"`
}

type OrderItem struct {
	ID            uint64    `gorm:"primaryKey;autoIncrement;comment:注文明細ID"`
	OrderID       uint64    `gorm:"not null;comment:注文ID"`
	ProductID     string    `gorm:"type:char(36);not null;comment:商品ID"`
	SkuID         string    `gorm:"type:char(36);not null;comment:SKU ID"`
	ProductName   string    `gorm:"size:255;not null;comment:商品名"`
	SKUCode       *string   `gorm:"size:150;comment:SKUコード"`
	Quantity      uint      `gorm:"not null;comment:数量"`
	UnitPrice     float64   `gorm:"type:decimal(12,2);not null;comment:単価"`
	SubtotalPrice float64   `gorm:"type:decimal(12,2);not null;comment:小計"`
	CreatedAt     time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

type PaymentTransaction struct {
	ID              uint64    `gorm:"primaryKey;autoIncrement;comment:トランザクションID"`
	OrderID         uint64    `gorm:"not null;comment:注文ID"`
	PaymentGateway  string    `gorm:"size:50;not null;default:'payjp';comment:支払いゲートウェイ名"`
	TransactionID   string    `gorm:"size:255;unique;not null;comment:ゲートウェイID"`
	TransactionType string    `gorm:"type:enum('charge','refund','capture');not null;comment:種別"`
	Amount          float64   `gorm:"type:decimal(12,2);not null;comment:金額"`
	Currency        string    `gorm:"type:char(3);not null;default:'JPY';comment:通貨"`
	Status          string    `gorm:"type:enum('succeeded','pending','failed','expired','captured','refunded');not null;comment:ステータス"`
	RawResponse     *string   `gorm:"type:text;comment:レスポンス"`
	CreatedAt       time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt       time.Time `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"`
}
