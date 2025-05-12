package products

import (
	"encoding/json"
	"time"
)

// Category 商品カテゴリ階層
type Category struct {
	ID          int       `gorm:"primaryKey;comment:カテゴリID (手動割当)"`
	Name        string    `gorm:"size:255;not null;comment:カテゴリ名"`
	Description *string   `gorm:"type:text;comment:カテゴリ説明"`
	ParentID    *int      `gorm:"comment:親カテゴリID (NULLの場合はトップレベル)"`
	Level       int       `gorm:"not null;comment:階層レベル (0始まり)"`
	SortOrder   int       `gorm:"default:0;comment:表示順"`
	IsActive    bool      `gorm:"not null;default:true;comment:有効なカテゴリか"`
	CreatedAt   time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt   time.Time `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`

	Parent     *Category   `gorm:"foreignKey:ParentID"`
	Children   []Category  `gorm:"foreignKey:ParentID"`
	Products   []Product   `gorm:"foreignKey:CategoryID"`
	Attributes []Attribute `gorm:"many2many:category_attributes;foreignKey:ID;joinForeignKey:CategoryID;References:ID;joinReferences:AttributeID"`
}

// Attribute 属性定義
type Attribute struct {
	ID            int       `gorm:"primaryKey;comment:属性ID (手動割当)"`
	Name          string    `gorm:"size:255;not null;comment:属性名 (例: カラー, サイズ)"`
	AttributeCode string    `gorm:"size:100;not null;unique;comment:属性コード (例: color, size, material)"`
	InputType     string    `gorm:"type:enum('select','text','number','boolean','textarea');not null;comment:入力形式"`
	IsFilterable  bool      `gorm:"not null;default:false;comment:絞り込み検索対象か"`
	IsComparable  bool      `gorm:"not null;default:false;comment:商品比較対象か"`
	SortOrder     int       `gorm:"default:0;comment:表示順"`
	CreatedAt     time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt     time.Time `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`

	Options    []AttributeOption `gorm:"foreignKey:AttributeID"`
	Categories []Category        `gorm:"many2many:category_attributes;foreignKey:ID;joinForeignKey:AttributeID;References:ID;joinReferences:CategoryID"`
	SkuValues  []SkuValue        `gorm:"foreignKey:AttributeID"`
}

// AttributeOption 属性選択肢
type AttributeOption struct {
	ID          int       `gorm:"primaryKey;comment:属性選択肢ID (手動割当)"`
	AttributeID int       `gorm:"not null;comment:属性ID (input_typeがselectの場合)"`
	Value       string    `gorm:"size:255;not null;comment:表示値 (例: レッド, Mサイズ)"`
	OptionCode  string    `gorm:"size:100;not null;comment:選択肢コード (例: red, size_m)"`
	SortOrder   int       `gorm:"default:0;comment:表示順"`
	CreatedAt   time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt   time.Time `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`

	Attribute Attribute  `gorm:"foreignKey:AttributeID"`
	SkuValues []SkuValue `gorm:"foreignKey:OptionID"`
}

// PriceType 価格種別マスタ
type PriceType struct {
	ID       int    `gorm:"primaryKey;comment:価格種別ID (手動割当)"`
	TypeCode string `gorm:"size:50;not null;unique;comment:価格種別コード (例: regular, sale, member_special)"`
	Name     string `gorm:"size:100;not null;comment:価格種別名"`

	Prices []Price `gorm:"foreignKey:PriceTypeID"`
}

// InventoryLocation 在庫拠点マスタ
type InventoryLocation struct {
	ID           int    `gorm:"primaryKey;comment:在庫拠点ID (手動割当)"`
	LocationCode string `gorm:"size:50;not null;unique;comment:拠点コード (例: WAREHOUSE_EAST, STORE_SHIBUYA)"`
	Name         string `gorm:"size:100;not null;comment:拠点名"`
	LocationType string `gorm:"type:enum('warehouse','store','distribution_center');not null;comment:拠点タイプ"`

	Inventories []Inventory `gorm:"foreignKey:LocationID"`
}

