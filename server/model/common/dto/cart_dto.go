package dto

// CartResponse カート内容取得APIのルートレスポンス
type CartResponse struct {
	Items                []CartItemInfo `json:"items"`                  // カート内商品リスト
	TotalItemsCount      int            `json:"total_items_count"`      // カート内総商品点数 (数量の合計)
	TotalAmount          float64        `json:"total_amount"`           // 合計金額 (計算用数値)
	TotalAmountFormatted string         `json:"total_amount_formatted"` // 合計金額 (表示用文字列 例: "55,880円")
}

// CartItemInfo カート内の個々の商品情報
type CartItemInfo struct {
	SkuID             string          `json:"sku_id"`                  // SKU ID
	ProductID         string          `json:"product_id"`              // 商品ID
	ProductName       string          `json:"product_name"`            // 商品名 (省略後)
	ProductCode       string          `json:"product_code,omitempty"`  // 商品コード
	Quantity          int             `json:"quantity"`                // カート内の数量
	Price             *PriceInfo      `json:"price"`                   // 現在の単価情報 (Nullable)
	SubtotalFormatted string          `json:"subtotal_formatted"`      // 小計 (表示用文字列 例: "7,980円")
	PrimaryImage      *ImageInfo      `json:"primary_image,omitempty"` // サムネイル画像推奨 (Nullable)
	Attributes        []AttributeInfo `json:"attributes"`              // 対象SKUの属性リスト
	StockStatus       string          `json:"stock_status"`            // 在庫状況コード ('available', 'low_stock', 'out_of_stock')
}
