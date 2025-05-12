package system

import (
	"time"
)

type LoginHistory struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `json:"userid"  gorm:"comment:用户ID"`
	LoginTime time.Time `json:"logintime"  gorm:"comment:登录时间"`
}

func (LoginHistory) TableName() string {
	return "user_login_history"
}
