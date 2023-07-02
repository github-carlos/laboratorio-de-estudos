package createaccount

import (
	"microserviceswalletcore/internal/entity"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type ClientGatewayMock struct {
	mock.Mock
}

func (m *ClientGatewayMock) Get(ID string) (*entity.Client, error) {
	args := m.Called(ID)
	return args.Get(0).(*entity.Client), args.Error(1)
}

func (m *ClientGatewayMock) Save(c *entity.Client) error {
	args := m.Called(c)
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

func Test_CreateAccountUseCaseWithSuccess(t *testing.T) {
	agMock := &AccountGatewayMock{}
	agMock.On("Save", mock.Anything).Return(nil)

	client, _ := entity.NewClient("Carlos", "carlos@email")
	cgMock := &ClientGatewayMock{}
	cgMock.On("Get", mock.Anything).Return(client, nil)

	uc := NewCreateAccountUseCase(agMock, cgMock)

	input := CreateAccountInputDto{ClientID: client.ID}
	output, err := uc.Execute(input)
	assert.Nil(t, err)
	assert.NotNil(t, output.ID)
	cgMock.AssertExpectations(t)
	cgMock.AssertNumberOfCalls(t, "Get", 1)
	agMock.AssertExpectations(t)
	agMock.AssertNumberOfCalls(t, "Save", 1)
}
