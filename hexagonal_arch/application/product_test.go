package application_test

import (
	"testing"

	"carlos.com/application"
	uuid "github.com/satori/go.uuid"
	"github.com/stretchr/testify/require"
)

func TestProduc_Enable(t *testing.T) {
	product := application.Product{}
	product.Name = "Product Name"
	product.Status = application.DISABLED
	product.Price = 10

	err := product.Enable()
	require.Nil(t,err)

	product.Price = 0
	err = product.Enable()
	require.EqualError(t, err, "Price must be greater than zero")
}

func TestProduc_Disable(t *testing.T) {
	product := application.Product{}
	product.Name = "Product Name"
	product.Status = application.ENABLED
	product.Price = 10

	err := product.Disable()

	require.EqualError(t, err, "Price must be equal zero to be disabled")

	product.Price = 0
	err = product.Disable()

	require.Nil(t, err)
}

func TestProduct_IsValid(t *testing.T) {
	product := application.Product{}
	product.Name = "PRoduct Name"
	product.Status = application.DISABLED
	product.Price = 10
	product.ID = uuid.NewV4().String()

	_, err := product.IsValid()

	require.Nil(t, err)

	product.Status = "invalid"
	_, err = product.IsValid()
	require.EqualError(t, err, "Status must be Enabled or Disabled")

	product.Status = application.ENABLED
	_, err = product.IsValid()
	require.Nil(t, err)

	product.Price = -10
	_, err = product.IsValid()
	require.EqualError(t, err, "Price must be greater or equal zero")
}