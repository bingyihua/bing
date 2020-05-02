package main

import "fmt"

type Person struct {  
    firstName string
    lastName  string
}

func changeName(p Person) {  
    p.firstName = "Bob"
	fmt.Println(p)
}

func main() {  
   var p Person = Person {
        firstName: "Alice",
        lastName: "Dow",
    }
    changeName(p)
	fmt.Println(p)
	p.firstName = "Bobb"
    fmt.Println(p)
}

