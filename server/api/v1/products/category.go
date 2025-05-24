package products

import (
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
)

type CategoryApi struct{}

// GetTree
// @Tags Category
// @Summary 全カテゴリの階層構造リスト（ナビゲーション用）を取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @param	max_depth query int false "max depth"
// @Success   200  "全カテゴリの階層構造リスト（ナビゲーション用）を取得する"
// @Router    /categories/tree [get]
func (cate *CategoryApi) GetTree(c *gin.Context) {
	max_depth := c.DefaultQuery("max_depth", "0")
	maxDepth, err := strconv.Atoi(max_depth)
	if err != nil {
		response.InvalidParam("max_depthパラメータは数値で指定してください。", c)
		return
	}
	if maxDepth < 0 {
		response.InvalidParam("maxDepthパラメータは0以上で指定してください。", c)
		return
	}
	categoryList, err := categoryService.GetTree(maxDepth)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(categoryList, "获取成功", c)

}

// GetInfo
// @Tags Category
// @Summary 指定されたカテゴリIDまたはコードの情報を取得（サブカテゴリ、関連属性等
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  categoryId path int true "category Id"
// @Param  include_product_count query bool false "include_product_count"
// @Param  include_attributes query bool false "include_attributes"
// @Success   200  "指定されたカテゴリIDまたはコードの情報を取得（サブカテゴリ、関連属性等"
// @Router    /categories/{categoryId} [get]
func (cate *CategoryApi) GetInfo(c *gin.Context) {
	categoryIdstr := c.Param("categoryId")
	categoryId, err := strconv.Atoi(categoryIdstr)
	if err != nil {
		response.InvalidParam("categoryIdパラメータは数値で指定してください。", c)
		return
	}

	include_product_countstr := c.DefaultQuery("include_product_count", "false")
	var include_product_count bool
	if include_product_countstr == "false" {
		include_product_count = false
	} else if include_product_countstr == "true" {
		include_product_count = true
	} else {
		response.InvalidParam("include_product_countパラメータはtrue or falseで指定してください。", c)
		return
	}

	include_attributesstr := c.DefaultQuery("include_attributes", "false")
	var include_attributes bool
	if include_attributesstr == "false" {
		include_attributes = false
	} else if include_attributesstr == "true" {
		include_attributes = true
	} else {
		response.InvalidParam("include_attributesパラメータはtrue or falseで指定してください。", c)
		return
	}

	detail, err := categoryService.GetInfo(categoryId, include_product_count, include_attributes)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(detail, "获取成功", c)
}
