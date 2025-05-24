package response

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

const (
	ERR_INVALID_PARAMETER      = 1001
	ERR_COUPON_INVALID         = 4001
	ERR_COUPON_EXPIRED         = 4002
	ERR_USER_COUPON_INVALID    = 4003
	ERR_COUPON_MIN_PURCHASE    = 4004
	ERR_NOT_FOUND              = 4040
	ERR_COUPON_NOT_FOUND       = 4041
	ERR_INSUFFICIENT_POINTS    = 4221
	ERR_INSUFFICIENT_STOCK     = 4222
	ERR_INTERNAL_SERVER        = 5000
	ERR_PAYMENT_GATEWAY_FAILED = 5011
)

type AppError struct {
	Code       int    // 自定义错误码
	Message    string // 给用户看的提示信息
	HTTPStatus int    // HTTP 状态码
}

func (e *AppError) Error() string {
	return e.Message
}

func NewAppError(code int, message string, httpStatus int) *AppError {
	return &AppError{
		Code:       code,
		Message:    message,
		HTTPStatus: httpStatus,
	}
}

// 定义统一的错误对象
var (
	ErrCouponNotFound       = NewAppError(ERR_COUPON_NOT_FOUND, "クーポン・ポイント情報が見つかりません", http.StatusNotFound)
	ErrCouponInvalid        = NewAppError(ERR_COUPON_INVALID, "無効なクーポンです", http.StatusBadRequest)
	ErrCouponExpired        = NewAppError(ERR_COUPON_EXPIRED, "クーポンは有効期限外です", http.StatusBadRequest)
	ErrUserCouponInvalid    = NewAppError(ERR_USER_COUPON_INVALID, "保有していない、または使用済みです", http.StatusBadRequest)
	ErrCouponMinPurchase    = NewAppError(ERR_COUPON_MIN_PURCHASE, "最低購入金額条件を満たしていません", http.StatusBadRequest)
	ErrInsufficientPoints   = NewAppError(ERR_INSUFFICIENT_POINTS, "保有ポイント不足", http.StatusUnprocessableEntity)
	ErrInsufficientStock    = NewAppError(ERR_INSUFFICIENT_STOCK, "在庫不足", http.StatusUnprocessableEntity)
	ErrPaymentGatewayFailed = NewAppError(ERR_PAYMENT_GATEWAY_FAILED, "支払い失敗", http.StatusNotImplemented)
	ErrNotFound             = NewAppError(ERR_NOT_FOUND, "情報が見つかりません", http.StatusNotFound)
	ErrInternal             = NewAppError(ERR_INTERNAL_SERVER, "内部サーバーエラー", http.StatusInternalServerError)
)

type ApiResponse struct {
	Code    int         `json:"code"`
	Message string      `json:"msg"`
	Data    interface{} `json:"data"`
}

func InvalidParam(msg string, c *gin.Context) {
	c.JSON(http.StatusBadRequest, Response{
		Code: ERR_INVALID_PARAMETER,
		Msg:  msg,
		Data: nil,
	})
}

func BadRequest(err *AppError, c *gin.Context) {

	c.JSON(http.StatusBadRequest, ApiResponse{
		Code:    err.Code,
		Message: err.Message,
		Data:    nil,
	})
}

func NotFound(err *AppError, c *gin.Context) {

	c.JSON(http.StatusNotFound, ApiResponse{
		Code:    err.Code,
		Message: err.Message,
		Data:    nil,
	})
}

func Unprocessable(err *AppError, c *gin.Context) {

	c.JSON(http.StatusUnprocessableEntity, ApiResponse{
		Code:    err.Code,
		Message: err.Message,
		Data:    nil,
	})
}

func JSONOK(c *gin.Context, data interface{}, msg string) {
	c.JSON(http.StatusOK, Response{
		Code: SUCCESS,
		Msg:  msg,
		Data: data,
	})
}

func JSONError(c *gin.Context, err *AppError) {
	c.JSON(err.HTTPStatus, Response{
		Code: err.Code,
		Msg:  err.Message,
		Data: nil,
	})
}
