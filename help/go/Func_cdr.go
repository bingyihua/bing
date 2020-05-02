package main
import ("fmt"
 		"strconv"
		"strings"
		"io"
    	"os"
		"regexp"
		"bufio"
	 )

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
    err["F370_1"]="47^46"
    err["F371_1"]="47"
    err["F380_1"]="49"
    err["F390_1"]="50"
    err["F410_0"]="51^19"
    err["F410_1"]="51^21"
    err["F420_0"]="52"
    err["F420_1"]="52"
    err["F430_0"]="53"
    err["F430_1"]="53"
    err["F440_0"]="54"
    err["F440_1"]="54"
    err["F450_0"]="55"
    err["F450_1"]="55"
    err["F460_0"]="56"
    err["F460_1"]="56^46"
    err["F461_0"]="56^46"
    err["F461_1"]="56^46"
    err["F490_0"]="59"
    err["F490_1"]="59"
    //这个是加rowkey 需要+1
    CDR_TYPE:=strings.Split(str, "|")[9-1]
	err_Cd:=errcd
    line_key:=err_Cd+"_"+CDR_TYPE
    CALL_START_TM:=strings.Split(str, "|")[23]
	//fmt.Println(err[line_key])
    line:=err[line_key]
	if line=="" {
		errdata=err_Cd+"|"+CDR_TYPE+"|"+"^"+"|"+CALL_START_TM
		goto null
	}
	if strings.Contains(line, "^"){
    	line1 :=strings.Split(line, "^")[0]
        int_line1,_:=strconv.Atoi(line1)
        //line_v1:=strings.SplitN(value, str, 80)[int_line1-1] 这个是没有加rowkey
        line_v1:=strings.Split(str, "|")[int_line1]
        line2:=strings.Split(line, "^")[1]
        int_line2,_:=strconv.Atoi(line2)
        line_v2:=strings.Split(str, "|")[int_line2]
        line_v:=line_v1+"^"+line_v2
        errdata=err_Cd+"|"+CDR_TYPE+"|"+line_v+"|"+CALL_START_TM
    }else{
        int_line, _:= strconv.Atoi(line)
        line_v:=strings.Split(str, "|")[int_line]
        errdata=err_Cd+"|"+CDR_TYPE+"|"+line_v+"|"+CALL_START_TM
        }
		null:

    return
}

func count_err(errdata  []string)(dupnum  map[string]int){
	
	dupMap := make(map[string]string)
	dupnum = make(map[string]int)
	errlist:=make([]string,len(errdata))
	//var dupnum map[string]int
	//num:=len(errdata)
	//var errlist [10000]string
	//var dup_res []string

	for i,v:= range errdata{
		err_cd:=strings.Split(v, "|")[60]
		errlist[i]=err_cd
		dupMap[err_cd] = err_cd
	}
	//  fmt.Println(dupMap)
	for _,v:=range dupMap{
		j :=0
		for _,vv:= range errlist {
			if v==vv {
				j=j+1
			}
		}
		
		dupnum[v]=j

	fmt.Println("统计"+v+"有错单数："+strconv.Itoa(j)+"条")
	}	
	return
}


