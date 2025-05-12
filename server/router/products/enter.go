package products

import (
	api "github.com/flipped-aurora/gin-vue-admin/server/api/v1"
)

type RouterGroup struct {
	ProductsRouter
	FavoritesRouter
	HistoryRouter
	CartRouter
	ShippingRouter
	PaymentRouter
	OredrsRouter
}

var (
	productsApi  = api.ApiGroupApp.ProductsApiGroup.ProductsApi
	favoritesApi = api.ApiGroupApp.ProductsApiGroup.FavoritesApi
	historyApi   = api.ApiGroupApp.ProductsApiGroup.HistoryApi
	cartApi      = api.ApiGroupApp.ProductsApiGroup.CartApi
	shippingApi  = api.ApiGroupApp.ProductsApiGroup.ShippingApi
	paymentApi   = api.ApiGroupApp.ProductsApiGroup.PaymentApi
	ordersApi    = api.ApiGroupApp.ProductsApiGroup.OrdersApi
)
