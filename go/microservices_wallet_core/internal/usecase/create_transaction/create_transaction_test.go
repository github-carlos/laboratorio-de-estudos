package createtransaction

import (
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/event"
	"microserviceswalletcore/pkg/events"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type TransactionGatewayMock struct {
	mock.Mock
}

func (m *TransactionGatewayMock) Create(t *entity.Transaction) error {
	args := m.Called(t)
	return args.Error(0)
}

type AccountGatewayMock struct {
	mock.Mock
}

func (m *AccountGatewayMock) FindById(ID string) (*entity.Account, error) {
	args := m.Called(ID)
	return args.Get(0).(*entity.Account), args.Error(1)
}

func (m *AccountGatewayMock) Save(ac *entity.Account) error {
	args := m.Called(ac)
	return args.Error(0)
}

func TestCreateTransactionUseCaseSuccess(t *testing.T) {
	clientA, _ := entity.NewClient("A", "a@email")
	accountA := entity.NewAccount(clientA)
	accountA.Credit(1000)

	clientB, _ := entity.NewClient("B", "b@email")
	accountB := entity.NewAccount(clientB)
	accountB.Credit(1000)

	mockAccount := &AccountGatewayMock{}
	mockAccount.On("FindById", accountA.ID).Return(accountA, nil)
	mockAccount.On("FindById", accountB.ID).Return(accountB, nil)

	mockTransaction := &TransactionGatewayMock{}
	mockTransaction.On("Create", mock.Anything).Return(nil)

	inputDto := CreateTransactionInputDto{
		AccountIDFrom: accountA.ID,
		AccountIDTo:   accountB.ID,
		amount:        100,
	}

	dispatcher := events.NewEventDispatcher()
	event := event.NewTransactionCreated()
	uc := NewCreateTransactionUseCase(mockTransaction, mockAccount, &dispatcher, event)

	output, err := uc.Execute(inputDto)
	assert.Nil(t, err)
	assert.NotNil(t, output)
	mockAccount.AssertExpectations(t)
	mockTransaction.AssertExpectations(t)
	mockAccount.AssertNumberOfCalls(t, "FindById", 2)
	mockTransaction.AssertNumberOfCalls(t, "Create", 1)
}
