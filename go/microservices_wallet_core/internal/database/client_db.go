package database

import (
	"database/sql"
	"microserviceswalletcore/internal/entity"
)

type ClientDB struct {
	DB *sql.DB
}

func NewClientDB(db *sql.DB) *ClientDB {
	return &ClientDB{
		DB: db,
	}
}

func (db *ClientDB) Get(id string) (*entity.Client, error) {
	client := &entity.Client{}
	stmt, err := db.DB.Prepare("SELECT * FROM clients WHERE id=?")
	if err != nil {
		return nil, err
	}

	defer stmt.Close()

	row := stmt.QueryRow(id)

	err = row.Scan(&client.ID, &client.Name, &client.Email, &client.CreatedAt)

	if err != nil {
		return nil, err
	}
	return client, nil
}

func (db *ClientDB) Save(client *entity.Client) error {
	stmt, err := db.DB.Prepare("INSERTO INTO clients (id, name, email, created_at) VALUES (?, ?, ?, ?)")

	if err != nil {
		return err
	}
	defer stmt.Close()
	_, err = stmt.Exec(client.ID, client.Name, client.Email, client.CreatedAt)

	if err != nil {
		return err
	}
	return nil
}