// SalesChannel 販売チャネルマスタ
type SalesChannel struct {
	ID          int    `gorm:"primaryKey;comment:販売チャネルID (手動割当)"`
	ChannelCode string `gorm:"size:50;not null;unique;comment:チャネルコード (例: ONLINE_JP, STORE)"`
	Name        string `gorm:"size:100;not null;comment:チャネル名"`

	SkuAvailabilities []SkuAvailability `gorm:"foreignKey:SalesChannelID"`
}

// Product 商品の基本情報 (SKUの親)
type Product struct {
	ID              string     `gorm:"primaryKey;type:char(36);comment:商品ID (UUID)"`
	Name            string     `gorm:"size:255;not null;comment:商品名"`
	Description     *string    `gorm:"type:text;comment:商品説明"`
	ProductCode     *string    `gorm:"size:100;unique;comment:商品管理コード (ニトリの品番など)"`
	CategoryID      int        `gorm:"not null;comment:主カテゴリID"`
	BrandID         *int       `gorm:"comment:ブランドID (将来用)"`
	DefaultSkuID    *string    `gorm:"type:char(36);comment:代表SKU ID (初期表示用)"`
	Status          string     `gorm:"type:enum('draft','active','inactive','discontinued');not null;default:'draft';comment:商品ステータス"`
	IsTaxable       bool       `gorm:"not null;default:true;comment:課税対象か"`
	MetaTitle       *string    `gorm:"size:255;comment:SEO用タイトル"`
	MetaDescription *string    `gorm:"size:500;comment:SEO用説明文"`
	CreatedAt       time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt       time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`
	DeletedAt       *time.Time `gorm:"index;comment:論理削除日時"`

	Category   Category     `gorm:"foreignKey:CategoryID"`
	DefaultSku *ProductSku  `gorm:"foreignKey:DefaultSkuID"`
	Skus       []ProductSku `gorm:"foreignKey:ProductID"`
}

// ProductSku SKU (在庫管理の最小単位)
type ProductSku struct {
	ID        string     `gorm:"primaryKey;type:char(36);comment:SKU ID (UUID)"`
	ProductID string     `gorm:"type:char(36);not null;comment:商品ID"`
	SkuCode   *string    `gorm:"size:150;unique;comment:SKUコード (商品コード + バリエーション識別子)"`
	Status    string     `gorm:"type:enum('active','inactive','discontinued');not null;default:'active';comment:SKUステータス"`
	Barcode   *string    `gorm:"size:50;comment:バーコード (JAN/UPCなど)"`
	Weight    *float64   `gorm:"type:decimal(10,3);comment:重量 (kg)"`
	Width     *float64   `gorm:"type:decimal(10,2);comment:幅 (cm)"`
	Height    *float64   `gorm:"type:decimal(10,2);comment:高さ (cm)"`
	Depth     *float64   `gorm:"type:decimal(10,2);comment:奥行 (cm)"`
	CreatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`
	DeletedAt *time.Time `gorm:"index;comment:論理削除日時"`

	Product        Product           `gorm:"foreignKey:ProductID"`
	Values         []SkuValue        `gorm:"foreignKey:SkuID"`
	Images         []SkuImage        `gorm:"foreignKey:SkuID"`
	Prices         []Price           `gorm:"foreignKey:SkuID"`
	Inventories    []Inventory       `gorm:"foreignKey:SkuID"`
	Availabilities []SkuAvailability `gorm:"foreignKey:SkuID"`
}

// CategoryAttribute カテゴリ別利用属性紐付け
type CategoryAttribute struct {
	CategoryID         int  `gorm:"primaryKey;comment:カテゴリID"`
	AttributeID        int  `gorm:"primaryKey;comment:属性ID"`
	IsRequired         bool `gorm:"not null;default:false;comment:SKU定義に必須か"`
	IsVariantAttribute bool `gorm:"not null;default:false;comment:SKUのバリエーション軸となる属性か (例: 色、サイズ)"`
	SortOrder          int  `gorm:"default:0;comment:カテゴリ内での属性表示順"`

	Category  Category  `gorm:"foreignKey:CategoryID"`
	Attribute Attribute `gorm:"foreignKey:AttributeID"`
}

