package main

import(
	"fmt"
	"strings"
)
func  pre_12583 (num string) (str1 string){	         
	if strings.HasPrefix(num, "12583") {
    	str1=num[6:]
	}else{
	str1=num
	}
    return 
}
func  pre_17951 (num string) (str1 string){
    if strings.HasPrefix(num, "179")|| strings.HasPrefix(num, "12593") {
        str1=num[5:]
    }else{
	str1=num	
	}
    return
}
func  pre_0086 (num string) (str1 string){
    if strings.HasPrefix(num, "0086") || strings.HasPrefix(num, "0"){
		if strings.HasPrefix(num, "0086") {
		str1=num[4:]
		}else{
		str1=num[1:]
		}
    }else {
	str1=num
	}
    return
}
func vlt_prefix(num string)string{
	aa:=pre_12583(num)
	bb:=pre_17951(aa)
	cc:=pre_0086(bb)
	return cc
}
func Contain_SP_fixnum (num string)string{
	if strings.HasPrefix(num, "125"){
	   
	}     

}
func main() {
	aa:=vlt_prefix("12583012593045110086")
	fmt.Println(aa)	

}
