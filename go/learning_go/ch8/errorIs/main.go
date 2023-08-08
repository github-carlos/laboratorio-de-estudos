package main

import (
	"errors"
	"fmt"
	"os"
)

func fileChecker(name string) error {
	file, err := os.Open(name)
	if err != nil {
		return fmt.Errorf("in file checker: %w", err)
	}
	file.Close()
	return nil
}
func main() {
	err := fileChecker("invalid.txt")

	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			fmt.Println("File does not exist!")
		}
	}
}
