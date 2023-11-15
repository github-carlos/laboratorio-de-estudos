package main

import "fmt"

func genValues(max int) <-chan int {
	ch := make(chan int)

	go func() {
		for i := 0; i < max; i++ {
			ch <- i
		}
		close(ch)
	}()
	return ch
}

func main() {

	for value := range genValues(10) {
		fmt.Println(value)
	}
}
