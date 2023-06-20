package main

import "fmt"

func main() {
	fmt.Println("Hello, World!")
	fmt.Println("Sum:", sumInts(5, 5))
	fmt.Println("3 is Pair:", isPair(3))
	fmt.Println("4 is Pair:", isPair(4))
	fmt.Println("2 is Pair:", isPair(2))
	fmt.Println("1 is Pair:", isPair(1))
}

func sumInts(num1 int, num2 int) int {
	return num1 + num2
}

func isPair(num int) bool {
	return num&1 != 1
}
