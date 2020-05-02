package main

import (
	"fmt"
)

func main() {
	const (
		//iota是一个计数器
		//const aa=12
		NUM1 = iota + 100
		NUM2 = iota
		NUM3 = iota + 10
		NUM4
		NUM5
	)
	fmt.Println(NUM1, NUM2, NUM3, NUM4, NUM5)
	//	NUM1 = 100
	aa := "werf"
	const aa = "qq"
}
