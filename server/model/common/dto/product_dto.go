package dto

// ProductInfoResponse
type ProductInfoResponse struct {
	ID              string               `json:"id"`
	ProductCode     string               `json:"product_code"`
	Name            string               `json:"name"`
	Description     *string              `json:"description"`
	IsTaxable       bool                 `json:"is_taxable"`
	MetaTitle       *string              `json:"meta_title"`
	MetaDescription *string              `json:"meta_description"`
	TargetSKUInfo   *TargetSKUInfo       `json:"target_sku_info"`
	VariantOptions  []VariantOptionGroup `json:"variant_options"`
	Category        *CategoryInfo        `json:"category,omitempty"`
	Brand           *BrandInfo           `json:"brand,omitempty"`
}

// TargetSKUInfo
type TargetSKUInfo struct {
	SkuID        string          `json:"sku_id"`
	Price        *PriceInfo      `json:"price"`
	PrimaryImage *ImageInfo      `json:"primary_image"`
	Attributes   []AttributeInfo `json:"attributes"`
}

// PriceInfo
type PriceInfo struct {
	Amount                  float64  `json:"amount"`
	FormattedAmount         string   `json:"formatted_amount"`
	Type                    string   `json:"type"`
	TypeName                string   `json:"type_name"`
	OriginalAmount          *float64 `json:"original_amount"`
	FormattedOriginalAmount *string  `json:"formatted_original_amount"`
}

// ImageInfo
type ImageInfo struct {
	ID      int     `json:"id"`
	URL     string  `json:"url"`
	AltText *string `json:"alt_text"`
}

// AttributeInfo
type AttributeInfo struct {
	AttributeID   int     `json:"attribute_id"`
	AttributeName string  `json:"attribute_name"`
	Value         *string `json:"value"`
}

// VariantOptionGroup
type VariantOptionGroup struct {
	AttributeID   int             `json:"attribute_id"`
	AttributeName string          `json:"attribute_name"`
	AttributeCode string          `json:"attribute_code"`
	DisplayType   string          `json:"display_type"`
	Options       []VariantOption `json:"options"`
}

// VariantOption (修正: LinkedSkuIDs 追加)
type VariantOption struct {
	OptionID     int      `json:"option_id"`
	OptionValue  string   `json:"option_value"`
	OptionCode   string   `json:"option_code"`
	ImageURL     *string  `json:"image_url"`
	LinkedSkuIDs []string `json:"linked_sku_ids"` // ★紐づく有効SKU IDリスト
}

// CategoryInfo
type CategoryInfo struct {
	ID                int      `json:"id"`
	Name              string   `json:"name"`
	Level             int      `json:"level"`
	ParentID          *int     `json:"parent_id"`
	SameLevelCategory []string `json:"same_level_category"`
}

// BrandInfo
type BrandInfo struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// ErrorResponse
type ErrorResponse struct {
	Error ErrorDetail `json:"error"`
}
type ErrorDetail struct {
	Code    string `json:"code"`
	Message string `json:"message"`
	Target  string `json:"target"`
}
