package main

import "fmt"

func adder() func(int) int {
    sum := 0
    return func(x int) int {
        sum += x
        return sum
    }
}

func main() {
    pos, neg := adder(), adder()
    for i := 0; i < 10; i++ {
        fmt.Println(
            pos(i),
            neg(-2*i),
        )
    }
var flist []func()
    for i := 0; i < 3; i++ {
        flist = append(flist, func() {
            fmt.Println(i)
        })
    }

    for _, f := range flist {
        f()
    }
}//define the function in other function is close_package


