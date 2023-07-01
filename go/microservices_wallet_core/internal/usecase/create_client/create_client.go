package createclient

import (
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/gateway"
	"time"
)

type CreateClientInputDto struct {
	Name  string
	Email string
}

type CreateClientOutputDto struct {
	ID        string
	Name      string
	Email     string
	CreatedAt time.Time
	UpdatedAt time.Time
}

type CreateClientUseCase struct {
	ClientGateway gateway.ClientGateway
}

func NewCreateClientUseCase(cg gateway.ClientGateway) *CreateClientUseCase {
	return &CreateClientUseCase{
		ClientGateway: cg,
	}
}

func (uc *CreateClientUseCase) Execute(input CreateClientInputDto) (*CreateClientOutputDto, error) {
	client, err := entity.NewClient(input.Name, input.Email)

	if err != nil {
		return nil, err
	}

	err = uc.ClientGateway.Save(client)

	if err != nil {
		return nil, err
	}

	return &CreateClientOutputDto{
		ID:        client.ID,
		Name:      client.Name,
		Email:     client.Email,
		CreatedAt: client.CreatedAt,
		UpdatedAt: client.UpdatedAt,
	}, nil
}
