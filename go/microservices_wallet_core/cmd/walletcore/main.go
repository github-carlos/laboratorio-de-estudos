package main

import (
	"database/sql"
	"fmt"
	"microserviceswalletcore/internal/database"
	"microserviceswalletcore/internal/event"
	createaccount "microserviceswalletcore/internal/usecase/create_account"
	createclient "microserviceswalletcore/internal/usecase/create_client"
	createtransaction "microserviceswalletcore/internal/usecase/create_transaction"
	"microserviceswalletcore/internal/web"
	"microserviceswalletcore/internal/web/webserver"
	"microserviceswalletcore/pkg/events"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", "root", "root", "localhost", "3306", "wallet"))

	if err != nil {
		panic(err)
	}

	defer db.Close()

	eventDispatcher := events.NewEventDispatcher()
	transactionCreatedEvent := event.NewTransactionCreated()

	clientDB := database.NewClientDB(db)
	accountDB := database.NewAccountDB(db)
	transactionDB := database.NewTransactionDB(db)

	createClientUseCase := createclient.NewCreateClientUseCase(clientDB)
	createAccountUseCase := createaccount.NewCreateAccountUseCase(accountDB, clientDB)
	createTransactionUseCase := createtransaction.NewCreateTransactionUseCase(transactionDB, accountDB, &eventDispatcher, transactionCreatedEvent)

	webserver := webserver.NewWebServer(":3000")

	clientHandler := web.NewWebClientHandler(*createClientUseCase)
	accountHandler := web.NewWebAccountHandler(*createAccountUseCase)
	transactionHandler := web.NewWebTransactionHandler(*&createTransactionUseCase)

	webserver.AddHandler("/clients", clientHandler.CreateClient)
	webserver.AddHandler("/accounts", accountHandler.CreateAccount)
	webserver.AddHandler("/transactions", transactionHandler.CreateTransaction)

	webserver.Start()
}
