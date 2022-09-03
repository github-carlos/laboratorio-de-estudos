package main

import "testing"

func TestHelloMessage(t *testing.T) {
	got := HelloMessage("Carlos")
	want := "Hello, Carlos"

	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}
