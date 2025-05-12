package dto

// PaymentMethodInfo 利用可能な支払い方法情報
type PaymentMethodInfo struct {
	MethodID    int     `json:"method_id"`
	MethodCode  string  `json:"method_code"`
	Name        string  `json:"name"`
	Description *string `json:"description,omitempty"`
}
