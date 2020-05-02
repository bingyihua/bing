package main
import (
"database/sql"
"fmt"
_"mysql"
	"strconv"
	"strings"
)
var (
	db *sql.DB
	dburl = "mcbdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8"

	IMSI_LD_CD_SQL = `select   msisdn_area_id ,ld_area_cd,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S')  from  IMSI_LD_CD ;`
	UNICOM_MSISDN_LD_CD_SQL = `select   msisdn_area_id ,ld_area_cd,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S')  from  UNICOM_MSISDN_LD_CD ;`
	SWCH_ID_LD_CD_SQL = `select  swch_area_id,ld_area_cd,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S')  from  SWCH_ID_LD_CD;`
	DOM_SP_RATE_INFO_SQL = `select  sp_int,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S')  from  DOM_SP_RATE_INFO`
	DOM_NUM_PREFIX_SQL = `select  num_prefix,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S') ,carrier_type from  DOM_NUM_PREFIX`
	DOM_LD_AREA_CD_PROV_EXT_SQL = `select  ld_area_cd,date_format(effc_tm, '%Y%m%d%H%I%S'),date_format(expired_tm, '%Y%m%d%H%I%S')  from  DOM_LD_AREA_CD_PROV_EXT`

)

func init() {
	var err error
	db, err = sql.Open("mysql",dburl)
	if err != nil {
		panic(err)
	}
}

