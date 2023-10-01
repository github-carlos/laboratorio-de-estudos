package database

import (
	"database/sql"
	"microserviceswalletcore/internal/entity"
	"testing"

	_ "github.com/mattn/go-sqlite3"
	"github.com/stretchr/testify/suite"
)

type ClientDBTestSuite struct {
	suite.Suite
	db       *sql.DB
	clientDB *ClientDB
}

func (c *ClientDBTestSuite) SetupSuite() {
	db, err := sql.Open("sqlite3", ":memory:")
	c.Nil(err)
	c.db = db
	db.Exec("CREATE TABLE clients (id varchar(255), name varchar(255), email varchar(255), created_at date)")
	c.clientDB = NewClientDB(db)
}

func (c *ClientDBTestSuite) TearDownSuite() {
	defer c.db.Close()
	c.db.Exec("DROP TABLE clients")
}

func TestClientDBTestSuite(t *testing.T) {
	suite.Run(t, new(ClientDBTestSuite))
}

func (c *ClientDBTestSuite) TestSave() {
	client := &entity.Client{
		ID:    "1",
		Name:  "Carlos",
		Email: "carlos@email",
	}
	err := c.clientDB.Save(client)
	c.Nil(err)
}

func (c *ClientDBTestSuite) TestGet() {
	client, _ := entity.NewClient("Carlos", "carlos@email.com")

	c.clientDB.Save(client)

	clientDB, err := c.clientDB.Get(client.ID)
	c.Nil(err)
	c.Equal(client.Name, clientDB.Name)
	c.Equal(client.Email, clientDB.Email)
}
