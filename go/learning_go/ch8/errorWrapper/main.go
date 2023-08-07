package main

import (
	"errors"
	"fmt"
	"os"
)

func openFile(filename string) error {
	f, err := os.Open(filename)

	if err != nil {
		return fmt.Errorf("in openFile: %w", err)
	}
	f.Close()
	return nil
}

func main() {
	err := openFile("teste.mp4")
	if err != nil {
		fmt.Println(err)
		if wrappedError := errors.Unwrap(err); wrappedError != nil {
			fmt.Println(wrappedError)
		}
	}
}
