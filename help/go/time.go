package main
 
import (
    "fmt"
	"strconv"
	"time"
)
 

func check_yyyy_hh_mm_ss (str string )(bool){
var a bool
yyyy,_:=strconv.Atoi(str[0:4])
mm,_:=strconv.Atoi(str[4:6])
dd,_:=strconv.Atoi(str[6:8])
hh,_:=strconv.Atoi(str[8:10])
ss,_:=strconv.Atoi(str[10:12])
		    if hh<12 && ss<60 && dd<32 && mm<13 && yyyy>1900 {
				a=true
			}else{
				a=false
			}
			return a
		}
func main() {

if check_yyyy_hh_mm_ss("10081123111133"){
fmt.Println("ok")
}else {
fmt.Println("not ok")

}
bb:=time.Now().Format("200601")
fmt.Println(bb+"ss")
}

