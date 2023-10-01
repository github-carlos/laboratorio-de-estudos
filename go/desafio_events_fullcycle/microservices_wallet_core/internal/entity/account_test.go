package entity

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateAccountWithSuccess(t *testing.T) {
	client, _ := NewClient("Carlos", "carlos@email")
	account := NewAccount(client)

	assert.NotNil(t, account)
	assert.Equal(t, client.ID, account.Client.ID)
}

func TestCreateAccountWithNilValue(t *testing.T) {
	var client *Client
	account := NewAccount(client)
	assert.Nil(t, account)
}

func TestCreditAccount(t *testing.T) {
	var client, _ = NewClient("carlos", "carlos@email")
	account := NewAccount(client)

	account.Credit(100)
	assert.Equal(t, float64(100), account.Balance)
}

func TestDebtAccount(t *testing.T) {
	var client, _ = NewClient("carlos", "carlos@email")
	account := NewAccount(client)

	account.Credit(100)
	account.Debit(50)
	assert.Equal(t, float64(50), account.Balance)
}
