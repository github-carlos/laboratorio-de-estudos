package main

import (
	"chapter3/a"
	"fmt"
)

func main() {

	var x [3]int
	fmt.Println("x", x)
	var array1 [3]int = [3]int{1, 2, 3}
	var array2 = [...]int{2, 2, 3}

	fmt.Println("First array", array1)
	fmt.Println("Second array", array2)

	fmt.Println("Acessing an array:", array1[0])
	fmt.Println("length of an array", len(array1))

	fmt.Println("looping through an array")

	for item := range array1 {
		fmt.Println("item", item)
	}

	// nao definir o tamanho cria um slice em vez de um array
	var slice1 = []int{1, 2, 3, 4, 5}
	fmt.Println("First slice", slice1)

	var slice2 = []int{7, 8}

	var slice3 = append(slice1, slice2...)
	fmt.Println("slice 3", slice3)
	println("Slice3 length", len(slice3))
	println("Slice3 capacity", cap(slice3))

	var emptySlice []int
	emptySlice = append(emptySlice, 10)
	fmt.Println("aa", emptySlice)

	// maps

	carlos := map[string]int{}
	carlos["idade"] = 26
	fmt.Println("Carlos", carlos)

	// map with default size
	idsCities := make(map[string]int, 10)
	fmt.Println(len(idsCities))

	defaultItems := map[string]int{"a": 1, "b": 2}
	fmt.Println(defaultItems)

	// The comma ok idiom

	m := map[string]int{
		"hello": 5,
		"world": 0,
	}

	fmt.Println(m)
	v, ok := m["hello"]
	fmt.Println(v, ok)

	v, ok = m["invalid"]

	fmt.Println(v, ok)

	// deleting
	delete(m, "hello")
	fmt.Println(m)

	a.TrySwitch()

}
