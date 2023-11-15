package main

import (
	"fmt"
	"sync"
)

func main() {

	a := []int{10, 20, 30, 40}

	var wg sync.WaitGroup

	ch := make(chan int)

	for _, item := range a {
		wg.Add(1)
		go func(item int) {
			ch <- item
			wg.Done()
		}(item)
	}

	go func() {
		wg.Wait()
		close(ch)
	}()

	for value := range ch {
		fmt.Println(value)
	}
}
