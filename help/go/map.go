package main

import "fmt"

func main() {
	//使用make申请一个map，键为string类型，值为int类型
	m := make(map[string]int)
	//设置值

	m["k1"] = 7

	m["k2"] = 13
	fmt.Println(m)
	//
}
