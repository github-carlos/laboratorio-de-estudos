package usecases

type UseCase interface {
	Run() (string, error)
}