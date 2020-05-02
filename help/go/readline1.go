package main
import (
"strings"
	"bufio"
    "fmt"
    "io"
    "os"
)


func readline_list  (file string ) ( file_list [] string){
    fi, err := os.Open(file)
    if err != nil {
        fmt.Printf("Error: %s\n", err)
       }
    defer fi.Close()
    br := bufio.NewReader(fi)
    for {
        line, _, c := br.ReadLine()
        if c == io.EOF {
            break
            }
         file_list = append(file_list,string(line))
        }
	return
	}

	func dup (file_list  [] string,num int,str string) (dup_res [] string,dupnum map[string]int ){

	var dup_data [] string 
	dupMap := make(map[string]string)
	 dupnum = make(map[string]int)
	for _, value := range file_list {
 	dup_data = append(dup_data,strings.SplitN(value, str, 70)[num-1])
	}
//	fmt.Println(dup_data)
	for _,v:= range dup_data{
		dupMap[v] = v
	}
	for _,value := range dupMap{
			dup_res = append(dup_res ,value)
	}
	for _,v:=range dup_res{
		i :=0
		for _,vv:= range dup_data {
		if v==vv {
			i=i+1
		}
	}
		dupnum[v]=i
	//	fmt.Println(dupnum)
	}
	return 
}

func main() {
ss:=readline_list("201907_250_err.csv")
ww,bb:=dup(ss,60,"|")
fmt.Println(ww,bb)
		     

}


