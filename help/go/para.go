package main
import (
    "fmt"
)
func function(a, b int, sum func(int, int) int) {
    fmt.Println(sum(a, b))
}
func sum(a, b int) int {
    return a + b
}
func main() {
    var a, b int = 5, 6
    f := sum
    function(a, b, f)
}
