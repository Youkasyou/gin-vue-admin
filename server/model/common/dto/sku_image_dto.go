package dto

// SKUImageInfo SKU画像ペア情報のDTO構造体
type SKUImageInfo struct {
	ID           int     `json:"id"`                 // 画像ペアID
	MainImageURL string  `json:"main_image_url"`     // メイン画像URL
	ThumbnailURL string  `json:"thumbnail_url"`      // サムネイル画像URL
	AltText      *string `json:"alt_text,omitempty"` // 代替テキスト (Nullable)
	SortOrder    int     `json:"sort_order"`         // 表示順
	// ImageType     *string `json:"image_type,omitempty"`  // オプション: 更なる分類が必要な場合
}

// SKUImageListResponse APIレスポンス (直接配列を返す場合は不要)
type SKUImageListResponse struct {
	Images []SKUImageInfo `json:"images"`
}
