package main

import "fmt"

func main() {
	s := []string{"1", "2", "3", "4"}
	//aa := make(map[int]*string)
	var bb = make([]string, 0)
	var cc []string
	for _, v := range s {
		//		aa[key] = &s_value[key]
		bb = append(bb, v)
		cc = append(cc, v)
		//fmt.Println(&bb)
		s = append(s, v)
		//s := append(s, v)

	}
	fmt.Println(s)
	fmt.Println(bb)
	/*	for key, value := range aa {
		fmt.Println(key, "=>", *value)
	}*/
}
