package main

import (
	"errors"
	"net/http"
	"time"
)

type Queue struct {
	ch chan int
}

func New(max int) *Queue {
	ch := make(chan int, max)

	for i := 0; i < max; i++ {
		ch <- i
	}

	return &Queue{
		ch,
	}
}

func (q *Queue) Process(fn func()) error {
	select {
	case <-q.ch:
		fn()
		q.ch <- 1
		return nil
	default:
		return errors.New("Too Many Requests")
	}
}

func main() {
	queue := New(5)

	http.HandleFunc("/hello", func(res http.ResponseWriter, req *http.Request) {
		err := queue.Process(func() {
			time.Sleep(2 * time.Second)
			res.Write([]byte("Executed With Success"))
		})

		if err != nil {
			res.Write([]byte(err.Error()))
		}
	})

	http.ListenAndServe(":3000", nil)
}
