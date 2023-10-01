package usecases

type GetAccountUseCase struct {}

func (uc *GetAccountUseCase) Run() (string, error) {
	return "Carlos Eduardo", nil
}

func NewGetAccountUseCase() *GetAccountUseCase {
	return &GetAccountUseCase{}
}