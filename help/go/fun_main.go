package main

import "fmt"
import "reflect"

func F010(str string){
fmt.Println(str)
}
func main() {
	str:="hahahahah"
	 funcs := map[string]func(string){"F010":F010}
	fv := reflect.ValueOf( funcs)
	args := []reflect.Value{reflect.ValueOf(str)}
	fv.Call(args)
	for i,_ := range funcs{
		   
			    fmt.Println(i)
				    }
}
