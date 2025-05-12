package products

import "github.com/flipped-aurora/gin-vue-admin/server/service"

type ApiGroup struct {
	ProductsApi
	FavoritesApi
	HistoryApi
	CartApi
	ShippingApi
	PaymentApi
	OrdersApi
}

var (
	productsService  = service.ServiceGroupApp.ProductsServiceGroup.ProductsService
	favoritesService = service.ServiceGroupApp.ProductsServiceGroup.FavoritesService
	historyService   = service.ServiceGroupApp.ProductsServiceGroup.HistoryService
	cartService      = service.ServiceGroupApp.ProductsServiceGroup.CartService
	shippingService  = service.ServiceGroupApp.ProductsServiceGroup.ShippingService
	paymentService   = service.ServiceGroupApp.ProductsServiceGroup.PaymentService
	ordersService    = service.ServiceGroupApp.ProductsServiceGroup.OrdersService
)
