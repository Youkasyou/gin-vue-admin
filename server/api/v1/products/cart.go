package products

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type CartApi struct{}

// GetCart
// @Tags Cart
// @Summary 現在のカート内容（商品リスト、合計情報）を取得
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "現在のカート内容（商品リスト、合計情報）を取得"
// @Router    /cart [get]
func (cart *CartApi) GetCart(c *gin.Context) {
	userId := utils.GetUserID(c)
	itemsList, _ := cartService.GetCart(userId)
	response.OkWithDetailed(itemsList, "获取成功", c)
}

// AddCart
// @Tags Cart
// @Summary 指定したSKUと数量をカートに追加（または更新）
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body request.ItemQuantityRequest true "SKU ID,Quantity"
// @Success   200  "指定したSKUと数量をカートに追加（または更新）"
// @Router    /cart/items [post]
func (cart *CartApi) AddCart(c *gin.Context) {
	var request request.ItemQuantityRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	if request.Quantity < 1 {
		response.InvalidParam("quantityパラメータは1以上で指定してください。", c)
		return
	}
	userId := utils.GetUserID(c)
	err = cartService.AddCart(userId, request.SkuId, request.Quantity)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithMessage("カートに追加しました", c)
}

// SetCart
// @Tags Cart
// @Summary カート内の指定SKUの数量を変更する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  skuId path string true "sku id"
// @Param data body request.QuantityRequest true "Quantity"
// @Success   200  "カート内の指定SKUの数量を変更する"
// @Router    /cart/items/{skuId} [put]
func (cart *CartApi) SetCart(c *gin.Context) {
	skuId := c.Param("skuId")
	var request request.QuantityRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	if request.Quantity < 1 {
		response.InvalidParam("quantityパラメータは1以上で指定してください。", c)
		return
	}
	userId := utils.GetUserID(c)
	err = cartService.SetCart(userId, skuId, request.Quantity)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithMessage("商品の数量を変更しました", c)
}

// DeleteCart
// @Tags Cart
// @Summary カート内の指定SKUを削除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  skuId path string true "sku id"
// @Success   200  "カート内の指定SKUを削除する"
// @Router    /cart/items/{skuId} [delete]
func (cart *CartApi) DeleteCart(c *gin.Context) {
	skuId := c.Param("skuId")
	userId := utils.GetUserID(c)
	err := cartService.DeleteCart(userId, skuId)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithMessage("商品を削除しました", c)
}
