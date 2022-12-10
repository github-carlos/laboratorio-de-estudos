package main

import (
	"fmt"
)

// func main() {
// 	fmt.Println("Hello, World!")
// }

const spanish = "Spanish"
const french = "French"
const englishHelloPrefix = "Hello, "
const spanishHelloPrefix = "Hola, "
const frenchHelloPrefix = "Bonjour, "

func main() {
	fmt.Println(HelloMessage("Carlos", ""))
}

func HelloMessage(who string, language string) (prefix string) {

	if who == "" {
		who = "World"
	}
	switch language {
	case spanish:
		prefix = spanishHelloPrefix
	case french:
		prefix = frenchHelloPrefix
	default:
		prefix = englishHelloPrefix
	}

	return prefix + who
}