// SkuValue SKU属性値
type SkuValue struct {
	ID           int64    `gorm:"primaryKey;comment:SKU属性値ID (手動割当)"`
	SkuID        string   `gorm:"type:char(36);not null;comment:SKU ID"`
	AttributeID  int      `gorm:"not null;comment:属性ID"`
	OptionID     *int     `gorm:"comment:選択肢ID (input_type=select)"`
	ValueString  *string  `gorm:"size:255;comment:文字列値 (input_type=text)"`
	ValueNumber  *float64 `gorm:"type:decimal(15,4);comment:数値 (input_type=number)"`
	ValueBoolean *bool    `gorm:"comment:真偽値 (input_type=boolean)"`
	ValueText    *string  `gorm:"type:text;comment:長文テキスト値 (input_type=textarea)"`

	Sku       ProductSku       `gorm:"foreignKey:SkuID"`
	Attribute Attribute        `gorm:"foreignKey:AttributeID"`
	Option    *AttributeOption `gorm:"foreignKey:OptionID"`
}

// SkuImage SKU画像
type SkuImage struct {
	ID        int       `gorm:"primaryKey;comment:画像ID (手動割当)"`
	SkuID     string    `gorm:"type:char(36);not null;comment:SKU ID"`
	ImageURL  string    `gorm:"size:500;not null;comment:画像URL (CDNなど)"`
	AltText   *string   `gorm:"size:255;comment:代替テキスト"`
	SortOrder int       `gorm:"default:0;comment:表示順"`
	ImageType string    `gorm:"type:enum('main','swatch','gallery','detail');default:'gallery';comment:画像タイプ"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`

	Sku ProductSku `gorm:"foreignKey:SkuID"`
}

// Price SKU価格
type Price struct {
	ID           int64      `gorm:"primaryKey;comment:価格ID (手動割当)"`
	SkuID        string     `gorm:"type:char(36);not null;comment:SKU ID"`
	PriceTypeID  int        `gorm:"not null;comment:価格種別ID"`
	Price        float64    `gorm:"type:decimal(12,2);not null;comment:価格"`
	CurrencyCode string     `gorm:"size:3;not null;default:'JPY';comment:通貨コード"`
	StartDate    *time.Time `gorm:"comment:適用開始日時"`
	EndDate      *time.Time `gorm:"comment:適用終了日時"`
	IsActive     bool       `gorm:"not null;default:true;comment:有効な価格設定か"`
	CreatedAt    time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
	UpdatedAt    time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:更新日時"`

	Sku       ProductSku `gorm:"foreignKey:SkuID"`
	PriceType PriceType  `gorm:"foreignKey:PriceTypeID"`
}

// Inventory 在庫
type Inventory struct {
	ID               int64     `gorm:"primaryKey;comment:在庫ID (手動割当)"`
	SkuID            string    `gorm:"type:char(36);not null;comment:SKU ID"`
	LocationID       int       `gorm:"not null;comment:在庫拠点ID"`
	Quantity         int       `gorm:"not null;default:0;comment:物理在庫数"`
	ReservedQuantity int       `gorm:"not null;default:0;comment:引当済在庫数"`
	LastUpdated      time.Time `gorm:"not null;default:CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;comment:最終更新日時"`

	Sku      ProductSku        `gorm:"foreignKey:SkuID"`
	Location InventoryLocation `gorm:"foreignKey:LocationID"`
}

func (Inventory) TableName() string {
	return "inventory"
}

