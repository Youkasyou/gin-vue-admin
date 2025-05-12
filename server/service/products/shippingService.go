package products

import (
	"errors"
	"fmt"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
)

type ShippingService struct{}

func (shippingService *ShippingService) GetAddress(id uint) (res *dto.ShippingAddressListResponse, err error) {
	entity := []dto.ShippingAddressInfo{}
	err = global.GVA_DB.Table("user_shipping_addresses").
		Select(`id as address_id,postal_code,prefecture,city,address_line1,address_line2,
				recipient_name,phone_number,is_default`).
		Where("user_id = ?", id).Order("created_at desc").Find(&entity).Error

	addressList := &dto.ShippingAddressListResponse{}
	addressList.Addresses = entity

	return addressList, err
}

func (shippingService *ShippingService) AddAddress(id uint, reqAddr dto.ShippingAddressInput) (res *dto.ShippingAddressInfo, err error) {
	insertAddr := dto.ShippingAddressEntity{
		UserId:        id,
		PostalCode:    reqAddr.PostalCode,
		Prefecture:    reqAddr.Prefecture,
		City:          reqAddr.City,
		AddressLine1:  reqAddr.AddressLine1,
		AddressLine2:  reqAddr.AddressLine2,
		RecipientName: reqAddr.RecipientName,
		PhoneNumber:   reqAddr.PhoneNumber,
		IsDefault:     reqAddr.IsDefault,
		CreatedAt:     time.Now(),
		UpdatedAt:     time.Now(),
	}

	err = global.GVA_DB.Table("user_shipping_addresses").Create(&insertAddr).Error

	resAddr := &dto.ShippingAddressInfo{
		AddressID:     insertAddr.ID,
		PostalCode:    insertAddr.PostalCode,
		Prefecture:    insertAddr.Prefecture,
		City:          insertAddr.City,
		AddressLine1:  insertAddr.AddressLine1,
		AddressLine2:  insertAddr.AddressLine2,
		RecipientName: insertAddr.RecipientName,
		PhoneNumber:   insertAddr.PhoneNumber,
		IsDefault:     insertAddr.IsDefault,
	}

	return resAddr, err
}
func (shippingService *ShippingService) SetAddress(id uint, addrId uint64, reqAdder dto.ShippingAddressInput) (res *dto.ShippingAddressInfo, err error) {
	var EXISTS bool
	err = global.GVA_DB.Table("user_shipping_addresses").
		Select("1").Where("id = ? and user_id = ?", addrId, id).Limit(1).Scan(&EXISTS).Error
	if err != nil {
		fmt.Println("数据库错误")
		return
	}
	if !EXISTS {
		fmt.Println("未找到该地址")
		return nil, errors.New("not found")
	}

	err = global.GVA_DB.Table("user_shipping_addresses").
		Where("user_id = ? and id = ?", id, addrId).Updates(reqAdder).Error
	if err != nil {
		fmt.Println("数据跟新失败")
		return
	}

	err = global.GVA_DB.Table("user_shipping_addresses").
		Select(`postal_code,prefecture,city,address_line1,address_line2,
				recipient_name,phone_number,is_default`).
		Where("id = ?", addrId).Find(&res).Error

	return
}
func (shippingService *ShippingService) DeleteAddress(id uint, addrId uint64) (err error) {
	result := global.GVA_DB.Exec(`DELETE FROM user_shipping_addresses WHERE user_id = ? AND id = ?`, id, addrId)
	if result.RowsAffected == 0 {
		return errors.New("ErrCartItemNotFound")
	}
	return
}
