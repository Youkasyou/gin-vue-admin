package products

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
)

type PaymentService struct{}

func (paymentService *PaymentService) GetMethods() (res []dto.PaymentMethodInfo, err error) {
	err = global.GVA_DB.Table("payment_methods").Select("id as method_id,method_code,name,description").Where("is_active=true").
		Order("sort_order asc").Find(&res).Error

	return
}