// SkuAvailability SKU販売可否
type SkuAvailability struct {
	ID             int64      `gorm:"primaryKey;comment:販売可否ID (手動割当)"`
	SkuID          string     `gorm:"type:char(36);not null;comment:SKU ID"`
	SalesChannelID int        `gorm:"not null;comment:販売チャネルID"`
	IsAvailable    bool       `gorm:"not null;default:true;comment:販売可能か"`
	AvailableFrom  *time.Time `gorm:"comment:販売開始日時"`
	AvailableUntil *time.Time `gorm:"comment:販売終了日時"`

	Sku          ProductSku   `gorm:"foreignKey:SkuID"`
	SalesChannel SalesChannel `gorm:"foreignKey:SalesChannelID"`
}

func (SkuAvailability) TableName() string {
	return "sku_availability"
}

// ProductReview 商品レビューテーブル
type ProductReview struct {
	ID        int64     `gorm:"primaryKey;comment:レビューID"`
	ProductID string    `gorm:"type:char(36);not null;index;comment:商品ID"`
	Nickname  string    `gorm:"size:100;not null;default:匿名さん;comment:表示ニックネーム"`
	Rating    uint8     `gorm:"not null;index;comment:評価 (1-5)"`
	Title     string    `gorm:"size:255;comment:レビュータイトル"`
	Comment   string    `gorm:"type:text;not null;comment:レビュー本文"`
	Status    string    `gorm:"type:enum('pending','approved','rejected');not null;default:pending;comment:レビューステータス"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:投稿日時"`

	Images []ReviewImage           `gorm:"foreignKey:ReviewID"`
	Votes  []UserReviewHelpfulVote `gorm:"foreignKey:ReviewID"`
}

// ReviewImage レビュー添付画像テーブル
type ReviewImage struct {
	ID        int64     `gorm:"primaryKey;comment:レビュー画像ID"`
	ReviewID  int64     `gorm:"not null;index;comment:レビューID"`
	ImageURL  string    `gorm:"size:500;not null;comment:画像URL"`
	SortOrder int       `gorm:"default:0;comment:表示順"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:作成日時"`
}

// UserReviewHelpfulVote 参考になった投票テーブル
type UserReviewHelpfulVote struct {
	UserID    int64     `gorm:"primaryKey;comment:投票したユーザーID"`
	ReviewID  int64     `gorm:"primaryKey;index;comment:投票されたレビューID"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;comment:投票日時"`
}

// ReviewSummary レビュー集計テーブル
type ReviewSummary struct {
	ProductID        string     `gorm:"primaryKey;type:char(36);comment:商品ID"`
	AverageRating    float64    `gorm:"type:decimal(3,2);not null;default:0.00;comment:平均評価"`
	ReviewCount      uint       `gorm:"not null;default:0;comment:承認済みレビュー件数"`
	Rating1Count     uint       `gorm:"not null;default:0;comment:評価1の件数"`
	Rating2Count     uint       `gorm:"not null;default:0;comment:評価2の件数"`
	Rating3Count     uint       `gorm:"not null;default:0;comment:評価3の件数"`
	Rating4Count     uint       `gorm:"not null;default:0;comment:評価4の件数"`
	Rating5Count     uint       `gorm:"not null;default:0;comment:評価5の件数"`
	LastCalculatedAt *time.Time `gorm:"comment:最終集計日時"`
}

// 用于映射
type ProductProjection struct {
	ID              string          `gorm:"column:id"`
	Name            string          `gorm:"column:name"`
	Description     *string         `gorm:"column:description"`
	ProductCode     *string         `gorm:"column:product_code"`
	IsTaxable       bool            `gorm:"column:is_taxable"`
	MetaTitle       *string         `gorm:"column:meta_title"`
	MetaDescription *string         `gorm:"column:meta_description"`
	TargetSKUInfo   json.RawMessage `gorm:"column:target_sku_info;type:json"`
	VariantOptions  json.RawMessage `gorm:"column:variant_options;type:json"`
	CategoryInfo    json.RawMessage `gorm:"column:category_info;type:json"`
	BrandInfo       json.RawMessage `gorm:"column:brand_info;type:json"`
}

