package main

import (
	"fmt"
)

func main() {
	generator := func(done <-chan interface{}, integers ...int) <-chan int {
		intStream := make(chan int)

		go func() {
			defer close(intStream)
			for _, value := range integers {
				select {
				case <-done:
					return
				case intStream <- value:
				}
			}
		}()

		return intStream
	}

	multiply := func (done <-chan interface{}, intStream <-chan int, multiplier int) <-chan int {
		multiplyChan := make(chan int);

		go func() {
			defer close(multiplyChan);
			for n := range intStream {
				select {
				case <- done:
					return;
				case multiplyChan <- n * multiplier:
				}
			}
		}()

		return multiplyChan
	}

	add := func(done <-chan interface{}, intStream <-chan int, addtion int) <-chan int {
		addStream := make(chan int)

		go func() {
			defer close(addStream)
			for number := range intStream {
				select {
				case <-done:
					return;
				case addStream <- number + addtion:
				}
			}
		}()

		return addStream
	}
	 
	done := make(chan interface{})
	defer close(done)

	pipeline := add(done, multiply(done, generator(done, 1, 2, 3, 4), 2), 3)
	for n := range  pipeline {
		fmt.Println(n)
	}
}
