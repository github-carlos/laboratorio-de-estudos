package main

import "fmt"

type Employee struct {
	ID   string
	Name string
}

func (e Employee) Description() string {
	return fmt.Sprintf("%s (%s)", e.ID, e.Name)
}

type Manager struct {
	Employee
}

func main() {
	carlos := &Manager{
		Employee: Employee{
			ID:   "1",
			Name: "Carlos",
		},
	}
	// We can call the employee property directly when using Embedd concept
	fmt.Println(carlos.Name)

	type Inner struct {
		X int
	}
	type Outer struct {
		Inner
		X int
	}
	// You can only access the X on Inner by specifying Inner explicitly:
	o := Outer{
		Inner: Inner{
			X: 10,
		},
		X: 20,
	}
	fmt.Println(o.X)       // prints 20
	fmt.Println(o.Inner.X) // prints 10
}
