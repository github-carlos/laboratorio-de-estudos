package main

import "fmt"

func main() {

	ch1 := make(chan string)
	ch2 := make(chan string)

	go func() {
		v1 := "Goroutine 1"
		ch1 <- v1
	}()

	go func() {
		v2 := "Goroutine 2"
		ch2 <- v2
	}()

	// for {
	select {
	case a := <-ch1:
		fmt.Println(a)
		break
	case b := <-ch2:
		fmt.Println(b)
		break
		// default:
		// 	fmt.Println("default")
	}
	// }
}
