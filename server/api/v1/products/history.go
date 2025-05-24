package products

import (
	"fmt"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type HistoryApi struct{}

// AddHistory
// @Tags Product
// @Summary 閲覧したSKU（代表SKU）を履歴に記録する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body request.SkuIdRequest true "SKU ID"
// @Success   200  "閲覧したSKU（代表SKU）を履歴に記録する"
// @Router    /history/viewed-skus [post]
func (h *HistoryApi) AddHistory(c *gin.Context) {
	var request request.SkuIdRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	err = historyService.AddHistory(userId, request.SkuId)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithMessage("閲覧履歴を記録しました", c)
}

// GetHistory
// @Tags Product
// @Summary 自身の最近チェックした商品（SKU）リストを取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	page query int false "ページ番号 (1始まり)"
// @Param   limit query int false "1ページあたりのレビュー件数"
// @Success   200  "自身の最近チェックした商品（SKU）リストを取得する"
// @Router    /history/viewed-skus [get]
func (h *HistoryApi) GetHistory(c *gin.Context) {
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
	userId := utils.GetUserID(c)
	viewList, err := historyService.GetHistory(userId, page, limit)
	if err != nil {
		fmt.Println("获取浏览记录失败")
	}
	response.OkWithDetailed(viewList, "获取成功", c)
}
