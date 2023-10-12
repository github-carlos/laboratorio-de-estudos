package usecases

import (
	"consumer-api/internal/entities"
	"consumer-api/internal/repositories"
)

type GetAccountUseCase struct {
	repository repositories.AccountRepositoryInterface
}

func (uc *GetAccountUseCase) Run(uuid string) (*entities.Account, error) {
	account, err := uc.repository.Find(uuid)

	if err != nil {
		return nil, err
	}

	return account, nil
}

func NewGetAccountUseCase(repository repositories.AccountRepositoryInterface) *GetAccountUseCase {
	return &GetAccountUseCase{
		repository: repository,
	}
}