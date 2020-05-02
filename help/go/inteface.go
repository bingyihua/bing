package main
import (
    "fmt"
)
func main() {
    slice := make([]interface{}, 10)
    map1 := make(map[string]string)
    map2 := make(map[string]int)
    map2["TaskID"] = 1
    map1["Command"] = "ping"
    map3 := make(map[string]map[string]string)
    map3["mapvalue"] = map1
    slice[0] = map2
    slice[1] = map1
    slice[3] = map3
    fmt.Println(slice[0])
    fmt.Println(slice[1])
    fmt.Println(slice[3])
}
