package main

import "fmt"


func baseMultiply(base int) func(int) int {
	return func (x int) int {
		return base * x;
	}
}

func main() {
	base2 := baseMultiply(2);
	base4 := baseMultiply(4);

	fmt.Println(base2(2));
	fmt.Println(base4(2));
}