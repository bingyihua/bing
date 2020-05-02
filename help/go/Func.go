package main
import ( "fmt"
		 "reflect"
 		 "strconv"
		 "strings"
		 "regexp"
	 )


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

func var_list (str string)(err_cd,call_type,row_num,err_key ,call_start_tm string){
	err_cd    =strings.SplitN(str, "_", 5)[0]
	call_type =strings.SplitN(str, "_", 5)[1]
	row_num   =strings.SplitN(str, "_", 5)[2]
	err_key   =strings.SplitN(str, "_", 5)[3]
	call_start_tm   =strings.SplitN(str, "_", 5)[4]
	return
}

func F010(str string) {
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	//	call_type,_:=strconv.Atoi(call_type)
	if call_type=="0"  && err_key=="69" {
	fmt.Println(err_cd+"_"+row_num+"_is ok!" )
	}else if call_type=="1"  && err_key=="69" {
	fmt.Println( err_cd+"_"+row_num+"_is ok!")
	}else{
	fmt.Println(err_cd+"_"+row_num+"_is false!" )
	}
}

func F040(str string) {
	err_cd,call_type,row_num,_,_ :=var_list (str)	
	if  call_type=="0" {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
	}else if call_type=="1" {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+"_"+row_num+"_is false!"  )
	}
}

func F050(str string) {
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if  call_type=="0" && err_key !="" {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else if call_type=="1" && err_key !=""{
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+"_"+row_num+"_is false!"  )
    }
}

func F060(str string) {
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if  call_type=="0" && err_key !="" {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else if call_type=="1" && err_key !=""{
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+"_"+row_num+"_is false!"  )
    }
} 


func F070(str string) {
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if  call_type=="0" && len(err_key)==11 && IsNum(err_key) {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else if call_type=="1" && len(err_key)>0 && IsNum(err_key) {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+"_"+row_num+"_is false!"  )
    }
}

func F071(str string){
	err_cd,call_type,row_num,err_key ,call_start_tm:=var_list (str)
	mobile_num:=vlt_prefix(err_key)
	myres,_:=mysql(mobile_num[0:7],call_start_tm)
	if call_type=="0" && (strings.HasPrefix( mobile_num, "170")|| myres=="0") {
		fmt.Println(err_cd+"_"+row_num+"_is err!")
	}else if call_type=="1" && myres=="0" {
		fmt.Println(err_cd+call_type+"_"+row_num+"_is err!")
	}else{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}
}

