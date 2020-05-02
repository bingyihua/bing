package main

import (
	 "fmt"
	"bufio"
	"strconv"
	"io"
	"os"
	"github.com/spf13/cobra"
	"strings"
)
//输入 (str 是一行话单记录，errcd是错单码)
//返回(对应错误码的键值和对应的列号)
func jiuqi_check_data (str,errcd string) (errdata ,COLUMN_NUM string){
	//9期貌似没有提供对应字段的列号信息，又不想一个个人工去确定，只人工确认一部分常见的错误码
	err:=map[string]int{"F071_0":20,"F071_1":20,"F072_0":20,"F072_1":20,"F073_1":20,"F091_0":22,"F092_0":22,"F093_0":22,"F091_1":22,"F092_1":22,"F094_0":22,"F200_0":33,"F200_1":33,"F350_0":47,"F350_1":47,"F351_0":47,"F351_1":47, "F360_1":47,"F370_1":48,"F371_1":48}
	CDR_TYPE:=strings.Split(str, "|")[6]
    err_Cd:=errcd
    line_key:=err_Cd+"_"+CDR_TYPE
    line:=err[line_key]
	if line >0 {
    	line_v:=strings.Split(str, "|")[line-1]
    	errdata=line_v
		//因为在第一列加了rowkey方便hbase查询所有没有-1
		COLUMN_NUM=strconv.Itoa(line)

	}else{
		errdata="9期暂未获取对应值"
		COLUMN_NUM="0"
	}
	return
}


//同时功能
func yiqi_check_data (str,errcd string) (errdata ,COLUMN_NUM string){
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
    err["F370_1"]="47"
    err["F371_1"]="47"
    err["F380_1"]="49"
    err["F390_1"]="50"
    err["F410_0"]="51"
    err["F410_1"]="51"
    err["F420_0"]="52"
    err["F420_1"]="52"
    err["F430_0"]="53"
    err["F430_1"]="53"
    err["F440_0"]="54"
    err["F440_1"]="54"
    err["F450_0"]="55"
    err["F450_1"]="55"
    err["F460_0"]="56"
    err["F460_1"]="56"
    err["F461_0"]="56"
    err["F461_1"]="56"
    err["F490_0"]="59"
    err["F490_1"]="59"
    //这个是加rowkey 需要+1
    CDR_TYPE:=strings.Split(str, "|")[9-1]
    err_Cd:=errcd
    line_key:=err_Cd+"_"+CDR_TYPE
    //CALL_START_TM:=strings.Split(str, "|")[23]
    //fmt.Println(err[line_key])
    line:=err[line_key]
    int_line, _:= strconv.Atoi(line)
    line_v:=strings.Split(str, "|")[int_line]
    errdata=line_v
	COLUMN_NUM=strconv.Itoa(int_line+1)
    return
}

