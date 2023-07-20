package createtransaction

import (
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/gateway"
	"microserviceswalletcore/pkg/events"
)

type CreateTransactionInputDto struct {
	AccountIDFrom string  `json:"account_id_from"`
	AccountIDTo   string  `json:"account_id_to"`
	Amount        float64 `json:"amount"`
}
type CreateTransactionOutputDto struct {
	ID string `json:"id"`
}

type CreateTransactionUseCase struct {
	TransactionGateway gateway.TransactionGateway
	AccountGateway     gateway.AccountGateway
	EventDispatcher    events.EventDispatcherInterface
	TransactionCreated events.EventInterface
}

func NewCreateTransactionUseCase(
	tg gateway.TransactionGateway,
	ag gateway.AccountGateway,
	ed events.EventDispatcherInterface,
	transactionCreated events.EventInterface,
) CreateTransactionUseCase {
	return CreateTransactionUseCase{
		TransactionGateway: tg,
		AccountGateway:     ag,
		EventDispatcher:    ed,
		TransactionCreated: transactionCreated,
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
	transaction, err := entity.NewTransaction(accountFrom, accountTo, input.Amount)

	if err != nil {
		return nil, err
	}

	err = uc.TransactionGateway.Create(transaction)
	if err != nil {
		return nil, err
	}
	output := &CreateTransactionOutputDto{ID: transaction.ID}

	uc.TransactionCreated.SetPayload(output)
	uc.EventDispatcher.Dispatch(uc.TransactionCreated)

	return output, nil
}
