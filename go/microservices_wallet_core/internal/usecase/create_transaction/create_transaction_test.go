package createtransaction

import (
	"context"
	"microserviceswalletcore/internal/entity"
	"microserviceswalletcore/internal/event"
	"microserviceswalletcore/internal/usecase/mocks"
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

	mockUow := &mocks.UowMock{}

	mockUow.On("Do", mock.Anything, mock.Anything).Return(nil)

	inputDto := CreateTransactionInputDto{
		AccountIDFrom: accountA.ID,
		AccountIDTo:   accountB.ID,
		Amount:        100,
	}

	dispatcher := events.NewEventDispatcher()
	event := event.NewTransactionCreated()
	ctx := context.Background()
	uc := NewCreateTransactionUseCase(mockUow, &dispatcher, event)

	output, err := uc.Execute(ctx, inputDto)
	assert.Nil(t, err)
	assert.NotNil(t, output)
	mockUow.AssertExpectations(t)
	mockUow.AssertNumberOfCalls(t, "Do", 1)
}
