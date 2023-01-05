package application_test

import (
	"testing"

	"carlos.com/application"
	"github.com/stretchr/testify/require"
)

func TestProduc_Enable(t *testing.T) {
	product := application.Product{}
	product.Name = "Product Name"
	product.Status = application.DISABLED
	product.Price = 10

	err := product.Enable()
	require.Nil(t,err)
}