func sava_map()(IMSI_LD_CD,UNICOM_MSISDN_LD_CD,DOM_NUM_PREFIX,DOM_LD_AREA_CD_PROV_EXT,SWCH_ID_LD_CD, DOM_SP_RATE_INFO map[string]string ){
	IMSI_LD_CD = make(map[string]string)
	SWCH_ID_LD_CD = make(map[string]string)
	UNICOM_MSISDN_LD_CD = make(map[string]string)
	DOM_NUM_PREFIX = make(map[string]string)
	DOM_LD_AREA_CD_PROV_EXT = make(map[string]string)
	DOM_SP_RATE_INFO = make(map[string]string)

	IMSI_LD_CD_rows, _ := db.Query(IMSI_LD_CD_SQL)
    for IMSI_LD_CD_rows.Next() {
        var msisdn_area_id, ld_area_cd, effc_tm,expired_tm string
        if err := IMSI_LD_CD_rows.Scan(&msisdn_area_id,&ld_area_cd, &effc_tm, &expired_tm); err != nil {
            fmt.Println(err)
        }
		IMSI_LD_CD[msisdn_area_id]=effc_tm+"|"+expired_tm+"|"+ld_area_cd
	}

	UNICOM_MSISDN_LD_CD_rows, _ := db.Query(UNICOM_MSISDN_LD_CD_SQL)
    for UNICOM_MSISDN_LD_CD_rows.Next() {
        var msisdn_area_id, ld_area_cd, effc_tm,expired_tm string
        if err := UNICOM_MSISDN_LD_CD_rows.Scan(&msisdn_area_id,&ld_area_cd, &effc_tm, &expired_tm); err != nil {
            fmt.Println(err)
        }
        UNICOM_MSISDN_LD_CD[msisdn_area_id]=effc_tm+"|"+expired_tm+"|"+ld_area_cd
    }

	SWCH_ID_LD_CD_rows, _ := db.Query(SWCH_ID_LD_CD_SQL)
    for SWCH_ID_LD_CD_rows.Next() {
        var swch_area_id, ld_area_cd, effc_tm,expired_tm string
        if err := SWCH_ID_LD_CD_rows.Scan(&swch_area_id,&ld_area_cd, &effc_tm, &expired_tm); err != nil {
            fmt.Println(err)
        }
        SWCH_ID_LD_CD[swch_area_id]=effc_tm+"|"+expired_tm+"|"+ld_area_cd
    }
	
	DOM_LD_AREA_CD_PROV_EXT_rows, _ := db.Query(DOM_LD_AREA_CD_PROV_EXT_SQL)
    for DOM_LD_AREA_CD_PROV_EXT_rows.Next() {
        var  ld_area_cd, effc_tm,expired_tm string
        if err := DOM_LD_AREA_CD_PROV_EXT_rows.Scan(&ld_area_cd, &effc_tm, &expired_tm); err != nil {
            fmt.Println(err)
        }
        DOM_LD_AREA_CD_PROV_EXT[ld_area_cd]=effc_tm+"|"+expired_tm
    }
	DOM_SP_RATE_INFO_rows, _ := db.Query(DOM_SP_RATE_INFO_SQL)
    for DOM_SP_RATE_INFO_rows.Next() {
        var  sp_int, effc_tm,expired_tm string
        if err := DOM_SP_RATE_INFO_rows.Scan(&sp_int, &effc_tm, &expired_tm); err != nil {
            fmt.Println(err)
        }
        DOM_SP_RATE_INFO[sp_int]=effc_tm+"|"+expired_tm
    }
	DOM_NUM_PREFIX_rows, _ := db.Query(DOM_NUM_PREFIX_SQL)
    for DOM_NUM_PREFIX_rows.Next() {
        var  num_prefix,carrier_type, effc_tm,expired_tm string
        if err := DOM_NUM_PREFIX_rows.Scan(&num_prefix, &effc_tm, &expired_tm,&carrier_type); err != nil {
            fmt.Println(err)
        }
        DOM_NUM_PREFIX[num_prefix]=effc_tm+"|"+expired_tm+"|"+carrier_type
    }
	db.Close()
	return 
	
}
func check_mobile(mobile_num ,start_str string,IMSI,UNICOM,PREFIX,AREA_CD  map[string]string)(result string){
	pre_three :=mobile_num[0:3]
	if res_three:=PREFIX[pre_three];len(res_three)>0 {
		res_effc:=strings.Split(res_three,"|")[0]
        res_expired:=strings.Split(res_three,"|")[1]
		carrier_type:=strings.Split(res_three,"|")[2]
        effc_tm,_:=strconv.Atoi(res_effc)
		start_tm,_:=strconv.Atoi(start_str)
        expired_tm,_:=strconv.Atoi(res_expired)
		// fmt.Println(start_tm,res_three) 
		if  start_tm > effc_tm && start_tm <expired_tm {
			if carrier_type=="1"{
				 if res:=IMSI[mobile_num];len(res)>0 {
        			res_effc:=strings.Split(res,"|")[0]
        			effc_tm,_:=strconv.Atoi(res_effc)
        			res_expired:=strings.Split(res,"|")[1]
        			expired_tm,_:=strconv.Atoi(res_expired)
        			if start_tm > effc_tm && start_tm <expired_tm {
            			res_ld_area_cd:=strings.Split(res,"|")[2]
            			resDOM_LD:=AREA_CD[res_ld_area_cd]
            			if len(resDOM_LD)>0{
                			res_effc:=strings.Split(resDOM_LD,"|")[0]
                			effc_tm,_:=strconv.Atoi(res_effc)
                			res_expired:=strings.Split(resDOM_LD,"|")[1]
                			expired_tm,_:=strconv.Atoi(res_expired)
                			if start_tm > effc_tm && start_tm <expired_tm {
                            	result="1_yidong"
								goto end
                    		}else {
                        		result="0_yidong_DOM_LD"
                    		}
		                }else {
                    		result="0"
                		}
            		}else{
                		result="0_yidong_IMSI"
            		}
            	}else{
                	result="0_yidong_c"
            	} 
			}else{
				goto lianton	 
			}
		}else{
		result="0_PREFIX"
		
		}
	}else{
		result="0"
	}
	lianton:
	if  res:= UNICOM[mobile_num]; len(res)>0 {
        res_effc:=strings.Split(res,"|")[0]
        effc_tm,_:=strconv.Atoi(res_effc)
        start_tm,_:=strconv.Atoi(start_str)
        res_expired:=strings.Split(res,"|")[1]
        expired_tm,_:=strconv.Atoi(res_expired)
        if start_tm > effc_tm && start_tm <expired_tm {
        	res_ld_area_cd:=strings.Split(res,"|")[2]
            resDOM_LD:=AREA_CD[res_ld_area_cd]
            if len(resDOM_LD)>0{
            	res_effc:=strings.Split(resDOM_LD,"|")[0]
                effc_tm,_:=strconv.Atoi(res_effc)
                res_expired:=strings.Split(resDOM_LD,"|")[1]
                expired_tm,_:=strconv.Atoi(res_expired)
                if start_tm > effc_tm && start_tm <expired_tm {
                	result="1_liantong"    
                }else {
                	result="0_liantong_DOM_LD"
                }
            }else{
            	result="0_liantong_y"
            }
        }else{
           result="0_liantong_UNICOM"
        }
    }
	end:
    return
}
func check_switch(switch_code ,start_str string, swich,AREA_CD  map[string]string)(result string){
	 if  res:= swich[switch_code]; len(res)>0 {
        res_effc:=strings.Split(res,"|")[0]
        effc_tm,_:=strconv.Atoi(res_effc)
        start_tm,_:=strconv.Atoi(start_str)
        res_expired:=strings.Split(res,"|")[1]
        expired_tm,_:=strconv.Atoi(res_expired)
        if start_tm > effc_tm && start_tm <expired_tm {
            res_ld_area_cd:=strings.Split(res,"|")[2]
            resDOM_LD:=AREA_CD[res_ld_area_cd]
	//		fmt.Println(resDOM_LD,res,res_ld_area_cd,AREA_CD)
            if len(resDOM_LD)>0{
                res_effc:=strings.Split(resDOM_LD,"|")[0]
                effc_tm,_:=strconv.Atoi(res_effc)
                res_expired:=strings.Split(resDOM_LD,"|")[1]
                expired_tm,_:=strconv.Atoi(res_expired)
                if start_tm > effc_tm && start_tm <expired_tm {
                    result="1_switch"
                }else {
                    result="0__DOM_LD"
                }
            }else{
                result="0__y"
            }
        }else{
           result="0_switch"
        }
    } 
	return 
}

