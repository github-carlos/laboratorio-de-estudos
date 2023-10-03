package kafka

import (
	"fmt"

	"github.com/confluentinc/confluent-kafka-go/v2/kafka"
)

type Consumer struct {
	config *kafka.ConfigMap
	topic string
}

func NewKafkaConsumer(config *kafka.ConfigMap, topic string) *Consumer {
	return &Consumer{
		config: config,
		topic: topic,
	};
}

func (c *Consumer) Consume(channel chan *kafka.Message) error {
	newConsumer, err := kafka.NewConsumer(c.config)

	if err != nil {
		return err;
	}

	defer newConsumer.Close();

	err = newConsumer.SubscribeTopics([]string{c.topic}, nil)

	if err != nil {
		return err;
	}

	fmt.Println("Listening Topic Messages 2")
	for {
		msg, err := newConsumer.ReadMessage(-1);
		if err != nil {
			fmt.Println("Error reading topic", err)
		}
		channel <- msg;
	}
}