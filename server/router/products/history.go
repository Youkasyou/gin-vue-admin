package products

import "github.com/gin-gonic/gin"

type HistoryRouter struct{}

func (s *FavoritesRouter) InitHistoryRouter(Router *gin.RouterGroup) {
	historyRouter := Router.Group("history")

	{
		historyRouter.POST("viewed-skus", historyApi.AddHistory)
		historyRouter.GET("viewed-skus", historyApi.GetHistory)
	}
}
