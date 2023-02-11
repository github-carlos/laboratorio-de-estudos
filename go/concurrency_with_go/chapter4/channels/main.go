package main

import (
	"fmt"
	"strconv"
	"sync"
	"time"
)

func main() {
	var wg sync.WaitGroup
	chanell1()
	wg.Wait()
}

func chanell1() {
	ch := make(chan string)
	go func(){
		for i := 0; i < 3; i++ {
			ch <- "Hi " + strconv.Itoa(i)
			time.Sleep(1000)
		}
		close(ch)
	} ()

	for msg := range ch{
		fmt.Println(msg)
	}

}

func typeOfCreations(wg *sync.WaitGroup) {
	var chanell chan interface{};
	chanell = make(chan interface{})
	fmt.Println(chanell)

	var readOnlyChannel <-chan interface{};
	readOnlyChannel = make(<-chan interface{});
	fmt.Println(readOnlyChannel)

	writeOnlyChannel := make(chan<- interface{})
	fmt.Println(writeOnlyChannel)
	wg.Done()
}