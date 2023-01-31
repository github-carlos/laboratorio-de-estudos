package main

import (
	"fmt"
	"sync"
)

func sayHello(wg *sync.WaitGroup) {
	defer wg.Done()
	fmt.Println("Hello")
}

func main() {
	var wait sync.WaitGroup
	wait.Add(1)
	go sayHello(&wait)
	wait.Wait()
}