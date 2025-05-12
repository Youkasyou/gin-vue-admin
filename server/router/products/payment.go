package products

import "github.com/gin-gonic/gin"

type PaymentRouter struct{}

func (p *PaymentRouter) InitPaymentRouter(Router *gin.RouterGroup) {
	paymentRouter := Router.Group("payments")

	{
		paymentRouter.GET("methods", paymentApi.GetMethods)
	}
}
