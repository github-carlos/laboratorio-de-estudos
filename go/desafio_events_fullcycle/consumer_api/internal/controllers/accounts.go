package controllers

import (
	"consumer-api/internal/entities"
	"consumer-api/internal/usecases"
	"fmt"
)

type AccountController struct {
	GetAccountUseCase usecases.GetAccountUseCase
}

func (ac *AccountController) GetAccount(uuid string) (*entities.Account, error) {
	account, 
	err := ac.GetAccountUseCase.Run(uuid)

	if err != nil {
		return nil, err
	}

	fmt.Println("Found Account", account)
	return account, nil
}

func NewAccountController(useCase usecases.GetAccountUseCase) *AccountController {
	return &AccountController{
		GetAccountUseCase: useCase,
	}
}