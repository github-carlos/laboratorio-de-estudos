package main

import (
	"errors"
	"fmt"
	"net/http"
)

// simple logger
func LogOutput(message string) {
	fmt.Println(message)
}

// create a store
type SimpleDataStore struct {
	userData map[string]string
}

func (sds *SimpleDataStore) UserNameForId(userId string) (string, bool) {
	name, ok := sds.userData[userId]
	return name, ok;
}

//factory for creating a new SimpleDataStore
func NewDataStore() *SimpleDataStore {
	return &SimpleDataStore{
		userData: map[string]string{
			"1": "Carlos Eduardo",
			"2": "Alexsandra",
			"3": "Jojo",
		},
	}
}

// creating interfaces that our business logic will depend on
type Logger interface {
	Log(message string)
}

type DataStore interface {
	UserNameForId(userId string) (string, bool)
}

// making our function meet the types
type LoggerAdapter func(message string)
func (lg LoggerAdapter) Log(message string) {
	lg(message)
}

type SimpleLogic struct {
	l Logger
	ds DataStore
}

func (s *SimpleLogic) SayHello(userId string) (string, error) {
	s.l.Log("In SayHello for " + userId)
	name, ok := s.ds.UserNameForId(userId)

	if !ok {
		return "", errors.New("Invalid userId")
	}
	return "Hello, " + name, nil
}

func (s *SimpleLogic) SayGoodbye(userId string) (string, error) {
	s.l.Log("In SayGoodbye for " + userId)
	name, ok := s.ds.UserNameForId(userId)

	if !ok {
		return "", errors.New("unknown user")
	}

	return "Goodbye, " + name, nil
}

func NewSimpleLogic(l Logger, ds DataStore) *SimpleLogic {
	return &SimpleLogic{
		l: l,
		ds: ds,
	}
}

// starting with the Controllers
type Logic interface {
	SayHello(userId string) (string, error)
}

type Controller struct {
	l Logger
	logic Logic
}

func (c *Controller) SayHello(w http.ResponseWriter, r *http.Request) {
	c.l.Log("In Say Hello Controller")
	userId := r.URL.Query().Get("user_id")
	message, err := c.logic.SayHello(userId)

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte(err.Error()))
		return
	}

	w.Write([]byte(message))
}

func NewController(l Logger, logic Logic) *Controller {
	return &Controller{
		l: l,
		logic: logic,
	}
}


func main() {
	l := LoggerAdapter(LogOutput)
	ds := NewDataStore()
	logic := NewSimpleLogic(l, ds)
	c := NewController(l, logic)

	http.HandleFunc("/hello", c.SayHello)
	http.ListenAndServe(":8080", nil)
}