package products

type ServiceGroup struct {
	ProductsService
	FavoritesService
	HistoryService
	CartService
	ShippingService
	PaymentService
	OrdersService
	CategoryService
}
