package entity

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_CreateClientWithSuccess(t *testing.T) {
	name := "Carlos"
	email := "carlos@email"

	client, err := NewClient(name, email)
	assert.Nil(t, err)
	assert.Equal(t, name, client.Name)
	assert.Equal(t, email, client.Email)
}

func Test_ReturnErrorWhenInvalidName(t *testing.T) {
	name := ""
	email := "carlos@email"
	client, err := NewClient(name, email)
	assert.Nil(t, client)
	assert.Equal(t, err.Error(), "Client name must be given")
}

func Test_ReturnErrorWhenInvalidEmail(t *testing.T) {
	name := "Carlos"
	email := ""
	client, err := NewClient(name, email)
	assert.Nil(t, client)
	assert.Equal(t, err.Error(), "Email must be given")
}

func Test_UpdateClientWithSuccess(t *testing.T) {
	client, _ := NewClient("carlos", "carlos@email")
	assert.NotNil(t, client)
	err := client.Update("Carlos Eduardo", "carlos@email")
	assert.Nil(t, err)
	assert.Equal(t, "Carlos Eduardo", client.Name)
	assert.Equal(t, "carlos@email", client.Email)
}

func Test_UpdateClientWithError(t *testing.T) {
	client, _ := NewClient("carlos", "carlos@email")
	assert.NotNil(t, client)
	err := client.Update("", "carlos@email")
	assert.NotNil(t, err)
	assert.Equal(t, err.Error(), "Invalid Params")
}
