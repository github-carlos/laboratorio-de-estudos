package gateway

import "microserviceswalletcore/internal/entity"

type TransactionGateway interface {
	Create(t *entity.Transaction) error
}
