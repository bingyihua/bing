package main
import (
"strings"
	"bufio"
    "fmt"
    "io"
    "os"
	"strconv"
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

func dup (file_list  [] string,num int,str string) (dup_res [] string,dupnum map[string]int ,errlist []string){
	

	var dup_data [] string 
	dupMap := make(map[string]string)
	 dupnum = make(map[string]int)
	 //errlist []string
	 err:=make(map[string]int)
	 err["F010_0"]=14
	 err["F010_1"]=14
	 err["F040_0"]=8
	 err["F040_1"]=8
	 err["F050_0"]=17
	 err["F050_1"]=17
	 err["F060_0"]=18
	 err["F060_1"]=18
	 err["F070_0"]=19
	 err["F070_1"]=19
	 err["F071_0"]=19
	 err["F071_1"]=19
	 err["F072_0"]=19
	 err["F072_1"]=19
	err["F073_1"]=19
	err["F090_0"]=21
	err["F090_1"]=21
	err["F091_0"]=21
	err["F091_1"]=21
	err["F092_0"]=21
	err["F092_1"]=21
	err["F093_0"]=21
	err["F110_0"]=23
	err["F110_1"]=23
	err["F111_0"]=23
	err["F111_1"]=23
	err["F112_0"]=23
	err["F112_1"]=23
	err["F180_0"]=30
	err["F180_1"]=30
	err["F190_0"]=31
	err["F190_1"]=31
	err["F200_0"]=32
	err["F200_1"]=32
	err["F210_0"]=33
	err["F210_1"]=33
	err["F220_0"]=34
	err["F220_1"]=34
	err["F350_0"]=46
	err["F350_1"]=46
	err["F351_0"]=46
	err["F351_1"]=46
	err["F370_1"]=47
	err["F371_1"]=47           
	err["F380_1"]=49
	err["F390_1"]=50 
	err["F410_0"]=51
	err["F410_1"]=51
	err["F420_0"]=52
	err["F420_1"]=52
	err["F430_0"]=53
	err["F430_1"]=53
	err["F440_0"]=54
	err["F440_1"]=54
	err["F450_0"]=55
	err["F450_1"]=55
	err["F460_0"]=56
	err["F460_1"]=56
	err["F461_0"]=56
	err["F461_1"]=56
	err["F490_0"]=59
	err["F490_1"]=59
	row_num:=0
	for _, value := range file_list {
		row_num++
 	dup_data = append(dup_data,strings.SplitN(value, str, 70)[num-1])
	err_Cd:=strings.SplitN(value, str, 70)[num-1]
	CDR_TYPE:=strings.SplitN(value, str, 70)[8-1]
	line_key:=err_Cd+"_"+CDR_TYPE
	//fmt.Println(line_key)
	 if _, ok := err[line_key]; ok {
		 line:=err[line_key] 
			line_v:=strings.SplitN(value, str, 70)[line-1]
			errlist= append(errlist,err_Cd+"_"+CDR_TYPE+"_" +strconv.Itoa(row_num)+"_"+line_v)

									}
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
ss:=readline_list("201907_551_err.csv")
_,_,ww:=dup(ss,60,"|")
for _,value := range ww{
fmt.Println(value)
			 }

}


