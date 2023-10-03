package main

import (
	"consumer-api/pkg/kafka"
	"fmt"
	"net/http"

	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/gin-gonic/gin"
)

func main() {
	fmt.Println("Initializing Consumer Server")

	configMap := &ckafka.ConfigMap {
		"bootstrap.servers": "kafka:29092",
		"group.id": "wallet",
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
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})

	r.Run(":8080")
}
