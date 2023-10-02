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

	consumer := kafka.NewKafkaConsumer(configMap, "balances")
	consumer.Consume()

	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})

	r.Run()
}
