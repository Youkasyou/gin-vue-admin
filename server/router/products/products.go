package products

import "github.com/gin-gonic/gin"

type ProductsRouter struct{}

func (s *ProductsRouter) InitProductsRouter(Router *gin.RouterGroup) {
	productsRouter := Router.Group("products")

	{
		productsRouter.GET("getProductInfo/:productCode", productsApi.GetProductInfo)
		productsRouter.GET("getReviews/:productCode/reviews", productsApi.GetReviews)
		productsRouter.GET("getQA/:productCode/qa", productsApi.GetQA)
		productsRouter.GET("getImage/:skuId/images", productsApi.GetImage)
		productsRouter.GET("getRelated/:productCode/related", productsApi.GetRelated)
		productsRouter.GET("getCoordinates/:productCode/coordinates", productsApi.GetCoordinates)
		productsRouter.GET("search", productsApi.Search)
	}
}
