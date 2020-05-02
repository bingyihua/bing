package main
import  "fmt"

func Test( i int ) (func() int)  {
	a:=i*i
	return func() int {
		return a+a
	}
}

func main() {
	a:=Test(5)()
	fmt.Println(a)
}
