package products

import "github.com/gin-gonic/gin"

type OredrsRouter struct{}

func (o *OredrsRouter) InitOrdersRouter(Router *gin.RouterGroup) {
	oredrsRouter := Router.Group("orders")

	{
		oredrsRouter.GET("checkout/info", ordersApi.GetInfo)
		oredrsRouter.POST("checkout/apply-coupon", ordersApi.ApplyCoupon)
		oredrsRouter.POST("checkout/use-points", ordersApi.UsePoints)
		oredrsRouter.DELETE("checkout/remove-coupon", ordersApi.RemoveCoupon)
		oredrsRouter.DELETE("checkout/remove-points", ordersApi.RemovePoints)
	}
}
