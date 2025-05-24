package products

import (
	"errors"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type OrdersApi struct{}

// GetInfo
// @Tags Orders
// @Summary 現在のカート合計等に応じた利用可能クーポン・ポイント情報を取得
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "現在のカート合計等に応じた利用可能クーポン・ポイント情報を取得"
// @Router    /orders/checkout/info [get]
func (o *OrdersApi) GetInfo(c *gin.Context) {
	userId := utils.GetUserID(c)
	infoList, err := ordersService.GetInfo(userId)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(infoList, "获取成功", c)
}

// ApplyCoupon
// @Tags Orders
// @Summary 指定クーポンを現在の注文（カート）に適用する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.ApplyCouponRequest true "クーポン適用APIのリクエストボディ"
// @Success   200  "指定クーポンを現在の注文（カート）に適用する"
// @Router    /orders/checkout/apply-coupon [post]
func (o *OrdersApi) ApplyCoupon(c *gin.Context) {
	var request dto.ApplyCouponRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	infoList, err := ordersService.ApplyCoupon(userId, request)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			response.BadRequest(response.ErrCouponNotFound, c)
			return
		}

		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return

	}
	response.OkWithDetailed(infoList, "クーポンを適用しました", c)
}

// DeleteAddress
// @Tags Orders
// @Summary 適用中クーポンを解除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "適用中クーポンを解除する"
// @Router    /orders/checkout/remove-coupon [delete]
func (o *OrdersApi) RemoveCoupon(c *gin.Context) {
	userId := utils.GetUserID(c)
	infoList, _ := ordersService.RemoveCoupon(userId)
	response.OkWithDetailed(infoList, "クーポンを解除しました", c)
}

// UsePoints
// @Tags Orders
// @Summary 指定ポイント数を現在の注文（カート）に利用する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.UsePointsRequest true "ポイント利用APIのリクエストボディ"
// @Success   200  "指定ポイント数を現在の注文（カート）に利用する"
// @Router   /orders/checkout/use-points [post]
func (o *OrdersApi) UsePoints(c *gin.Context) {
	var request dto.UsePointsRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	infoList, err := ordersService.UsePoints(userId, request)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(infoList, "ポイントを利用しました", c)
}

// DeleteAddress
// @Tags Orders
// @Summary 利用中ポイントを解除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "利用中ポイントを解除する"
// @Router    /orders/checkout/remove-points [delete]
func (o *OrdersApi) RemovePoints(c *gin.Context) {
	userId := utils.GetUserID(c)
	infoList, _ := ordersService.RemovePoints(userId)
	response.OkWithDetailed(infoList, "ポイントを解除しました", c)
}

// OrderPay
// @Tags Orders
// @Summary 注文を確定し、Pay.jpテストモードで支払い処理を実行、注文データを保存
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.CreateOrderRequest true "注文確定APIのリクエスト"
// @Success   200  "注文を確定し、Pay.jpテストモードで支払い処理を実行、注文データを保存"
// @Router    /orders [post]
func (o *OrdersApi) OrderPay(c *gin.Context) {
	var request dto.CreateOrderRequest
	err := c.ShouldBindJSON(&request)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	orderInfo, err := ordersService.OrderPay(userId, request)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			response.BadRequest(response.ErrCouponNotFound, c)
			return
		}

		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return

	}
	response.OkWithDetailed(orderInfo, "支払い成功", c)
}

// GetOrders
// @Tags Orders
// @Summary 自身の注文履歴をページネーション付きで取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	page query int false "ページ番号 (1始まり)"
// @Param   limit query int false "1ページあたりのQ&A件数"
// @Param   status query string false "特定の注文ステータスで絞り込む場合（例: payment_confirmed,pending_payment, shipped,cancelled,delivered,processing）"
// @Success   200  "自身の注文履歴をページネーション付きで取得する"
// @Router    /orders [get]
func (o *OrdersApi) GetOrders(c *gin.Context) {
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
	status := c.Query("status")
	if status != "" {
		switch status {
		case "payment_confirmed", "shipped", "cancelled", "delivered", "processing", "pending_payment":
		default:
			response.InvalidParam("不正なsortパラメータです。(payment_confirmed, shipped,cancelled,delivered,processingのいずれかを指定)", c)
			return
		}
	}

	userId := utils.GetUserID(c)
	orderList, err := ordersService.GetOrders(userId, page, limit, status)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(orderList, "获取成功", c)

}

// GetOrderDetail
// @Tags Orders
// @Summary 指定した注文IDの詳細情報を取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param 	orderId path string true "注文のID"
// @Success   200  "指定した注文IDの詳細情報を取得する"
// @Router    /orders/{orderId} [get]
func (o *OrdersApi) GetOrderDetail(c *gin.Context) {
	orderId := c.Param("orderId")
	userId := utils.GetUserID(c)
	orderDetail, err := ordersService.GetOrderDetail(userId, orderId)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(orderDetail, "获取成功", c)
}
