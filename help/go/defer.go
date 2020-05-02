package main

import "log"
import "time"
import "fmt"
func foo(n int) int {
    defer log.Println("1111")
    time.Sleep(1 * time.Second)
    defer log.Println("2222")
    time.Sleep(1 * time.Second)
    defer log.Println("3333")
    time.Sleep(1 * time.Second)
    return n
}

func main() {
    var i int = 100
	fmt.Println("heheheh")
	 defer fmt.Println("1111")
    foo(i)
}
