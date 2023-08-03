package main

import "fmt"

func doThings(i interface{}) {
	switch i.(type) {
	case nil:
		fmt.Println("nil")
	case int:
		fmt.Println("int")
	default:
		fmt.Println("dont know")
	}
}

func main() {
	doThings("a")
}
