package entity

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestTransactionWithSuccess(t *testing.T) {
	client1, _ := NewClient("Carlos", "carlos@email")
	account1 := NewAccount(client1)
	account1.Credit(100)

	client2, _ := NewClient("Eduardo", "eduardo@email.com")
	account2 := NewAccount(client2)

	transaction, err := NewTransaction(account1, account2, 50)
	assert.Nil(t, err)

	assert.Equal(t, float64(50), account1.Balance)
	assert.Equal(t, float64(50), account2.Balance)
	assert.NotNil(t, transaction.ID)
}

func TestTransactionWithFail(t *testing.T) {
	client1, _ := NewClient("Carlos", "carlos@email")
	account1 := NewAccount(client1)
	account1.Credit(10)

	client2, _ := NewClient("Eduardo", "eduardo@email.com")
	account2 := NewAccount(client2)

	_, err := NewTransaction(account1, account2, 50)
	assert.NotNil(t, err)
	assert.Equal(t, "Insuficient balance", err.Error())
}
func TestTransactionWithFail2(t *testing.T) {
	client1, _ := NewClient("Carlos", "carlos@email")
	account1 := NewAccount(client1)
	account1.Credit(100)

	client2, _ := NewClient("Eduardo", "eduardo@email.com")
	account2 := NewAccount(client2)

	_, err := NewTransaction(account1, account2, 0)
	assert.NotNil(t, err)
	assert.Equal(t, "Invalid amount", err.Error())
}
