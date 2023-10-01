package controllers

import (
	"consumer-api/internal/usecases"
	"fmt"
)

type AccountController struct {
	GetAccountUseCase usecases.UseCase
}

func (ac *AccountController) getAccount(accountId string) (string, error) {
	account, 
	err := ac.GetAccountUseCase.Run()

	if err != nil {
		return "", err
	}

	fmt.Println("Account", account)
	return account, nil
}