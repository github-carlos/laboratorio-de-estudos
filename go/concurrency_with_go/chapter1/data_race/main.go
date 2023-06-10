package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {

	var memoryAccess sync.Mutex
	var data int

	go func() {
		fmt.Println("rodou rotina")
		memoryAccess.Lock()
		data++
		memoryAccess.Unlock()
	}()

	// time.Sleep(1 * time.Second)
	memoryAccess.Lock()
	time.Sleep(2 * time.Second)
	if data == 0 {
		fmt.Println("Data value is 0")
	} else {
		fmt.Println("Data value is", data)
	}

	memoryAccess.Unlock()
}
