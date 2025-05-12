package products

import "github.com/gin-gonic/gin"

type OrdersApi struct{}

// GetInfo
// @Tags Orders
// @Summary 現在のカート合計等に応じた利用可能クーポン・ポイント情報を取得
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "現在のカート合計等に応じた利用可能クーポン・ポイント情報を取得"
// @Router    /orders/checkout/info [get]
func (o *OrdersApi) GetInfo(c *gin.Context) {}

// ApplyCoupon
// @Tags Orders
// @Summary 指定クーポンを現在の注文（カート）に適用する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.ApplyCouponRequest true "クーポン適用APIのリクエストボディ"
// @Success   200  "指定クーポンを現在の注文（カート）に適用する"
// @Router    /orders/checkout/apply-coupon [post]
func (o *OrdersApi) ApplyCoupon(c *gin.Context) {}

// DeleteAddress
// @Tags Orders
// @Summary 適用中クーポンを解除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "適用中クーポンを解除する"
// @Router    /orders/checkout/remove-coupon [delete]
func (o *OrdersApi) RemoveCoupon(c *gin.Context) {}

// UsePoints
// @Tags Orders
// @Summary 指定ポイント数を現在の注文（カート）に利用する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.UsePointsRequest true "ポイント利用APIのリクエストボディ"
// @Success   200  "指定ポイント数を現在の注文（カート）に利用する"
// @Router   /orders/checkout/use-points [post]
func (o *OrdersApi) UsePoints(c *gin.Context) {}

// DeleteAddress
// @Tags Orders
// @Summary 利用中ポイントを解除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "利用中ポイントを解除する"
// @Router    /orders/checkout/remove-points [delete]
func (o *OrdersApi) RemovePoints(c *gin.Context) {}
