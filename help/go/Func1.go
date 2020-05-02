package main

import "fmt"
import "reflect"

func F010(str string) {
	fmt.Println("hello_f010"+str )
		}

func fun_main(str string){
	b:=str[0:4]
	funcs := map[string]func(string){"F010":F010}
	 fv := reflect.ValueOf( funcs[b])
     args := []reflect.Value{reflect.ValueOf(str)}
	     fv.Call(args)
}
func main() {
fun_main("F010_0_111")
}
