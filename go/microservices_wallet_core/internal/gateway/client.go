package gateway

import "microserviceswalletcore/internal/entity"

type ClientGateway interface {
	Get(ID string) (*entity.Client, error)
	Save(client *entity.Client) error
}
