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
