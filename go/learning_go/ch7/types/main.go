package main

func main() {
	type Score int

	type Converter func(string) Score
	type TeamScores map[string]Score

}