func F073(str string){
    err_cd,call_type,row_num,err_key ,call_start_tm:=var_list (str)
    mobile_num:=vlt_prefix(err_key)
    _,myres:=mysql(mobile_num,call_start_tm)

    if call_type=="1" &&  myres!="sp"{
        fmt.Println(err_cd+"_"+row_num+"_is err!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}
    
}

func F090(str string) {
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if  call_type=="1" && len(err_key)==11 &&  IsNum(err_key) {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else if call_type=="0" && len(err_key)>0 && IsNum(err_key) {
    fmt.Println(err_cd+"_"+row_num+"_is ok!")
    }else{
		fmt.Println(err_cd+"_"+row_num+"_is false!"  )
    }
}

func F091(str string){
    err_cd,call_type,row_num,err_key ,call_start_tm:=var_list (str)
    mobile_num:=vlt_prefix(err_key)
    myres,_:=mysql(mobile_num[0:7],call_start_tm)
    if call_type=="0" || myres=="0"{
        fmt.Println(err_cd+"_"+row_num+"_is err!")
    }else if call_type=="1" && ( strings.HasPrefix(mobile_num, "170") || myres=="0"){
        fmt.Println(err_cd+call_type+"_"+row_num+"_is err!")
    }else{
		if call_type=="0"{
			fmt.Println(err_cd+"_"+row_num+"主叫只是做了号码有效性校验通过!，需进一步核实")
		}else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
		}
    }
}

func F110(str string){
err_cd,call_type,row_num,_ ,call_start_tm:=var_list (str)
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
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}else if call_type=="1" && check_start_tm(call_start_tm)==false{
		fmt.Println(check_start_tm(call_start_tm))
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}else{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}
}
 
func F180(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	 value,_:=strconv.Atoi(err_key)
	 if call_type=="0" && IsNum(err_key) && value >1{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else if  call_type=="1" && IsNum(err_key) && value >1{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}	
func F190(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
     value,_:=strconv.Atoi(err_key)
     if call_type=="0" && IsNum(err_key) && value >=1 && len(err_key)>0{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if  call_type=="0" && value ==0 && len(err_key)==0{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if call_type=="1" && IsNum(err_key) && value >=1 && len(err_key)>0{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if  call_type=="1"  && value ==0 && len(err_key)==0{
	 	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}           

func F200(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
     value,_:=strconv.Atoi(err_key)
     if call_type=="0" && IsNum(err_key) && len(err_key)>0 && (value==1||value==0||value==2||value==3||value==4||value==5||value==6) {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if  call_type=="1" && IsNum(err_key) && len(err_key)>0 && (value==1||value==0||value==2||value==3||value==4||value==5||value==6){
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F210(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
     if call_type=="0" &&  len(err_key)>0 {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if  call_type=="1"  &&  len(err_key)>0 {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F220(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
	value,_:=strconv.Atoi(err_key)
     if call_type=="0" &&  IsNum(err_key) && len(err_key)>0 &&(value==1||value==0) {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if  call_type=="1"  && IsNum(err_key) && len(err_key)>0 &&(value==1||value==0) {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    } 
}          
func F351(str string){
	err_cd,call_type,row_num,err_key,call_start_tm :=var_list (str)
	is_str_dom:=func ()(match bool,res string){
		str_dom:=regexp.MustCompile(`sbc-dom=.[^;]+`).FindString(err_key)
		if len(str_dom)>0 && strings.Contains(err_key,"sbc-dom"){
			Area_code:=strings.Split(str_dom, ".")[1] 
		//match, _ = regexp.MatchString(`\d{3,4}`,Area_code)  不准确弃用

			match=IsNum(Area_code)
			if match{
			res,_ =mysql(Area_code,call_start_tm)
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
	fmt.Println(match,res)
	if call_type=="0" && match && res!="0"  {
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")	
	}else if call_type=="1" && match  && res!="0"{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}

func F350(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if call_type=="0" && (strings.Contains(err_key,"sbc-dom")||strings.HasPrefix(err_key, "CS")||strings.HasPrefix(err_key, "cs")){
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else if call_type=="1" && (strings.Contains(err_key,"sbc-dom") ||strings.HasPrefix(err_key, "CS")||strings.HasPrefix(err_key, "cs")){
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F360(str string){
	 err_cd,call_type,row_num,_,_ :=var_list (str)
	if  call_type=="0" {
	fmt.Println(err_cd+call_type+"_"+row_num+"_is not define!")
	}else {
	fmt.Println(err_cd+call_type+"_"+row_num+"_is need open dat to look")
	}
}
         
func F370(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
     Access:=strings.Split(err_key, "|")[0]
     MscNumber:=strings.Split(err_key, "|")[1]
	iscs:=strings.HasPrefix(Access, "CS")
	notcs:=!(iscs)
	fmt.Println(iscs,notcs,err_cd,call_type,row_num,err_key)
    if call_type=="0" {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is not defined!")
	}else if call_type=="1" &&   iscs && len(MscNumber)>0{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is oki!")
	}else if call_type=="1" &&   notcs{dd
		fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}                      

func F371(str string){
    err_cd,call_type,row_num,err_key,call_start_tm :=var_list (str)
	 MscNumber:=strings.Split(err_key, "|")[1]
	 MscNum:=pre_0086(MscNumber)
	 res,MSC :=mysql(MscNum,call_start_tm)
 
    if call_type=="0"  {
        fmt.Println(err_cd+call_type+"_"+row_num+"_is not defined!")
    }else if call_type=="1"   && res!="0" && MSC=="swich_code"{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F380(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	if call_type=="0"{
		fmt.Println(err_cd+call_type+"_"+row_num+"_is not defined!")
	}else if call_type=="1"   && ( len(err_key)==0 || (len(err_key)>0 && IsNum(err_key) )){
	 fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
	 fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}
func F390(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if call_type=="0"{
        fmt.Println(err_cd+call_type+"_"+row_num+"_is not defined!")
    }else if call_type=="1"   && ( len(err_key)==0 || (len(err_key)>0 && IsNum(err_key) )){
     fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
     fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F410(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	mobilenum:=strings.Split(err_key, "|")[0]
	changenum:=strings.Split(err_key, "|")[1]
	if (call_type=="0"||call_type=="1") && changenum==mobilenum && len(mobilenum)>0 {
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}
func F420(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	if err_key=="0"||err_key=="1"{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}
func F430(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	duan,_:=strconv.Atoi(err_key)
	if duan>0 &&  IsNum(duan){
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}

func F440(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
    if err_key==""||err_key=="101"||err_key=="103"||err_key=="105"||err_key=="109"||err_key=="115"||err_key=="118"||err_key=="121"||err_key=="122"||err_key=="123"||err_key=="125"||err_key=="136"||err_key=="137"||err_key=="138" {
    fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}
func F450(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	fmt.Println(err_cd+call_type+"_"+row_num+"_is pass,not check!")
}
func F460(str string){
	err_cd,call_type,row_num,err_key,_ :=var_list (str)
	if err_key=="cs"||err_key=="LTE"{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else{
	fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
	}
}
func F461(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
	TAD:=strings.Split(err_key, "|")[0]
	access:=strings.Split(err_key, "|")[1]
	iscs:=strings.Contains(err_key,"sbc-dom")
	notcs:=!(iscs)
    if iscs && TAD=="cs"{
    fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
	}else if notcs && TAD=="LTE" {
	fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}

func F490(str string){
    err_cd,call_type,row_num,err_key,_ :=var_list (str)
	vpmn1:=strings.Contains(err_key,"10000000")
	vpmn2:=strings.Contains(err_key,"21000000")
    
    if err_key==""||vpmn1||vpmn2{
    fmt.Println(err_cd+call_type+"_"+row_num+"_is ok!")
    }else{
    fmt.Println(err_cd+call_type+"_"+row_num+"_is false!")
    }
}	

func fun_main(str string){
	err_cd,_,_,_,_ :=var_list (str)
	funcs := map[string]func(string){"F010":F010,"F040":F040,"F050":F050,"F060":F060,"F070":F070,"F071":F071,"F073":F073,"F090":F090,"F091":F091,"F110":F110 ,"F180":F180,"F190":F190,"F200":F200,"F210":F210,"F220":F220,"F350":F350,"F351":F351,"F360":F360,"F370":F370,"F371":F371,"F380":F380,"F390":F390,"F410":F410,"F420":F420,"F430":F430,"F440":F440,"F450":F450,"F460":F460,"F461":F461,"F490":F490} 
	fv := reflect.ValueOf( funcs[err_cd]) 
    args := []reflect.Value{reflect.ValueOf(str)}
 	fv.Call(args)
}


func main() {
//	fun_main("F071_0_17067239916_17867239916_20190519124859")
//	fun_main("F110_1_13267239916_13267239916_20190519124859")
//	fun_main("F370_0_13267239916_sbc-dom=.010._20190519124859")
	fun_main("F371_1_13267239916_CS|8613440367_20190519124859")

}
