package main

import "fmt"

type Status int

const (
	InvalidLogin Status = iota + 1
	NotFound
)

type StatusErr struct {
	Status  Status
	Message string
}

func (se StatusErr) Error() string {
	return se.Message
}

func main() {

	fmt.Println(InvalidLogin)
	fmt.Println(NotFound)
}
