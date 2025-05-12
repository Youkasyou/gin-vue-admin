package dto

// ★ DTO構造体名をバージョンアップ等で変更推奨 (例: V1_1) ★

// ViewedSKUListResponseV1_1 閲覧履歴リストAPIのルートレスポンス (修正版)
type ViewedSKUListResponse struct {
	History    []ViewedSKUInfo `json:"history"`    // 閲覧履歴SKUリスト
	Pagination PaginationInfo  `json:"pagination"` // ページネーション情報
}

// ViewedSKUInfoV1_1 個々の閲覧履歴SKU情報 (修正版)
type ViewedSKUInfo struct {
	SkuID               string             `json:"sku_id"`                   // SKU ID
	ProductID           string             `json:"product_id"`               // 商品ID
	ProductName         string             `json:"product_name"`             // 商品名 (省略後)
	ProductCode         string             `json:"product_code,omitempty"`   // 商品コード
	PriceRangeFormatted string             `json:"price_range_formatted"`    // ★ 商品の価格帯文字列
	PrimaryImage        *ImageInfo         `json:"primary_image,omitempty"`  // サムネイル画像推奨 (Nullable)
	ReviewSummary       *ReviewSummaryInfo `json:"review_summary,omitempty"` // ★ 商品のレビュー集計情報 (Nullable)
	ViewedAtFormatted   string             `json:"viewed_at_formatted"`      // 最終閲覧日時 (表示用)
}
