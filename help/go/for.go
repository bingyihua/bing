package main

import "fmt"
import "strings"
func main() {
	 a :=[]string{"1", "2", "3 4"}
	b:=strings.Join(a,"|")
	 fmt.Println(b)
}
