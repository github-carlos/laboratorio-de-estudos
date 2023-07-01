package entity

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

type Transaction struct {
	ID          string
	AccountFrom *Account
	AccountTo   *Account
	Amount      float64
	CreatedAt   time.Time
}

func NewTransaction(from *Account, to *Account, amount float64) (*Transaction, error) {
	t := &Transaction{
		ID:          uuid.New().String(),
		AccountFrom: from,
		AccountTo:   to,
		Amount:      amount,
		CreatedAt:   time.Now(),
	}

	err := t.Validate()
	if err != nil {
		return nil, err
	}
	t.Commit()
	return t, nil
}

func (t *Transaction) Validate() error {
	if t.Amount <= 0 {
		return errors.New("Invalid amount")
	}
	if t.AccountFrom.Balance < t.Amount {
		return errors.New("Insuficient balance")
	}
	return nil
}

func (t *Transaction) Commit() {
	t.AccountFrom.Debit(t.Amount)
	t.AccountTo.Credit(t.Amount)
}
