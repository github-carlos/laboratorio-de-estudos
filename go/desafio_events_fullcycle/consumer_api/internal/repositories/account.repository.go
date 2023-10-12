package repositories

import (
	"consumer-api/internal/entities"
	"database/sql"
)

type AccountRepositoryInterface interface {
	Find(uuid string) (*entities.Account, error);
	UpdateAccount(account *entities.Account) error;
	CreateAccount(account *entities.Account) error;
}

type AccountRepository struct {
	DB *sql.DB
}

func (ac *AccountRepository) Find(uuid string) (*entities.Account, error) {
	var account entities.Account;
	stmt, err := ac.DB.Prepare("Select * from Accounts where id = ?")

	if err != nil {
		return nil, err;
	}

	defer stmt.Close()

	row := stmt.QueryRow(uuid)

	err = row.Scan(
		&account.Uuid,
		&account.Balance,
	)

	if err == sql.ErrNoRows {
		return nil, nil;
	}
	
	if err != nil {
		return nil, err;
	}

	return &account, nil;
}

func (ac *AccountRepository) UpdateAccount(account *entities.Account) error {
	stmt, err := ac.DB.Prepare("UPDATE Accounts set balance = ? where id = ?")

	if err != nil {
		return err
	}

	defer stmt.Close()

	_, err = stmt.Exec(account.Balance, account.Uuid);

	return err
}

func (ac *AccountRepository) CreateAccount(account *entities.Account) error {
	stmt, err := ac.DB.Prepare("INSERTO INTO Accounts (id, balance) values (?, ?)")

	if err != nil {
		return err
	}

	defer stmt.Close()

	_, err = stmt.Exec(account.Uuid, account.Balance)
	return err;
}

func NewAccountRepository(db *sql.DB) *AccountRepository {
	return &AccountRepository{
		DB: db,
	}
}