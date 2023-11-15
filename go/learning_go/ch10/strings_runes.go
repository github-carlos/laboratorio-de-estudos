package main

import "fmt"

func main() {
	a := "Carlos Eduardo"

	for item := range a {
		fmt.Println("Hello World \n", rune(a[item]))
	}

	str := "Hello, 世界"
	runes := []rune(str)
	charAtIndex7 := runes[0] // Get the rune at index 7

	// Print the rune as a character
	fmt.Printf("Character at index 7: %c\n", charAtIndex7)

	str1 := "Boa"
	str2 := "Noite"
	str3 := str1 + str2
	println(str3)
}
