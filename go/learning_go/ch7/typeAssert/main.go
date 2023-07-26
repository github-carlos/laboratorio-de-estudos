package main

import "fmt"

type MyInt int

func main() {
	var i interface{}
	var myInt MyInt = 2

	i = myInt

	i2 := i.(MyInt)
	i3 := i2 + 4
	fmt.Println(i3)
}
