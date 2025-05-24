package products

import (
	"regexp"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
)

type ProductsApi struct{}

// GetProductInfo
// @Tags Product
// @Summary 商品情報取得
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	productCode path string true "Product Code"
// @Param   sku_id  query   string  false  "SKU ID"
// @Success   200  "商品の基本情報と、リクエストで特定されたSKUに関する詳細情報を返す"
// @Router    /products/getProductInfo/{productCode} [get]
func (p *ProductsApi) GetProductInfo(c *gin.Context) {
	skuid := c.DefaultQuery("sku_id", "")
	productCode := c.Param("productCode")
	isValid, _ := regexp.MatchString(`^\d+$`, productCode)
	if !isValid {
		response.InvalidParam("不正な商品識別子です。", c)
		return
	}
	if skuid != "" {
		isValid, _ = regexp.MatchString(`^sku-\d+$`, skuid)
		if !isValid {
			response.InvalidParam("不正なSKU ID形式です。", c)
			return
		}
	}

	productInfo, err := productsService.GetProductInfoByProSkuId(productCode, skuid)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	response.OkWithDetailed(gin.H{"productInfo": productInfo}, "获取成功", c)

}

// GetReviews
// @Tags Product
// @Summary レビュー一覧取得
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	productCode path string true "Product Code"
// @Param 	page query int false "ページ番号 (1始まり)"
// @Param   limit query int false "1ページあたりのレビュー件数"
// @Param   sort query string false "ソート順序('newest', 'oldest', 'highest_rating', 'lowest_rating', 'most_helpful' のいずれかを指定"
// @Param   rating query int false "指定した評価（星の数、例: 5）"
// @Success   200  "レビューリスト、集計情報、ページネーション情報を返す"
// @Router    /products/getReviews/{productCode}/reviews [get]
func (p *ProductsApi) GetReviews(c *gin.Context) {
	productCode := c.Param("productCode")
	isValid, _ := regexp.MatchString(`^\d+$`, productCode)
	if !isValid {
		response.InvalidParam("不正な商品識別子です。", c)
		return
	}
	pagestr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pagestr)
	if err != nil {
		response.InvalidParam("pageパラメータは数値で指定してください。", c)
		return
	}
	if page < 1 {
		response.InvalidParam("pageパラメータは1以上で指定してください。", c)
		return
	}
	limitstr := c.DefaultQuery("limit", "10")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.InvalidParam("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.InvalidParam("limitパラメータは1から100の間で指定してください。", c)
		return
	}
	sort := c.DefaultQuery("sort", "newest")
	switch sort {
	case "newest", "oldest", "highest_rating", "lowest_rating", "most_helpful":
	default:
		response.InvalidParam("不正なsortパラメータです。('newest', 'oldest', 'highest_rating', 'lowest_rating', 'most_helpful' のいずれかを指定)", c)
		return
	}
	ratingstr := c.Query("rating")
	var rating int
	if ratingstr != "" {
		rating, err = strconv.Atoi(ratingstr)
		if err != nil {
			response.InvalidParam("ratingパラメータは数値で指定してください。", c)
			return
		}
		if rating < 1 || rating > 5 {
			response.InvalidParam("ratingパラメータは1から5の間で指定してください。", c)
			return
		}
	}

	reviews, err := productsService.GetReviews(productCode, page, limit, sort, rating)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}

	response.OkWithDetailed(gin.H{"reviews": reviews}, "获取成功", c)

}

// GetQA
// @Tags Product
// @Summary Q&A一覧取得
// @accept    application/json
// @Produce   application/json
// @Param 	productCode path string true "Product Code"
// @Param 	page query int false "ページ番号 (1始まり)"
// @Param   limit query int false "1ページあたりのQ&A件数"
// @Param   sort query string false "ソート順序('newest', 'oldest', 'most_helpful' のいずれかを指定"
// @Success   200  "紐づく承認済みの質問とそれに対する店舗回答のリストを、ページネーションおよびソート機能付きで取得する"
// @Router    /products/getQA/{productCode}/qa [get]
func (p *ProductsApi) GetQA(c *gin.Context) {
	productCode := c.Param("productCode")
	isValid, _ := regexp.MatchString(`^\d+$`, productCode)
	if !isValid {
		response.InvalidParam("不正な商品識別子です。", c)
		return
	}
	pagestr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pagestr)
	if err != nil {
		response.InvalidParam("pageパラメータは数値で指定してください。", c)
		return
	}
	if page < 1 {
		response.InvalidParam("pageパラメータは1以上で指定してください。", c)
		return
	}
	limitstr := c.DefaultQuery("limit", "10")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.InvalidParam("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.InvalidParam("limitパラメータは1から100の間で指定してください。", c)
		return
	}
	sort := c.DefaultQuery("sort", "newest")
	switch sort {
	case "newest", "oldest", "most_helpful":
	default:
		response.InvalidParam("不正なsortパラメータです。('newest', 'oldest', 'most_helpful' のいずれかを指定)", c)
		return
	}

	QAList, err := productsService.GetQA(productCode, page, limit, sort)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}

	response.OkWithDetailed(QAList, "获取成功", c)

}

