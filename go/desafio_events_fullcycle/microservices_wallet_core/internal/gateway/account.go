package gateway

import "microserviceswalletcore/internal/entity"

type AccountGateway interface {
	FindById(ID string) (*entity.Account, error)
	Save(a *entity.Account) error
	UpdateBalance(a *entity.Account) error
}
