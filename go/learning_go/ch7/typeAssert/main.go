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

	// crashes if we not use comma ok idiom
	i4, ok := i.(int)
	fmt.Println(ok, i4)
}
