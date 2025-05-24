package products

import (
	"regexp"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type ShippingApi struct{}

// GetAddress
// @Tags Shipping
// @Summary 自身の登録済み配送先住所リストを取得する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Success   200  "自身の登録済み配送先住所リストを取得する"
// @Router    /shipping-addresses [get]
func (s *ShippingApi) GetAddress(c *gin.Context) {
	userId := utils.GetUserID(c)
	addressList, _ := shippingService.GetAddress(userId)
	response.OkWithDetailed(addressList, "获取成功", c)

}

// AddAddress
// @Tags Shipping
// @Summary 新しい配送先住所を登録する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param data body dto.ShippingAddressInput true "配送先住所入力データ"
// @Success   200  "新しい配送先住所を登録する"
// @Router    /shipping-addresses [post]
func (s *ShippingApi) AddAddress(c *gin.Context) {
	var requestAddr dto.ShippingAddressInput
	err := c.ShouldBindJSON(&requestAddr)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}

	isValid, _ := regexp.MatchString(`^\d{3}-\d{4}$`, requestAddr.PostalCode)
	if !isValid {
		response.InvalidParam("不正な郵便番号形式です。", c)
		return
	}

	userId := utils.GetUserID(c)
	resAddr, _ := shippingService.AddAddress(userId, requestAddr)
	response.OkWithDetailed(resAddr, "追加成功", c)

}

// SetAddress
// @Tags Shipping
// @Summary 指定した配送先住所IDの情報を更新する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  addressId path int true "address Id"
// @Param data body dto.ShippingAddressInput true "配送先住所入力データ"
// @Success   200  "指定した配送先住所IDの情報を更新する"
// @Router    /shipping-addresses/{addressId} [put]
func (s *ShippingApi) SetAddress(c *gin.Context) {
	addrIdstr := c.Param("addressId")
	addrId, err := strconv.Atoi(addrIdstr)
	if err != nil {
		response.InvalidParam("addreIdパラメータは数値で指定してください。", c)
		return
	}
	var requestAddr dto.ShippingAddressInput
	err = c.ShouldBindJSON(&requestAddr)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	userId := utils.GetUserID(c)
	resAddr, err := shippingService.SetAddress(userId, uint64(addrId), requestAddr)
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithDetailed(resAddr, "編集成功", c)
}

// DeleteAddress
// @Tags Shipping
// @Summary 指定した配送先住所IDの情報を削除する
// @Security ApiKeyAuth
// @accept    application/json
// @Produce   application/json
// @Param  addressId path int true "address Id"
// @Success   200  "指定した配送先住所IDの情報を削除する"
// @Router    /shipping-addresses/{addressId} [delete]
func (s *ShippingApi) DeleteAddress(c *gin.Context) {
	addrIdstr := c.Param("addressId")
	addrId, err := strconv.Atoi(addrIdstr)
	if err != nil {
		response.InvalidParam("addreIdパラメータは数値で指定してください。", c)
		return
	}
	userId := utils.GetUserID(c)
	err = shippingService.DeleteAddress(userId, uint64(addrId))
	if err != nil {
		if appErr, ok := err.(*response.AppError); ok {
			response.JSONError(c, appErr)
			return
		}
		response.JSONError(c, response.ErrInternal)
		return
	}
	response.OkWithMessage("住所を削除しました", c)
}
