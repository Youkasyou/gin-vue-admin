package products

import "github.com/gin-gonic/gin"

type CartRouter struct{}

func (s *CartRouter) InitCartRouter(Router *gin.RouterGroup) {
	cartRouter := Router.Group("cart")

	{
		cartRouter.GET("", cartApi.GetCart)
		cartRouter.POST("items", cartApi.AddCart)
		cartRouter.PUT("items/:skuId", cartApi.SetCart)
		cartRouter.DELETE("items/:skuId", cartApi.DeleteCart)
	}
}
