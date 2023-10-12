package main

import (
	"consumer-api/internal/controllers"
	"consumer-api/internal/repositories"
	"consumer-api/internal/usecases"
	"consumer-api/pkg/kafka"
	"fmt"
	"net/http"

	"database/sql"

	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	fmt.Println("Initializing Consumer Server")

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", "root", "root", "mysql-consumerapp", "3306", "wallet"))
	if err != nil {
		panic(err)
	}
	defer db.Close()

	configMap := &ckafka.ConfigMap{
		"bootstrap.servers": "kafka:29092",
		"group.id":          "wallet",
	}

	balancesChannel := make(chan *ckafka.Message)
	consumer := kafka.NewKafkaConsumer(configMap, "balances")
	go consumer.Consume(balancesChannel)

	go func() {
		for msg := range balancesChannel {
			fmt.Println("Message", msg)
		}
	}()

	r := gin.Default()

	accountRepository := repositories.NewAccountRepository(db)
	getAccountUseCase := usecases.NewGetAccountUseCase(accountRepository)
	accountController := controllers.NewAccountController(*getAccountUseCase)

	r.GET("/accounts/:uuid", func (c *gin.Context) {
		uuid := c.Param("uuid")
		account, err := accountController.GetAccountUseCase.Run(uuid)

		if err != nil {
			fmt.Println(err)
			c.JSON(http.StatusInternalServerError, err)
			return;
		}
		c.JSON(http.StatusOK, account)
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})

	r.Run(":8080")
}
