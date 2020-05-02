package main

import "fmt"
func main() {
    l := make([]int64, 0)
    l = append(l, 10)
    l1 := l
    l1 = append(l1, 20)
    fmt.Println(l, l1) //[10] [10 20]
    m := make(map[string]interface{})
    m["hello"] = 1
	w:= make(map[string]interface{})
	w:=copy(w,m)
    n := m
    n["hello"] = 2
    fmt.Println(n,m,w) //map[hello:2] map[hello:2]
}
