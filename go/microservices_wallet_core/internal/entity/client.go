package entity

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

type Client struct {
	ID        string
	Name      string
	Email     string
	Accounts  []*Account
	CreatedAt time.Time
	UpdatedAt time.Time
}

func NewClient(name string, email string) (*Client, error) {
	client := &Client{
		ID:        uuid.New().String(),
		Name:      name,
		Email:     email,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	if err := client.Validate(); err != nil {
		return nil, err
	}

	return client, nil
}

func (c *Client) Validate() error {
	if c.Name == "" {
		return errors.New("Client name must be given")
	}

	if c.Email == "" {
		return errors.New("Email must be given")
	}
	return nil
}

func (c *Client) Update(name string, email string) error {
	c.Name = name
	c.Email = email
	err := c.Validate()
	if err != nil {
		return errors.New("Invalid Params")
	}
	return nil
}

func (c *Client) addAccount(account *Account) error {
	if account.Client.ID != c.ID {
		return errors.New("Account does not belong to this client")
	}
	c.Accounts = append(c.Accounts, account)
	return nil
}