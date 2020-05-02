package main

import ( "fmt"
 		 "strconv"
		 "strings"
		 "os"
		 "io"
		 "bufio"
		  "path/filepath"
	 )


func IsNum(s string) bool {
	_, err := strconv.ParseFloat(s, 64) 
	return err == nil 
}

func is_int(i interface{}) bool{
    var result bool
    switch i.(type) {
    case int:
        result=true
    default:
        result=false
    }
    return result
}

func readline_list  (file string ) ( file_list [] string){
    fi, err := os.Open(file)
    if err != nil {
        fmt.Printf("Error: %s\n", err)
       }

    br := bufio.NewReader(fi)
    for {
        line, _, c := br.ReadLine()
        if c == io.EOF {
            break
            }

         file_list = append(file_list,string(line))
        }
    fi.Close()
    return
}

func var_list (str string)(cs_flags,Service_Id,Call_Type,call_duan,HM_provcd,vs_provcd,Hm_chg,Vs_chg,IN_FLAG,other_party string){
	cs_flags    =strings.Split(str, "|")[46]//SBC_ANI
	Service_Id  =strings.Split(str, "|")[54]
	Call_Type   =strings.Split(str, "|")[8]
	call_duan   =strings.Split(str, "|")[53]
	HM_provcd   =strings.Split(str, "|")[7]
	vs_provcd   =strings.Split(str, "|")[6]
	Hm_chg      =strings.Split(str, "|")[11]
	Vs_chg      =strings.Split(str, "|")[10]
	IN_FLAG     =strings.Split(str, "|")[61]
	if Call_Type =="0"{
		other_party =strings.Split(str, "|")[21]
	}else{
		other_party =strings.Split(str, "|")[19]
	}

	return
}
func iscs (str string)bool{
    var result bool
    cs_flags,_,_,_,_,_,_,_,_,_:=var_list (str)
    a:=strings.Contains(cs_flags,"CS")
    if !a{
        result=false
    }else{
        result=true
    }
    return result
}
func chg_0_seriveid(str string)bool{
    _,Service_Id,_,_,_,_,_,_,_,_:=var_list (str)
    var result bool
    if Service_Id=="101" || Service_Id=="103" ||  Service_Id=="105" || Service_Id=="109" || Service_Id=="122"|| Service_Id=="123"|| Service_Id=="125"||Service_Id=="136"||Service_Id=="137"||Service_Id=="138"{
        result=true
    }else{
        result=false
    }
    return result
}