// GetImage
// @Tags Product
// @Summary SKU画像リスト取得
// @accept    application/json
// @Produce   application/json
// @Param 	skuId path string true "Sku id"
// @Success   200  "SKU画像リスト取得"
// @Router    /products/getImage/{skuId}/images [get]
func (p *ProductsApi) GetImage(c *gin.Context) {
	skuId := c.Param("skuId")
	skuList, err := productsService.GetImage(skuId)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(skuList, "获取成功", c)
}

// GetRelated
// @Tags Product
// @Summary 関連商品リスト取得
// @accept    application/json
// @Produce   application/json
// @Param 	productCode path string true "Product Code"
// @Param   limit query int false "表示する関連商品の最大件数"
// @Success   200  "関連商品リスト取得"
// @Router    /products/getRelated/{productCode}/related [get]
func (p *ProductsApi) GetRelated(c *gin.Context) {
	productCode := c.Param("productCode")
	isValid, _ := regexp.MatchString(`^\d+$`, productCode)
	if !isValid {
		response.InvalidParam("不正な商品識別子です。", c)
		return
	}

	limitstr := c.DefaultQuery("limit", "5")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.InvalidParam("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.InvalidParam("limitパラメータは1から100の間で指定してください。", c)
		return
	}

	QAList, err := productsService.GetRelated(productCode, limit)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}

	response.OkWithDetailed(QAList, "获取成功", c)

}

// GetCoordinates
// @Tags Product
// @Summary 商品コーディネート概要リスト取得
// @accept    application/json
// @Produce   application/json
// @Param 	productCode path string true "Product Code"
// @Param   limit query int false "表示するコーディネートセット概要の最大件数"
// @Success   200  "商品コーディネート概要リスト取得"
// @Router    /products/getCoordinates/{productCode}/coordinates [get]
func (p *ProductsApi) GetCoordinates(c *gin.Context) {
	productCode := c.Param("productCode")
	isValid, _ := regexp.MatchString(`^\d+$`, productCode)
	if !isValid {
		response.InvalidParam("不正な商品識別子です。", c)
		return
	}

	limitstr := c.DefaultQuery("limit", "4")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.InvalidParam("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.InvalidParam("limitパラメータは1から100の間で指定してください。", c)
		return
	}

	QAList, err := productsService.GetCoordinates(productCode, limit)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}

	response.OkWithDetailed(QAList, "获取成功", c)

}

// Search
// @Tags Product
// @Summary キーワードとカテゴリ（任意）で商品を検索し、結果をページネーションで返す
// @accept    application/json
// @Produce   application/json
// @Param 	keyword query string true "keyword"
// @Param 	categoryId query int false "検索対象を絞り込むカテゴリのID"
// @Param 	page query int false "ページ番号"
// @Param   limit query int false "1ページあたりの件数"
// @Param 	sort  query string false "ソート順例: 'relevance'(関連度順), 'price_asc'(価格安い順), 'price_desc'(価格高い順), 'newest'(新着順)"
// @Success   200  "キーワードとカテゴリ（任意）で商品を検索し、結果をページネーションで返す"
// @Router    /products/search [get]
func (p *ProductsApi) Search(c *gin.Context) {
	keyword := c.Query("keyword")
	categoryIdstr := c.Query("categoryId")
	var categoryId int
	var err error
	if categoryIdstr != "" {
		categoryId, err = strconv.Atoi(categoryIdstr)
		if err != nil {
			response.InvalidParam("categoryIdパラメータは数値で指定してください。", c)
			return
		}
	}

	pagestr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pagestr)
	if err != nil {
		response.InvalidParam("pageパラメータは数値で指定してください。", c)
		return
	}
	if page < 1 {
		response.InvalidParam("pageパラメータは1以上で指定してください。", c)
		return
	}
	limitstr := c.DefaultQuery("limit", "20")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.InvalidParam("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.InvalidParam("limitパラメータは1から100の間で指定してください。", c)
		return
	}
	sort := c.DefaultQuery("sort", "relevance")
	switch sort {
	case "relevance", "price_asc", "price_desc", "newest":
	default:
		response.InvalidParam("不正なsortパラメータです。('relevance', 'price_asc', 'price_desc','newest' のいずれかを指定)", c)
		return
	}

	searchResult, err := productsService.Search(keyword, categoryId, page, limit, sort)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}

	response.OkWithDetailed(searchResult, "获取成功", c)

}
