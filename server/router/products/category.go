package products

import "github.com/gin-gonic/gin"

type CategoryRouter struct{}

func (s *CategoryRouter) InitCategoryRouter(Router *gin.RouterGroup) {
	categoryRouter := Router.Group("categories")

	{
		categoryRouter.GET("tree", categoryApi.GetTree)
		categoryRouter.GET(":categoryId", categoryApi.GetInfo)
	}
}
