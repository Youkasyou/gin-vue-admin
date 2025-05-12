package products

import "github.com/gin-gonic/gin"

type ShippingRouter struct{}

func (s *ShippingRouter) InitShippingRouter(Router *gin.RouterGroup) {
	shippingRouter := Router.Group("shipping-addresses")

	{
		shippingRouter.GET("", shippingApi.GetAddress)
		shippingRouter.POST("", shippingApi.AddAddress)
		shippingRouter.PUT(":addressId", shippingApi.SetAddress)
		shippingRouter.DELETE(":addressId", shippingApi.DeleteAddress)
	}
}