type ReviewProjection struct {
	Summary    json.RawMessage `gorm:"column:summary;type:json"`
	Reviews    json.RawMessage `gorm:"column:reviews;type:json"`
	Pagination json.RawMessage `gorm:"column:pagination;type:json"`
}

type QAListProjection struct {
	QAList     json.RawMessage `gorm:"column:qa_list;type:json"`
	Pagination json.RawMessage `gorm:"column:pagination;type:json"`
}

type SKUImageListProjection struct {
	Images json.RawMessage `gorm:"column:images;type:json"`
}

type FavoriteSKUInfoEntity struct {
	SkuID            string  `json:"sku_id"`       // SKU ID
	ProductID        string  `json:"product_id"`   // 商品ID
	ProductName      string  `json:"product_name"` // 商品名 (省略後)
	ProductCode      string  `json:"product_code"`
	Amount           float64 `json:"amount"`
	Type             string  `json:"type"`
	TypeName         string  `json:"type_name"`
	ImageID          int     `json:"id"`
	ImageURL         string  `json:"url"`
	AltText          *string `json:"alt_text"`
	AttributeID      int     `json:"attribute_id"`
	AttributeName    string  `json:"attribute_name"`
	Value            *string `json:"value"`
	AddedAtFormatted string  `json:"added_at_formatted"`
}

type RelatedProductInfoEntity struct {
	ProductID         string  `json:"product_id"`             // 関連商品のID
	ProductCode       string  `json:"product_code,omitempty"` // 関連商品のコード
	ProductName       string  `json:"product_name"`           // 関連商品の名称 (省略後)
	HighestPrice      float64 `json:"highest_price"`
	LowestPrice       float64 `json:"lowest_price"`
	IsOnSale          bool    `json:"is_on_sale"`                    // ★値下げフラグ
	AverageRating     float64 `json:"average_rating"`                // 平均評価
	ReviewCount       int     `json:"review_count"`                  // レビュー件数
	ThumbnailImageURL *string `json:"thumbnail_image_url,omitempty"` // 代表SKUのサムネイル画像URL (Nullable)
}

type ViewedSKUInfoEntity struct {
	SkuID             string  `json:"sku_id"`       // SKU ID
	ProductID         string  `json:"product_id"`   // 商品ID
	ProductName       string  `json:"product_name"` // 商品名 (省略後)
	ProductCode       string  `json:"product_code"`
	HighestPrice      float64 `json:"highest_price"`
	LowestPrice       float64 `json:"lowest_price"`
	ImageID           int     `json:"image_id"`
	ImageURL          string  `json:"image_url"`
	AltText           *string `json:"alt_text"`
	AverageRating     float64 `json:"average_rating"` // 平均評価
	ReviewCount       int     `json:"review_count"`   // レビュー件数
	ViewedAtFormatted string  `json:"viewed_at_formatted"`
}

type CartEntity struct {
	SkuID                   string   `json:"sku_id"`                 // SKU ID
	ProductID               string   `json:"product_id"`             // 商品ID
	ProductName             string   `json:"product_name"`           // 商品名 (省略後)
	ProductCode             string   `json:"product_code,omitempty"` // 商品コード
	Quantity                int      `json:"quantity"`               // カート内の数量
	Amount                  float64  `json:"amount"`
	FormattedAmount         string   `json:"formatted_amount"`
	Type                    string   `json:"type"`
	TypeName                string   `json:"type_name"`
	OriginalAmount          *float64 `json:"original_amount"`
	FormattedOriginalAmount *string  `json:"formatted_original_amount"`
	SubtotalFormatted       string   `json:"subtotal_formatted"` // 小計 (表示用文字列 例: "7,980円")
	ImageID                 int      `json:"image_id"`
	URL                     string   `json:"url"`
	AltText                 *string  `json:"alt_text"`
	AttributeID             int      `json:"attribute_id"`
	AttributeName           string   `json:"attribute_name"`
	Value                   *string  `json:"value"`
	StockStatus             string   `json:"stock_status"` // 在庫状況コード ('available', 'low_stock', 'out_of_stock')
}
