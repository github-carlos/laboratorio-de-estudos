package createtransaction

import (
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/gateway"
)

type CreateTransactionInputDto struct {
	AccountIDFrom string
	AccountIDTo   string
	amount        float64
}
type CreateTransactionOutputDto struct {
	ID string
}

type CreateTransactionUseCase struct {
	TransactionGateway gateway.TransactionGateway
	AccountGateway     gateway.AccountGateway
}

func NewCreateTransactionUseCase(tg gateway.TransactionGateway, ag gateway.AccountGateway) CreateTransactionUseCase {
	return CreateTransactionUseCase{
		TransactionGateway: tg,
		AccountGateway:     ag,
	}
}

func (uc CreateTransactionUseCase) Execute(input CreateTransactionInputDto) (*CreateTransactionOutputDto, error) {
	accountFrom, err := uc.AccountGateway.FindById(input.AccountIDFrom)
	if err != nil {
		return nil, err
	}
	accountTo, err := uc.AccountGateway.FindById(input.AccountIDTo)
	if err != nil {
		return nil, err
	}
	transaction, err := entity.NewTransaction(accountFrom, accountTo, input.amount)

	if err != nil {
		return nil, err
	}

	err = uc.TransactionGateway.Create(*transaction)
	if err != nil {
		return nil, err
	}

	return &CreateTransactionOutputDto{ID: transaction.ID}, nil
}
