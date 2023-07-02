package createaccount

import (
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/gateway"
)

type CreateAccountInputDto struct {
	ClientID string
}
type CreateAccountOutputDto struct {
	ID string
}

type CreateAccountUseCase struct {
	AccountGateway gateway.AccountGateway
	ClientGateway  gateway.ClientGateway
}

func NewCreateAccountUseCase(ag gateway.AccountGateway, cg gateway.ClientGateway) *CreateAccountUseCase {
	return &CreateAccountUseCase{
		AccountGateway: ag,
		ClientGateway:  cg,
	}
}

func (uc CreateAccountUseCase) Execute(input CreateAccountInputDto) (*CreateAccountOutputDto, error) {
	client, err := uc.ClientGateway.Get(input.ClientID)

	if err != nil {
		return nil, err
	}
	account := entity.NewAccount(client)

	err = uc.AccountGateway.Save(account)

	if err != nil {
		return nil, err
	}

	return &CreateAccountOutputDto{
		ID: account.ID,
	}, nil
}
