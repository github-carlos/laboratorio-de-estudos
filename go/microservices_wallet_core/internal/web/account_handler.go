package web

import (
	"encoding/json"
	createaccount "microserviceswalletcore/internal/usecase/create_account"
	"net/http"
)

type WebAccountHandler struct {
	createAccountUseCase createaccount.CreateAccountUseCase
}

func NewWebAccountHandler(uc createaccount.CreateAccountUseCase) *WebAccountHandler {
	return &WebAccountHandler{
		createAccountUseCase: uc,
	}
}

func (wac *WebAccountHandler) CreateAccount(w http.ResponseWriter, r *http.Request) {
	var dto createaccount.CreateAccountInputDto

	err := json.NewDecoder(r.Body).Decode(&dto)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	createdAccount, err := wac.createAccountUseCase.Execute(dto)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	err = json.NewEncoder(w).Encode(createdAccount)

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
}
