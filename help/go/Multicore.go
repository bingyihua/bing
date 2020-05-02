package main
import (
        "fmt"
        "runtime"
        "time"
)
const COUNT int = 100
const SIZE int = 300
func main() {
        var num [SIZE]int
        for i := 0; i < COUNT; i++ {
                num[i] = i
        }
        fmt.Println()
        fmt.Printf("result=%d\n", calmul(num[0:]))
}
func calmul(num []int) int {
        t1 := time.Now()
        var MULTICORE int = runtime.NumCPU() //number of core
        runtime.GOMAXPROCS(MULTICORE) //running in multicore
        fmt.Printf("with %d core\n", MULTICORE)
        ch := make(chan int)
        for i := 0; i < MULTICORE; i++ {
                go calsome(i*COUNT/MULTICORE, (i+1)*COUNT/MULTICORE, num[0:], ch)
        } //divide into some parts
        result := 0
        for i := 0; i < MULTICORE; i++ {
                temp := <-ch
                fmt.Printf("multicore #%d result:%d\n", i, temp)
                result += temp
        } //read result of some part from channel,loop will stop after all is read
        t2 := time.Now()
        fmt.Printf("multicore total time:%d\n", t2.Sub(t1))
        return result
}
func calsome(from, to int, num []int, ch chan int) {
        someresult := 0
        for i := from; i < to; i++ {
                someresult += num[i]
        }
        ch <- someresult //put result in channel
}