func check_sp(sp_code ,start_str string, sp map[string]string)(result string){
	p1:=strings.HasPrefix(sp_code,"12590")
	p2:=strings.HasPrefix(sp_code,"12586")
	p3:=strings.HasPrefix(sp_code,"12588")
	p4:=strings.HasPrefix(sp_code,"12596")
	p5:=strings.HasPrefix(sp_code,"12585")
	s1:=strings.HasPrefix(sp_code,"125818")
	s2:=strings.HasPrefix(sp_code,"125880")
	s3:=strings.HasPrefix(sp_code,"125881")
	s4:=strings.HasPrefix(sp_code,"125886")
	s5:=strings.HasPrefix(sp_code,"125309")
	if s1||s2||s3||s4||s5||p1||p2||p3||p4||p5{
		if  res:= sp[sp_code]; len(res)>0 {
        	res_effc:=strings.Split(res,"|")[0]
        	effc_tm,_:=strconv.Atoi(res_effc)
        	start_tm,_:=strconv.Atoi(start_str)
        	res_expired:=strings.Split(res,"|")[1]
        	expired_tm,_:=strconv.Atoi(res_expired)
			if start_tm > effc_tm && start_tm <expired_tm {
				result="1"
		
			}else{
				result="0"
			}
		}else{
			result="0"
		}
		
	}else{
		result="0"
	}
	return
}
func check_area(area_code ,start_str string, AREA_CD  map[string]string)(result string){
	if  res:= AREA_CD[area_code]; len(res)>0 {
		res_effc:=strings.Split(res,"|")[0]
		effc_tm,_:=strconv.Atoi(res_effc)
		start_tm,_:=strconv.Atoi(start_str)
		res_expired:=strings.Split(res,"|")[1]
		expired_tm,_:=strconv.Atoi(res_expired)
		if start_tm > effc_tm && start_tm <expired_tm {
			result="1"
		}else{
			result="0"
		}

	}else{
		result="0"
	}
	return
}

/*
func main (){
	IMSI,UNICOM,PREFIX,AREA_CD,swich,sp:=sava_map()
	qq:=check_mobile("1353759","20190411121112", IMSI,UNICOM,PREFIX,AREA_CD)
	ww:=check_switch("13440203","20190411121112", swich,AREA_CD)
 	qqq:=check_mobile("1326723","20190411121112", IMSI,UNICOM,PREFIX,AREA_CD)
 	ok:=check_sp("125880","20190411121112", sp)
	fmt.Println(qq)
	fmt.Println(ww)
	fmt.Println(qqq)
	fmt.Println(ok)
	okk:=check_area("1755","20190411121112", AREA_CD)
	fmt.Println(okk)
}
*/
