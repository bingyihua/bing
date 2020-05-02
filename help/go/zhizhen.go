package main
 
import (
	"fmt"
)
 
type foo struct {
	a int
}
func update1(f foo){
	f.a=2
}
func update2(f *foo) *foo{
	f.a=2
	var otherf foo
	otherf.a=3
	f=&otherf
	return &otherf
}
func swap(a int, b int) {
    var temp int
    temp = a
    a = b
    b = temp
}
func swap1(a *int, b *int) {
    var temp int
    temp = *a
    *a = *b
    *b = temp
}
func function(a int) {
    a += 100
}
func sum(a, b int) int {
    return a + b
}
func main() {
	var f foo
	f.a=1
	update1(f)
	fmt.Println(f.a)
	otherf := update2(&f)
	fmt.Println(f.a)
	fmt.Println(otherf.a)
	x := 5
    y := 10
    swap(x, y)
    fmt.Println(x, y)
	m := 5
    n := 10
    swap1(&m, &n)
    fmt.Println(m, n)
	var s = [5]int{1, 2, 3, 4, 5}
    function(s[2])
    fmt.Println(s[2])
}
