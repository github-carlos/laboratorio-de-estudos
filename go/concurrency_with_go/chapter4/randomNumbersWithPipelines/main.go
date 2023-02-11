package main

import (
	"fmt"
	"math/rand"
)

func repeatedFn(done <-chan interface{}, fn func() float64) <-chan interface{} {
	valueStream := make(chan interface{});
	
	go func() {
		defer close(valueStream);
		for {
			select {
			case <-done:
				return;
			case valueStream <- fn():
			}
		}

	}()

	return valueStream;
}

func take(done <-chan interface{}, stream <-chan interface{}, repeat int) <-chan interface{} {
	takeStream := make(chan interface{});
	
	go func() {
		defer close(takeStream)
		for i := 0; i < repeat; i++ {
			select {
			case <-done:
				return;
			case takeStream <- <-stream:
			}
		}
	}()

	return takeStream;
}

func main() {
	done := make(chan interface{});
	defer close(done)
	for randomNumber := range take(done, repeatedFn(done, rand.Float64), 2) {
		fmt.Println(randomNumber)
	}
}