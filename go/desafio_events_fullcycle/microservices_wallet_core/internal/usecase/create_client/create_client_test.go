package createclient

import (
	"microserviceswalletcore/internal/entity"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

// type MockClientGateway struct{}

// func (mock *MockClientGateway) Get(ID string) (*entity.Client, error) {
// 	return entity.NewClient("Carlos", "carlos@email.com")
// }

// func (mock *MockClientGateway) Save(c *entity.Client) error {
// 	return nil
// }

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

// func TestCreaetClientSuccess(t *testing.T) {
// 	mockCG := &MockClientGateway{}
// 	uc := NewCreateClientUseCase(mockCG)
// 	input := CreateClientInputDto{Name: "Carlos", Email: "carlos@email.com"}

// 	output, err := uc.Execute(input)
// 	assert.Nil(t, err)
// 	assert.Equal(t, input.Name, output.Name)
// 	assert.NotNil(t, output.ID)
// }

func TestCreaetClientSuccess(t *testing.T) {
	mockCG := &ClientGatewayMock{}
	mockCG.On("Save", mock.Anything).Return(nil)

	uc := NewCreateClientUseCase(mockCG)
	input := CreateClientInputDto{Name: "Carlos", Email: "carlos@email.com"}

	output, err := uc.Execute(input)
	assert.Nil(t, err)
	assert.Equal(t, input.Name, output.Name)
	assert.NotNil(t, output.ID)
	mockCG.AssertExpectations(t)
	mockCG.AssertNumberOfCalls(t, "Save", 1)
}
