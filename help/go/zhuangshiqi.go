package main

import "fmt"

func user_logging(fun func()) func() func() {
    wrapper := func() func(){
        fmt.Println("this func is", fun)
        fmt.Println("the end of foo")
        return fun
    }
    return wrapper
}

func foo()  {
    println("i am foo")
}

func main() {
    foo := user_logging(foo)
    fmt.Println(foo())
}

//this func is 0x490840
//the end of foo
//0x490840
