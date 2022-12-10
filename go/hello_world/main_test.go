package main

import "testing"

func TestHello(t *testing.T) {
	t.Run("saying hello to people", func(t *testing.T) {
		got := HelloMessage("Chris", "")
		want := "Hello, Chris"

		assertCorrectMessage(t, got, want)
	})
	t.Run("say 'Hello, World' when an empty string is supplied", func(t *testing.T) {
		got := HelloMessage("", "")
		want := "Hello, World"

		assertCorrectMessage(t, got, want)
	})

	t.Run("should return message in Spanish when language param is Spanish", func(t *testing.T) {
		got := HelloMessage("Carlos", "Spanish")
		want := "Hola, Carlos"
		assertCorrectMessage(t, got, want)
	})

	t.Run("should return message in French when language param is French", func(t *testing.T) {
		got := HelloMessage("Carlos", "French")
		want := "Bonjour, Carlos"
		assertCorrectMessage(t, got, want)
	})
}

func assertCorrectMessage(t testing.TB, got, want string) {
	t.Helper()
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}