func check_chg(str string)(result bool,ty string){
	_,_,Call_Type,call_duan,HM_provcd,_,Hm_chg,Vs_chg,IN_FLAG,other_party:=var_list (str)
	//根据主被叫类型和IN_FLAG 对话单进行识别计费 ，IN_FLAG为5只计算出套内套外分钟数，不能确定哪个是套内分钟数
	chg_func:=func()( chg_res int){
		duan,_:=strconv.Atoi(call_duan)
		//chg()函数可以返回当前话单的分钟数
    	chg:=func ()(min int){
    		if (duan%60)==0{
        		min=duan/60
        	}else{
            	min=(duan-duan%60)/60+1
        	}
        	return
	    } 
    	//4为套外状态，1为vpnm，他们的主叫都是100厘

    	if Call_Type=="0" && (IN_FLAG=="1" || IN_FLAG=="0" || IN_FLAG=="4" ){
			chg_res=chg()*100
		//2是亲情网不区分主被叫，3是v网套内只有主叫，10厘每分
    	}else if  IN_FLAG=="2" ||(IN_FLAG=="3" && Call_Type=="0") {
			chg_res=chg()*10
		//20厘每分
    	}else if Call_Type=="1" && (IN_FLAG=="1" || IN_FLAG=="0" || IN_FLAG=="4" )  {
			chg_res=chg()*20
		//5为v网跨越，套内10厘，套外100厘，总结算=套内10厘*套内分钟数+套外100厘*套外分钟数
		}else if Call_Type=="0" && IN_FLAG=="5"{
			//因为累积量表没有提供话单的累计量信息，只能检查是不是100和10的整数
			 hm_chg,_:=strconv.Atoi(Hm_chg)
			 vs_chg,_:=strconv.Atoi(Vs_chg)
			 //a+b=7;a*100+b*10=250 用变量替换获取其中一个a 的套内分钟数
			 min:=(chg()*100-hm_chg)/90
			 //因为是混合值，所以a的分钟数必须小于总分钟数chg(),大于0分的整数类型
			 if min<chg() && min>0 && vs_chg==hm_chg && is_int(min) {
			 	chg_res=hm_chg
			 }else{
			 	chg_res=0
			 }
			//
    	}else{
			chg_res=0
			fmt.Print("程序违背需求，需测试人工核查")
			
    	}
    	return 
	}
	//cs和seriveid 免批
	if chg_0_seriveid(str) || iscs(str){
		if Hm_chg=="0" && Vs_chg=="0"{
			result=true
		}else{
			result=false
			ty="cs和service免批"
		}
	}else{//对hm 971和891的话单判定
		if HM_provcd=="971" || HM_provcd=="891" {
			if Hm_chg=="0"{
				result=true
			}else{
				result=false
				ty="归属971和891话单"
			} 
		}else  if HM_provcd !="971" ||HM_provcd!="891"{
			Hm_chg,_:=strconv.Atoi(Hm_chg)
			Vs_chg,_:=strconv.Atoi(Vs_chg)
	 		if  Hm_chg==chg_func() && Vs_chg==chg_func() && Vs_chg==Hm_chg{
				result=true
			}else{
				//简单过滤10086和110		
				if  (strings.Contains(other_party,"10086")  || strings.HasSuffix( other_party,"110")) && len(other_party)<11 && Hm_chg==0&&Vs_chg==0{
					result=true
				}else{
					result=false
					ty="特服号码金额报错"
				}		
			}
		}else{
			result=false
			ty="未知金额报错话单"
		}

	}
	return 
	
}
func checkall_chg(file string)(cs_num,free_mobile_num,vpmn_num,free_prov_num,free_sevice_id_num,love_mobile_num,v_tree_num,v_four_num,v_five_num int){
	file_list:=readline_list(file)
	row_num:=0
	err_num:=0

	cs_num=0
    free_mobile_num=0
    vpmn_num=0
    free_prov_num=0
    free_sevice_id_num=0
    love_mobile_num=0
    v_tree_num=0
    v_four_num=0
    v_five_num=0
	for _,str:= range file_list{
		row_num++
		res,ty:=check_chg(str)
		if !(res){
			err_num++
			fmt.Print(" 第"+strconv.Itoa(row_num)+"行 " )
			fmt.Println("金额错误"+ty)
			str:=file_list[row_num-1]
			fmt.Println(str)
			fmt.Println("-----------话单关键字段信息如下----------")
			cs_flags,Service_Id,Call_Type,call_duan,HM_provcd,vs_provcd,Hm_chg,Vs_chg,IN_FLAG,other_party:=var_list (str)
			fmt.Println("cs_flags="+cs_flags)
			fmt.Println("Service_Id="+Service_Id)
			fmt.Println("Call_Type="+Call_Type)
			fmt.Println("call_duan="+call_duan)
			fmt.Println("HM_provcd="+HM_provcd)
			fmt.Println("vs_provcd="+vs_provcd)
			fmt.Println("Hm_chg="+Hm_chg)
			fmt.Println("Vs_chg="+Vs_chg)
			fmt.Println("IN_FLAG="+IN_FLAG)
			fmt.Println("other_party="+other_party)
			fmt.Println("-------------------------------------------------------------------------------------------------------")
		} else{
			if iscs(str){
				cs_num++
				//fmt.Println(cs_num)
			}else if chg_0_seriveid(str) {
				free_sevice_id_num++

			}else if _,_,_,_,_,_,_,_,IN_FLAG,_:=var_list (str);IN_FLAG=="1"{
				vpmn_num++
			}else if _,_,_,_,_,_,_,_,IN_FLAG,_:=var_list (str);IN_FLAG=="2"{
				love_mobile_num++
			}else if _,_,_,_,_,_,_,_,IN_FLAG,_:=var_list (str);IN_FLAG=="3"{
				v_tree_num++
			}else if _,_,_,_,_,_,_,_,IN_FLAG,_:=var_list (str);IN_FLAG=="4"{
				v_four_num++
			}else if _,_,_,_,_,_,_,_,IN_FLAG,_:=var_list (str);IN_FLAG=="5"{
				v_five_num++
			}else if _,_,_,_,HM_provcd,vs_provcd,_,_,_,_:=var_list (str); (vs_provcd == "971" ||vs_provcd == "891")&& (HM_provcd =="971" ||HM_provcd=="891"){
				free_prov_num++
			}else if _,_,_,_,_,_,Hm_chg,Vs_chg,_,other_party:=var_list (str);(strings.Contains(other_party,"10086")  || strings.Index("110", other_party)!= -1 ) && len(other_party)<11 && Hm_chg=="0"&&Vs_chg=="0"{
				free_mobile_num++
			}
		}

	}
	if err_num==0{
		fmt.Println("检查所有话单记录金额都是正确的")
	}
	return 
}
func IsExist(f string) bool {
    _, err := os.Stat(f)
    return err == nil || os.IsExist(err)
}
func main() {
	_, fileName := filepath.Split(os.Args[0])
	if len(os.Args)==2{
		if IsExist(os.Args[1]){	
			//cs_num,free_mobile_num,vpmn_num,free_prov_num,free_sevice_id_num,love_mobile_num,v_tree_num,v_four_num,v_five_num:=checkall_chg(os.Args[1])
			fmt.Println(checkall_chg(os.Args[1]))
		}else{
			fmt.Println(os.Args[1]+"不存在")
		}
	}else{
		fmt.Println("./"+fileName+" + 一期详单csv文件名")
	}
}

