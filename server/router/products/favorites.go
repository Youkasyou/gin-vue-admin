package products

import "github.com/gin-gonic/gin"

type FavoritesRouter struct{}

func (s *FavoritesRouter) InitFavoritesRouter(Router *gin.RouterGroup) {
	favoritesRouter := Router.Group("favorites")

	{
		favoritesRouter.GET("skus", favoritesApi.GetFavoriteSku)
		favoritesRouter.POST("skus", favoritesApi.AddFavoriteSku)
		favoritesRouter.DELETE("skus/:skuId", favoritesApi.DeleteFavoriteSku)
	}
}
