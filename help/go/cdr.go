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

func cdr_check_data (str,errcd string) (errdata string){
	 err:=make(map[string]string)
	 err["F010_0"]="14"
	 err["F010_1"]="14"
	 err["F040_0"]="8"
	 err["F040_1"]="8"
	 err["F050_0"]="17"
	 err["F050_1"]="17"
	 err["F060_0"]="18"
	 err["F060_1"]="18"
	 err["F070_0"]="19"
	 err["F070_1"]="19"
	 err["F071_0"]="19"
	 err["F071_1"]="19"
	 err["F072_0"]="19"
	 err["F072_1"]="19"
	err["F073_1"]="19"
	err["F090_0"]="21"
	err["F090_1"]="21"
	err["F091_0"]="21"
	err["F091_1"]="21"
	err["F092_0"]="21"
	err["F092_1"]="21"
	err["F093_0"]="21"
	err["F110_0"]="23"
	err["F110_1"]="23"
	err["F111_0"]="23"
	err["F111_1"]="23"
	err["F112_0"]="23"
	err["F112_1"]="23"
	err["F180_0"]="30"
	err["F180_1"]="30"
	err["F190_0"]="31"
	err["F190_1"]="31"
	err["F200_0"]="32"
	err["F200_1"]="32"
	err["F210_0"]="33"
	err["F210_1"]="33"
	err["F220_0"]="34"
	err["F220_1"]="34"
	err["F350_0"]="46"
	err["F350_1"]="46"
	err["F351_0"]="46"
	err["F351_1"]="46"
	err["F360_1"]="46" //没有解析这个字段只能在话单看，这个赋值为匹配这个错误类型
	err["F370_1"]="47|46"
	err["F371_1"]="47"           
	err["F380_1"]="49"
	err["F390_1"]="50" 
	err["F410_0"]="51|19"
	err["F410_1"]="51|21"
	err["F420_0"]="52"
	err["F420_1"]="52"
	err["F430_0"]="53"   
	err["F430_1"]="53"
	err["F440_0"]="54"
	err["F440_1"]="54"
	err["F450_0"]="55"
	err["F450_1"]="55"
	err["F460_0"]="56"
	err["F460_1"]="56|46"
	err["F461_0"]="56"
	err["F461_1"]="56"
	err["F490_0"]="59"
	err["F490_1"]="59"
	err_Cd:=errcd
	//这个是加rowkey 需要+1
	CDR_TYPE:=strings.SplitN(str, "|", 80)[9-1]
	line_key:=err_Cd+"_"+CDR_TYPE
	CALL_START_TM:=strings.SplitN(str, "|", 80)[23]
		//fmt.Println(line_key)
	if _, ok := err[line_key]; ok {
		line:=err[line_key]
			//	fmt.Println(line)
		if strings.HasPrefix(line, "|"){
			line1 :=strings.Split(line, "|")[0]
			int_line1,_:=strconv.Atoi(line1)
			//line_v1:=strings.SplitN(value, str, 80)[int_line1-1] 这个是没有加rowkey
			line_v1:=strings.SplitN(str, "|", 80)[int_line1]
			line2:=strings.Split(line, "|")[1]
			int_line2,_:=strconv.Atoi(line2)
			line_v2:=strings.SplitN(str, "|", 80)[int_line2]	
			line_v:=line_v1+"|"+line_v2
			errdata=err_Cd+"_"+CDR_TYPE+"_"+line_v+"_"+CALL_START_TM
		}else{
			int_line, _:= strconv.Atoi(line)
			line_v:=strings.SplitN(str, "|", 80)[int_line]
			errdata=err_Cd+"_"+CDR_TYPE+"_"+line_v+"_"+CALL_START_TM
			}
		}
	return 
}


func main() {
ss:=readline_list("201907_250_err.csv")
//61是errCd

for _,value := range ss{
	cc:=cdr_check_data(value,"F010")
	fmt.Println(cc)
	}

}