func IsNum(s string) bool {
	_, err := strconv.ParseFloat(s, 64) 
	return err == nil 
}
//////////////////////////////////////////////////
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
    if strings.HasPrefix(num, "0086") || strings.HasPrefix(num, "86")||strings.HasPrefix(num, "0"){
        if strings.HasPrefix(num, "0086") {
        str1=num[4:]
        }else if  strings.HasPrefix(num, "86"){
        str1=num[2:]
        }else if strings.HasPrefix(num, "0"){
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

func var_list (str string)(err_cd,call_type,err_key ,call_start_tm string){
	err_cd    =strings.Split(str, "|")[0]
	call_type =strings.Split(str, "|")[1]
	err_key   =strings.Split(str, "|")[2]
	call_start_tm   =strings.Split(str, "|")[3]
	return
}

func F010(str string)(result string) {
	err_cd,call_type,err_key,_ :=var_list (str)
	//	call_type,_:=strconv.Atoi(call_type)
	if call_type=="0"  && err_key=="69" {
	result=err_cd+"_ok"
	}else if call_type=="1"  && err_key=="69" {
	result=err_cd+"_ok"
	}else{
	result=err_cd+"_false" 
	}
	return
}

func F040(str string)(result string) {
	err_cd,call_type,_,_ :=var_list (str)	
	if  call_type=="0" {
    	result=err_cd+"_ok"
	}else if call_type=="1" {
    	result=err_cd+"_ok"
    }else{
		result=err_cd+"_false"
	}
	return
}

func F050(str string) (result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    if  call_type=="0" && err_key !="" {
    	result=err_cd+"_ok"
    }else if call_type=="1" && err_key !=""{
    	result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
    }
	return
}

func F060(str string) (result string) {
    err_cd,call_type,err_key,_ :=var_list (str)
    if  call_type=="0" && err_key !="" {
    	result=err_cd+"_ok"
    }else if call_type=="1" && err_key !=""{
    	result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
    }
	return
} 


func F070(str string) (result string)  {
    err_cd,call_type,err_key,_ :=var_list (str)
    if  call_type=="0" && len(err_key)==11 && IsNum(err_key) {
    	result=err_cd+"_ok"
    }else if call_type=="1" && len(err_key)>0 && IsNum(err_key) {
    	result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
    }
	return
}

func F071(str string,IMSI,UNICOM,PREFIX,AREA_CD map[string]string) (result string){
	err_cd,call_type,err_key ,call_start_tm:=var_list (str)
	mobile_num:=vlt_prefix(err_key)
	if len(mobile_num)>7{
		myres:=check_mobile(mobile_num,call_start_tm, IMSI,UNICOM,PREFIX,AREA_CD)
		if call_type=="0" && (strings.HasPrefix( mobile_num, "170")|| strings.Contains(myres,"0")) {
        	result=err_cd+"_false"
    	}else if (call_type=="1" && strings.Contains(myres,"0")) ||(call_type=="0" && myres=="1_yidong") {
        	result=err_cd+"_ok"
    	}else{
        	result=err_cd+"_false"
    	}
	}else{
		result=err_cd+"_false"
	}
	return
}

func F073(str string ,sp map[string]string )(result string){
    err_cd,call_type,err_key ,call_start_tm:=var_list (str)
    mobile_num:=vlt_prefix(err_key)
    myres:=check_sp(mobile_num,call_start_tm,sp)
    if call_type=="1" &&  myres=="0"{
        result=err_cd+"_false"	
    }else if call_type=="1" &&  myres=="1"{
        result=err_cd+"_ok"
	}else{
		result=err_cd+"主叫_undefine"
	}
    return
}

func F090(str string)(result string) {
    err_cd,call_type,err_key,_ :=var_list (str)
    if  call_type=="1" && len(err_key)==11 &&  IsNum(err_key) {
    	result=err_cd+"_ok"
    }else if call_type=="0" && len(err_key)>0 && IsNum(err_key) {
    	result=err_cd+"_ok"
    }else{
		result=err_cd+"_false"
    }
	return
}

func F091(str string, IMSI,UNICOM,PREFIX,AREA_CD map[string]string)(result string){
    err_cd,call_type,err_key ,call_start_tm:=var_list (str)
    mobile_num:=vlt_prefix(err_key)
	
	if len(mobile_num)>7{
		myres:=check_mobile(mobile_num,call_start_tm, IMSI,UNICOM,PREFIX,AREA_CD)
    	if call_type=="0" && strings.Contains(myres,"0"){
        	result=err_cd+"_false"
    	}else if call_type=="1" && ( strings.HasPrefix(mobile_num, "170") || strings.Contains(myres,"0")){
        	result=err_cd+"_false"
    	}else{
        	if call_type=="0"{
            	result=err_cd+"_checkless"
    	    }else{
            result=err_cd+"_ok"
        	}
		}
	}else {
		result=err_cd+"_false"	
	
	}
	return
}
func F093(str string,IMSI,UNICOM,PREFIX,AREA_CD map[string]string)(result string){
    err_cd,call_type,err_key ,call_start_tm:=var_list (str)
    mobile_num:=vlt_prefix(err_key)
    myres:=check_mobile(mobile_num,call_start_tm, IMSI,UNICOM,PREFIX,AREA_CD)
    if call_type=="0" &&  myres=="1_yidong" || ( myres=="0"  && strings.HasPrefix(mobile_num, "130")){
        result=err_cd+"_ok"
    }else if call_type=="1" {
        result=err_cd+"被叫_undefine"
    }else{
        result=err_cd+"_false"
    }
    return
}

func F110(str string)(result string){
	err_cd,call_type,_ ,call_start_tm:=var_list (str)
	check_start_tm:=func (str string )(bool){
		var a bool
		yyyy,_:=strconv.Atoi(str[0:4])
		mm,_:=strconv.Atoi(str[4:6])
		dd,_:=strconv.Atoi(str[6:8])
		hh,_:=strconv.Atoi(str[8:10])
		ss,_:=strconv.Atoi(str[10:12])
    	if hh<13 && ss<60 && dd<32 && mm<13 && yyyy>1900 {
    		a=true
    	}else{
    		a=false
    	}
    	return a
 	}	
	if call_type=="0" && check_start_tm(call_start_tm)==false{
		result=err_cd+"_false"
	}else if call_type=="1" && check_start_tm(call_start_tm)==false{
		result=err_cd+"_false"
	}else{
		result=err_cd+"_ok"
	}
	return
}
 
func F180(str string)(result string){
	err_cd,call_type,err_key,_ :=var_list (str)
	value,_:=strconv.Atoi(err_key)
	if call_type=="0" && IsNum(err_key) && value >1{
		result=err_cd+"_ok"
	}else if  call_type=="1" && IsNum(err_key) && value >1{
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}	
func F190(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    value,_:=strconv.Atoi(err_key)
    if call_type=="0" && IsNum(err_key) && value >=1 && len(err_key)>0{
        result=err_cd+"_ok"
    }else if  call_type=="0" && value ==0 && len(err_key)==0{
        result=err_cd+"_ok"
    }else if call_type=="1" && IsNum(err_key) && value >=1 && len(err_key)>0{
        result=err_cd+"_ok"
    }else if  call_type=="1"  && value ==0 && len(err_key)==0{
	 	result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}           

func F200(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    value,_:=strconv.Atoi(err_key)
    if call_type=="0" && IsNum(err_key) && len(err_key)>0 && (value==1||value==0||value==2||value==3||value==4||value==5||value==6) {
        result=err_cd+"_ok"
    }else if  call_type=="1" && IsNum(err_key) && len(err_key)>0 && (value==1||value==0||value==2||value==3||value==4||value==5||value==6){
        result=err_cd+"_ok"
    }else{
        result=err_cd+"_false"
    }
	return
}

func F210(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    if call_type=="0" &&  len(err_key)>0 {
        result=err_cd+"_ok"
    }else if  call_type=="1"  &&  len(err_key)>0 {
        result=err_cd+"_ok"
    }else{
        result=err_cd+"_false"
    }
	return
}

func F220(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
	value,_:=strconv.Atoi(err_key)
    if call_type=="0" &&  IsNum(err_key) && len(err_key)>0 &&(value==1||value==0) {
        result=err_cd+"_ok"
    }else if  call_type=="1"  && IsNum(err_key) && len(err_key)>0 &&(value==1||value==0) {
        result=err_cd+"_ok"
    }else{
        result=err_cd+"_false"
    } 
	return
}          
func F351(str string,AREA_CD map[string]string)(result string){
	err_cd,call_type,err_key,call_start_tm :=var_list (str)
	is_str_dom:=func ()(match bool,res string){
		str_dom:=regexp.MustCompile(`sbc-domain=.[^;]+`).FindString(err_key)
		if len(str_dom)>0 &&  strings.Contains(err_key,"sbc-dom"){
			Area_code:=strings.Split(str_dom, ".")[1] 
			//match, _ = regexp.MatchString(`\d{3,4}`,Area_code)  不准确弃用
			match=IsNum(Area_code)
			if match{
				res =check_area(Area_code,call_start_tm,AREA_CD)
			} else {
				res="0"
			}
		}else{
			res="0"
			match=false
		}
		return 
	}
	match,res:=is_str_dom()	
	if call_type=="0" && match && res!="0" || strings.Contains(err_key,"CS") {
		result=err_cd+"_ok"
	}else if call_type=="1" && match  && res!="0"|| strings.Contains(err_key,"CS"){
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}

func F350(str string)(result string){
	err_cd,call_type,err_key,_ :=var_list (str)
    if call_type=="0" && (strings.Contains(err_key,"sbc-dom")||strings.HasPrefix(err_key, "CS")||strings.HasPrefix(err_key, "cs")){
        result=err_cd+"_ok"
    }else if call_type=="1" && (strings.Contains(err_key,"sbc-dom") ||strings.HasPrefix(err_key, "CS")||strings.HasPrefix(err_key, "cs")){
        result=err_cd+"_ok"
    }else{
        result=err_cd+"_false"
	}
	return
}

func F360(str string)(result string){
	err_cd,call_type,_,_ :=var_list (str)
	if  call_type=="0" {
		result=err_cd+"_Undefine"
	}else {
		result=err_cd+"_open_dat"
	}
	return
}
         
func F370(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    Access:=strings.Split(err_key, "^")[0]
	fmt.Println(err_key)
    MscNumber:=strings.Split(err_key, "^")[1]
	iscs:=strings.HasPrefix(Access, "CS")
	notcs:=!(iscs)
    if call_type=="0" {
        result=err_cd+"主叫_Undefine"
	}else if call_type=="1" && iscs && len(MscNumber)>0{
		result=err_cd+"_ok"
	}else if call_type=="1" && notcs{
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}                      

func F371(str string,AREA_CD,swich map[string]string)(result string){
    err_cd,call_type,err_key,call_start_tm :=var_list (str)
	MscNumber:=err_key
	MscNum:=pre_0086(MscNumber)
	res :=check_switch(MscNum,call_start_tm, swich,AREA_CD)
	//fmt.Println(MscNum,res,MSC)
    if call_type=="0"  {
        result=err_cd+"主叫_Undefine"
    }else if call_type=="1"   && res=="1_switch"{
        result=err_cd+"_ok"
    }else{
        result=err_cd+"_false"
    }
	return
}

func F380(str string)(result string){
	err_cd,call_type,err_key,_ :=var_list (str)
	if call_type=="0"{
		result=err_cd+"主叫_Undefine"
	}else if call_type=="1"   && ( len(err_key)==0 || (len(err_key)>0 && IsNum(err_key) )){
	 	result=err_cd+"_ok"
	}else{
	 	result=err_cd+"_false"
	}
	return
}

func F390(str string)(result string){
    err_cd,call_type,err_key,_ :=var_list (str)
    if call_type=="0"{
        result=err_cd+"主叫_Undefine"
    }else if call_type=="1"   && ( len(err_key)==0 || (len(err_key)>0 && IsNum(err_key) )){
     	result=err_cd+"_ok"
    }else{
     	result=err_cd+"_false"
    }
	return
}

func F410(str string)(result string){
	err_cd,call_type,err_key,_ :=var_list (str)
	mobilenum:=strings.Split(err_key, "^")[0]
	changenum:=strings.Split(err_key, "^")[1]
	if (call_type=="0"||call_type=="1") && changenum==mobilenum && len(mobilenum)>0 {
		result=err_cd+"_ok"
    }else{
		result=err_cd+"_false"
	}
	return
}
func F420(str string)(result string){
	err_cd,_,err_key,_ :=var_list (str)
	if err_key=="0"||err_key=="1"{
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}
func F430(str string)(result string){
	err_cd,_,err_key,_ :=var_list (str)
	duan,_:=strconv.Atoi(err_key)
	if duan>=0 &&  IsNum(err_key){
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}

func F440(str string)(result string){
    err_cd,_,err_key,_ :=var_list (str)
    if err_key==""||err_key=="101"||err_key=="103"||err_key=="105"||err_key=="109"||err_key=="115"||err_key=="118"||err_key=="121"||err_key=="122"||err_key=="123"||err_key=="125"||err_key=="136"||err_key=="137"||err_key=="138" {
    	result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
    }
	return
}
func F450(str string)(result string){
	
	result="F450_ok"
	return
}
func F460(str string)(result string){
	err_cd,_,err_key,_ :=var_list (str)
	if err_key=="cs"||err_key=="LTE"{
		result=err_cd+"_ok"
	}else{
		result=err_cd+"_false"
	}
	return
}
func F461(str string)(result string){
    err_cd,_,err_key,_ :=var_list (str)
	TAD:=strings.Split(err_key, "^")[0]
	access:=strings.Split(err_key, "^")[1]
	iscs:=strings.Contains(access,"CS")
	notcs:=!(iscs)
    if iscs && TAD==access && strings.Contains(access,"0"){
    	result=err_cd+"_ok"
	}else if notcs && TAD==access && strings.Contains(access,"1"){
		result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
	}
	return
}

func F490(str string)(result string){
    err_cd,_,err_key,_ :=var_list (str)
	vpmn1:=strings.Contains(err_key,"10000000")
	vpmn2:=strings.Contains(err_key,"21000000")
    if err_key==""||vpmn1||vpmn2{
    	result=err_cd+"_ok"
    }else{
    	result=err_cd+"_false"
    }
	return
}	

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


func savelist_file(str_content string,name string)  {
	fd,_:=os.OpenFile(name,os.O_RDWR|os.O_CREATE|os.O_APPEND,0644)
	fd_content:=strings.Join([]string{str_content},"")
	buf:=[]byte(fd_content)
	fd.Write(buf)
	fd.Close()
}
func fun_main(str ,err string,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp map[string]string)(res string){
	//var slice []string
	err_cd:=err
	switch err_cd {
	case "F010":
    	res=F010(str)
	case "F040":
    	res=F040(str)
	case "F050":
        res=F050(str)
	case "F060":
        res=F060(str)
    case "F070":
        res=F070(str)
    case "F071":
        res=F071(str,IMSI,UNICOM,PREFIX,AREA_CD)
//	case "F072":
  //      res=F072(str,sp)
    case "F073":
        res=F073(str,sp)
    case "F090":
        res=F090(str)
	case "F091":
        res=F091(str,IMSI,UNICOM,PREFIX,AREA_CD)
  //  case "F092":
    //    res=F092(str)
    case "F093":
        res=F093(str,IMSI,UNICOM,PREFIX,AREA_CD)
	case "F110":
        res=F110(str)
    case "F80":
        res=F180(str)
    case "F190":
        res=F190(str)
	case "F200":
        res=F200(str)
	case "F210":
        res=F210(str)
	case "F220":
        res=F220(str)
	case "F350":
        res=F350(str)
	case "F351":
        res=F351(str,AREA_CD)
	case "F360":
        res=F360(str)
	case "F370":
        res=F370(str)
	case "F371":
        res=F371(str,swich,AREA_CD)
	case "F380":
        res=F380(str)
	case "F390":
        res=F390(str)
	case "F410":
        res=F410(str)
	case "F420":
        res=F420(str)
	case "F430":
        res=F430(str)
	case "F440":
        res=F440(str)
	case "F450":
        res=F450(str)
	case "F460":
        res=F460(str)
	case "F461":
        res=F461(str)
	case "F490":
        res=F490(str)
	default:
    	fmt.Println(0)
	}
	return 
}
func check_err(file_list [] string,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp map[string]string){
	rownum:=0
	/*rm file
	_, error := os.Stat(err)
	if error == nil {
		os.Remove(err)
	}*/

	for _,str :=range  file_list{	
		rownum++
		CDR_CD:=strings.Split(str, "|")[60]
		err_cd_str:=cdr_check_data (str,CDR_CD)
		err_Cd:=strings.Split(str, "|")[60]
		//savelist_file(err_cd_str+"\n",err)
		//fmt.Println(err_Cd)
		result:=fun_main(err_cd_str,err_Cd,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp )
		if strings.Contains(result,"ok"){
			num:=strconv.Itoa(rownum)
			fmt.Println(num+"行"+"【"+result+"】"+"对应列内容："+err_cd_str)
    	}else{
    		//num:=strconv.Itoa(rownum)
			//fmt.Println(num+"行"+"【"+result+"】"+"对应列内容："+err_cd_str)

   	 	}
	}
	//fmt.Println(file_list)
	count_err(file_list)
}

func check_cdr(file_list [] string,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp map[string]string){
	funcs := []string{"F010","F040","F050","F060","F070","F071","F073","F090","F091","F110" ,"F180","F190","F200","F210","F220","F350","F351","F360","F371","F380","F390","F420","F430","F440","F450","F460","F490"}
	
	rownum:=0
	slice:=make([]string,len(funcs))
	for _,str :=range  file_list{
		rownum++
		i:=0
		for _,errcd := range funcs {
			i++	
			err_cd_str:=cdr_check_data (str,errcd)
			slice[i-1] =fun_main(err_cd_str, errcd,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp)
		}
		checkstr:=strings.Join(slice[:],"|")
		if strings.Contains(checkstr,"false"){
			fmt.Println(strconv.Itoa(rownum)+"="+checkstr)
		}else{
		//	fmt.Println("test ok")
		}
	}
}


func main() {
	//const IMSI,UNICOM,PREFIX,AREA_CD,swch,sp map[string]string
	IMSI,UNICOM,PREFIX,AREA_CD,swich,sp :=sava_map()
	//check_mobile("1353759","20190411121112", IMSI,UNICOM,PREFIX,AREA_CD)
	//check_sp("125880","20190411121112", sp)
	strlist:=readline_list("201908_100_cdr.csv1")
	//check_err(strlist,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp)
	check_cdr(strlist,IMSI,UNICOM,PREFIX,AREA_CD,swich,sp)
    

}
