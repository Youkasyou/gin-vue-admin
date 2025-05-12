package products

import (
	"fmt"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type FavoritesApi struct{}

// GetFavoriteSku
// @Tags Product
// @Summary 自身のお気に入りSKUリストを取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	page query int false "ページ番号 (1始まり)"
// @Param   limit query int false "1ページあたりのレビュー件数"
// @Param   sort query string false "ソート順序('newest', 'oldest'のいずれかを指定"
// @Success   200  "自身のお気に入りSKUリストを取得する"
// @Router    /favorites/skus [get]
func (f *FavoritesApi) GetFavoriteSku(c *gin.Context) {
	pagestr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pagestr)
	if err != nil {
		response.BadRequest("pageパラメータは数値で指定してください。", c)
		return
	}
	if page < 1 {
		response.BadRequest("pageパラメータは1以上で指定してください。", c)
		return
	}
	limitstr := c.DefaultQuery("limit", "10")
	limit, err := strconv.Atoi(limitstr)
	if err != nil {
		response.BadRequest("limitパラメータは数値で指定してください。", c)
		return
	}
	if limit < 1 || limit > 100 {
		response.BadRequest("limitパラメータは1から100の間で指定してください。", c)
		return
	}
	sort := c.DefaultQuery("sort", "newest")
	switch sort {
	case "newest", "oldest":
	default:
		response.BadRequest("不正なsortパラメータです。('newest', 'oldest'のいずれかを指定)", c)
		return
	}
	userId := utils.GetUserID(c)
	skuList, err := favoritesService.GetFavoriteSku(userId, page, limit, sort)
	if err != nil {
		fmt.Println("获取收藏列表失败")
	}
	response.OkWithDetailed(skuList, "获取成功", c)
}

// AddFavoriteSku
// @Tags Product
// @Summary 指定したSKUをお気に入りに追加する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body request.SkuIdRequest true "SKU ID"
// @Success   200  "指定したSKUをお気に入りに追加する"
// @Router    /favorites/skus [post]
func (f *FavoritesApi) AddFavoriteSku(c *gin.Context) {
	var request request.SkuIdRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	err = favoritesService.AddFavoriteSku(userId, request.SkuId)
	if err != nil {
		if err.Error() == "not found" {
			response.NotFound("skuが見つかりません。", c)
			return
		}
	}
	response.OkWithMessage("お気に入りに追加しました", c)
}

// DeleteFavoriteSku
// @Tags Product
// @Summary 指定したSKUをお気に入りから削除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  skuId path string true "sku id"
// @Success   200  "指定したSKUをお気に入りから削除する"
// @Router    /favorites/skus/{skuId} [delete]
func (f *FavoritesApi) DeleteFavoriteSku(c *gin.Context) {
	skuId := c.Param("skuId")
	userId := utils.GetUserID(c)
	err := favoritesService.DeleteFavoriteSku(userId, skuId)
	if err != nil {
		if err.Error() == "not found sku" {
			response.NotFound("skuが見つかりません。", c)
			return
		}
		if err.Error() == "not found data" {
			response.NotFound("お気に入りが見つかりません。", c)
			return
		}
	}
	response.OkWithMessage("お気に入りから削除しました", c)
}
