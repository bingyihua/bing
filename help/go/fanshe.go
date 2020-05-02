package main
import (
    "fmt"
)
func dd() {
fmt.Println("ddddd")
}
func e (str string )(func()) {

 return str 
 }

func main() {
	e("dd")()
}
