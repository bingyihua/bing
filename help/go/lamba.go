package main
import ("fmt")
func main(){
	substract := func(a, b int) int { return a - b }
	fmt.Print("--substraction function literals: ", substract(10, 2), "\n")
}


