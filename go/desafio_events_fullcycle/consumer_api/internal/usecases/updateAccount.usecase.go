package usecases

import (
	"consumer-api/internal/entities"
	"consumer-api/internal/repositories"
)
type UpdateAccountUseCase struct {
	repository repositories.AccountRepositoryInterface
}

func (uc *UpdateAccountUseCase) Run(account *entities.Account) error {

	alreadySaved, err := uc.repository.Find(account.Uuid)

	if err != nil {
		return err;
	}

	if alreadySaved != nil {
		err = uc.repository.UpdateAccount(account)
		return err;
	}

	err = uc.repository.CreateAccount(account);

	return err;
}