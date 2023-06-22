package main

import (
	"fmt"
	"io"
	"log"
	"os"
)

func main() {
	fmt.Println("Reading file...")
	args := os.Args
	var fileName string = args[1]

	file, err := os.Open(fileName)

	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()
	data := make([]byte, 2048)

	for {
		count, error := file.Read(data)
		os.Stdout.Write(data[:count])
		if error != nil {
			if error != io.EOF {
				log.Fatal(error)
			}
			break
		}
	}

}
