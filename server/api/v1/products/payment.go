package products

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
)

type PaymentApi struct{}

// GetMethods
// @Tags Payment
// @Summary 利用可能な支払い方法の一覧を取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "利用可能な支払い方法の一覧を取得する"
// @Router    /payments/methods [get]
func (p *PaymentApi) GetMethods(c *gin.Context) {
	methodList, _ := paymentService.GetMethods()
	response.OkWithDetailed(methodList, "获取成功", c)
}
