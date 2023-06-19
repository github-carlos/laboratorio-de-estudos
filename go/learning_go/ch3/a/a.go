package a

import (
	"fmt"
	"math/rand"
)

func TrySwitch() {
	fmt.Println("My Switch")
	years := []int{2020, 2021, 2022, 2023}
	fmt.Println(years)

	switch randomInt := rand.Int(); randomInt {
	case 2020, 2021:
		fmt.Println("is 2020 or 2021")
		break
	case 2022:
		fmt.Println("is 2022")
		break
	default:
		fmt.Println("random number", randomInt)
		fmt.Println("is 2023")
	}
}