//输入，两个csv文件名
//返回三个返回值，把csv的数据加载的两个list，dat_list 是存放相同的dat文件名
func same_dat (jiu_file,yi_file string)(jiuqilist, yiqilist,dat_list []string ){
	jiu_list:=readline_list(jiu_file)
	jiu_map:=make(map[string]string)
	yi_map:=make(map[string]string)
	same_map:=make(map[string]string)
	yi_list:=readline_list(yi_file)
	for _,v :=range jiu_list{
		dat_nm:=strings.Split(v,"|")[0]
		jiu_map[dat_nm]=dat_nm
	}
	//fmt.Println(len(jiu_map)) 获取去重的dat文件名的map
	
	for _,vv :=range yi_list{
		dat_nm:=strings.Split(vv,"|")[2]
		yi_map[dat_nm]=dat_nm //获取去重的dat文件名的map
	}
	//fmt.Println(len(yi_map))
	for _,v :=range jiu_map{
		for _,vv := range yi_map{
			if v==vv {
				same_map[v] = v //获取相同的dat文件名的map
			}
		}
	}
	//fmt.Println(len(same_map))
	if len(same_map)>1{
		yi_num:=0
		jiu_num:=0
		jiuqi_list:=make([]string,len(jiu_list))
		for _,v:=range jiu_list{
			//jiuqi_list:=make([]string,len(jiu_list))//定义中间数组存储相同的话单名的话单记录，因为数量不确定需要定义大点
			dat_nm:=strings.Split(v,"|")[0]
			for _,vv:=range same_map{
				if dat_nm==vv{
					jiu_num++
					jiuqi_list[jiu_num-1]=v
				}
			}
		}
		jiuqilist=jiuqi_list[0:jiu_num] //去重空元素
		//fmt.Println(jiuqi_list)
		yiqi_list:=make([]string,len(yi_list))
		same_dat_name:=make([]string,len(yi_list))
		same_num:=0
		for _,vv:=range same_map{
			same_num++
			same_dat_name[same_num-1]=vv
		}
		dat_list=same_dat_name[0:same_num]
		for _,v:=range yi_list{
			//fmt.Println(v)	
			//yiqi_list:=make([]string,len(yi_list))
			dat_nm:=strings.Split(v,"|")[2]
			for _,vv:=range same_map{
				if dat_nm==vv{
					yi_num++
					yiqi_list[yi_num-1]=v
					
				}
			}
		}
		yiqilist=yiqi_list[0:yi_num]
		//fmt.Println(yiqi_list)
	}else{
		fmt.Println("no,same dat !!!")
	}
	return
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

/*
func count_yiqi_err_cd(jiu_file,yi_file string){
	linelist,_,_:=same_dat (jiu_file,yi_file)
	dat_map:=make(map[string]string)//sava datnm map
	huadan_list:=make([]string,len(linelist))//sava err list
	for _,v :=range linelist{
		dat_nm:=strings.Split(v,"|")[2]
		dat_map[dat_nm]=dat_nm
	}
	//fmt.Println(dat_map)
	for _,v := range dat_map {
		err_map:=make(map[string]string)
		err_count:=make(map[string]int)//sava err res map
		row := 0
		for _, line := range linelist {
			errcd := strings.Split(line, "|")[60]
			dat_nm := strings.Split(line, "|")[2]
			if v == dat_nm {
				row++
				huadan_list[row-1] = errcd
			}
		}
		huadan_list:=huadan_list[0:row]
		//fmt.Println(huadan_list)
		for  _,err_v:=range huadan_list{
			err_map[err_v]=err_v
		}
		//fmt.Println(err_map)
		for _,err_cd :=range err_map{
			num:=0
			for _,errv:=range huadan_list{

				if 	err_cd == errv{
					num++
				}
			}
			err_count[err_cd]=num
		}
		fmt.Println(v,err_count)
	}  
}
*/

func count_jiuqi_err_cd(jiu_file,yi_file string){
	jiuqi_list,yiqi_list,dat_list:=same_dat (jiu_file,yi_file)
    for _,v := range dat_list {
        jiu_err_map:=make(map[string]string)
		yi_err_map:=make(map[string]string)
        //row := 0
        for _ , line := range jiuqi_list {
            errcd := strings.Split(line, "|")[59]
            dat_nm := strings.Split(line, "|")[0]
			CALL_START_TM:= strings.Split(line, "|")[23]
			call_type:= strings.Split(line, "|")[6]
			IMS_CHARGE_id := strings.Split(line, "|")[33]
			line_vv,col_num:=jiuqi_check_data(line,errcd)
			STTL_DT:=strings.Split(line, "|")[1]
			//row := fmt.Sprintf("%d", r+1)
            if v == dat_nm {
                //row++
                jiu_err_map[IMS_CHARGE_id+"|"+CALL_START_TM+"|"+call_type] = errcd+"_"+call_type+"_"+line_vv+"_"+col_num+"_"+CALL_START_TM+"_"+STTL_DT+"_%%"+line
            }
        }
        
        //fmt.Println(jiu_err_map)

		for _, line_y := range yiqi_list {
            errcd := strings.Split(line_y, "|")[60]
            dat_nm := strings.Split(line_y, "|")[2]
            CALL_START := strings.Split(line_y, "|")[23]
            Call_type:= strings.Split(line_y, "|")[8]
			IMS_CHARGE_ID := strings.Split(line_y, "|")[33]
			STTL:=strings.Split(line_y, "|")[3]
			line_v,col_nu:=yiqi_check_data(line_y,errcd)
			//Row := fmt.Sprintf("%d", R+1)
            if v == dat_nm {
                //row++
                yi_err_map[IMS_CHARGE_ID+"|"+CALL_START+"|"+Call_type] = errcd+"_"+Call_type+"_"+line_v+"_"+col_nu+"_"+CALL_START+"_"+STTL+"_%%"+line_y
            }
        }
		//fmt.Println(jiu_err_map ,yi_err_map)
		map_num:=0
		for k,v:=range jiu_err_map{
			for kk,vv :=range yi_err_map{
				if k==kk && strings.Split(v, "_")[0]==strings.Split(vv, "_")[0] && strings.Split(v, "_")[1]==strings.Split(vv, "_")[1] {
					map_num++
				}
			}
		} 
        if len(jiu_err_map)==map_num && len(yi_err_map)==map_num {
			//fmt.Println(v+"is ok")
		}else{
			fmt.Println("---------------------------------------------------------------------------------------------------\n")
			fmt.Println(v+"话单错单表差异如下，只显示同一个话单的差异")

			for k,v :=range   yi_err_map {
				//delete same map 
				for kk,vv  :=range jiu_err_map{ 
					if k==kk && strings.Split(v, "_")[0]==strings.Split(vv, "_")[0] && strings.Split(v, "_")[1]==strings.Split(vv, "_")[1]{
						delete(yi_err_map,k)
						delete(jiu_err_map,kk)
					}
				}
			}
			for k,v :=range   yi_err_map{
				errcd:=strings.Split(v, "_")[0]
				call_type:=strings.Split(v, "_")[1]
				value:=strings.Split(v, "_")[2]
				col_num:=strings.Split(v, "_")[3]
				CALL_START :=strings.Split(v, "_")[4]
				jiu := odbcheck(errcd,CALL_START,value)
				yi := mdbcheck(errcd,CALL_START,value)
				STTL_DT:=strings.Split(v, "_")[5]
				yi_row:=strings.Split(v, "%%")[1]
				if errcd=="F093"||errcd=="F092"||errcd=="F091"||errcd=="F071"||errcd=="F072"||errcd=="F351"{
					fmt.Println("一期结算vlt：账期="+STTL_DT+"【"+k+"】错误码为"+errcd+"呼叫类型为"+call_type+";对应错误码值为: "+value+" 对应列号:"+col_num+"列","一期："+yi+";九期："+jiu+";201909_200_err.csv文件内容如下\n"+yi_row)
				}else{
					fmt.Println("一期结算vlt：账期="+STTL_DT+"【"+k+"】错误码为"+errcd+"呼叫类型为"+call_type+";对应错误码值为: "+value+" 对应列号:"+col_num+"列;201909_200_err.csv文件内容如下\n"+yi_row)
				}
			}

			for k,v :=range   jiu_err_map {
				errcd:=strings.Split(v, "_")[0]
                call_type:=strings.Split(v, "_")[1]
                value:=strings.Split(v, "_")[2]
                col_num:=strings.Split(v, "_")[3]
                CALL_START :=strings.Split(v, "_")[4]
                jiu := odbcheck(errcd,CALL_START,value)
                yi := mdbcheck(errcd,CALL_START,value)	
				STTL_dt:=strings.Split(v, "_")[5]
				jiu_row:=strings.Split(v, "%%")[1]
				if errcd=="F093"||errcd=="F092"||errcd=="F091"||errcd=="F071"||errcd=="F072"||errcd=="F351"{
					fmt.Println("九期vlt结算：账期="+STTL_dt+"【"+k+"】错误码为"+errcd+"呼叫类型为"+call_type+";对应错误码值为: "+value+" 对应列号:"+col_num+"列","一期："+yi+";九期："+jiu+";err_200.css文件内容如下\n"+jiu_row)
				}else{
					fmt.Println("九期vlt结算：账期="+STTL_dt+"【"+k+"】错误码为"+errcd+"呼叫类型为"+call_type+";对应错误码值为: "+value+" 对应列号:"+col_num+"列；err_200.csv文件内容如下\n"+jiu_row)
				}
			}
			fmt.Println("---------------【IMS_CHARGE_ID|开始通话时间|通话类型】定位同一话单----------------------------------\n")	
		}

		
    }
	defer odb.Close()
	defer mdb.Close()
	str:=`数据查询：
--oracle 九期
vltdba/HyxtTest_9@vlt //9期详单用户
mcbdba/HyxtTest_9@vlt //9期公参用户

192.167.117.247 清数据脚本 /opt/mcb/vlt/bin>clr_env_nm_vlt.sh +话单名
192.167.117.247 9期预处理放话单目录/opt/mcb/vlt/data/incoming/571/

select * from FILE_PROCESS_STATE where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20190616114649_00001061.dat';
--查看话单处理状态

select *from ERR_CDR_VLT_200 where CALL_START_TM="" and ic_file_nm="";
select *from PRE_MERGE_CDR_VLT_HM_200 where CALL_START_TM=""and ic_file_nm="";
一期结算按文件查询`
	fmt.Println(str)
}

var jiuqi_err_csv string
var yiqi_err_csv string

var RootCmd = &cobra.Command{
    Use:   "help",
    Short: "",
    Long:  `
example: ./Compare_Volte_Errcd -j err_200.csv -y 201908_200_err.csv

9期192.168.117.247  /home/mcbadm/目录下执行 ./exp_csv 200  可生成err_200.csv 文件
一期结算 192.168.158.172 /home/mcbadm/目录下执行 ./hbase_exp 201908 200 err 可生成201908_200_err.csv
Compare_Volte_Errcd 自动对比打印两个csv相同的话单的错单差异
`,
    Run: func(cmd *cobra.Command, args []string) {
        if len(jiuqi_err_csv) == 0 {
            fmt.Println("参数不能为空，-h 获取帮助")
            return
        }
        Show(jiuqi_err_csv, yiqi_err_csv)
    },
}

func Execute() {
    if err := RootCmd.Execute(); err != nil {
        fmt.Println(err)
        os.Exit(-1)
    }
}

func init() {
    RootCmd.Flags().StringVarP(&jiuqi_err_csv, "jiuqi_err_csv", "j", "", "输入话音9期vlt的错单csv文件名")
    RootCmd.Flags().StringVarP(&yiqi_err_csv, "yiqi_err_csv", "y", "", "输入1期结算vlt的错单csv文件名")
}

func main() {
    Execute()
}
func Show(jiuqi_err_csv string, yiqi_err_csv string) {
    count_jiuqi_err_cd(jiuqi_err_csv,yiqi_err_csv)
}
