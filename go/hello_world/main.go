package main

import (
	"fmt"
)

// func main() {
// 	fmt.Println("Hello, World!")
// }

func main() {
	fmt.Println(HelloMessage("Carlos"))
}

func HelloMessage(who string) string {
	return "Hello, " + who
}
