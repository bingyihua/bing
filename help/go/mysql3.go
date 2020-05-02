package main
import (
	"fmt"
	"database/sql"
	"strconv"
	_"mysql"
)

func mysql(mobile_number, start_tm  string )(num string ,result string ){
	checkErr := func (err error){
	if err != nil {
		fmt.Println(err)
		}
	}
	db,err := sql.Open("mysql", "mcbdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8")
	checkErr(err)
	//select imsi moble_number
	sql_imsi:=`select   count(msisdn_area_id)  from  IMSI_LD_CD
	where 
		str_to_date(?, '%Y%m%d%H') <expired_tm  
	and  
		str_to_date(?, '%Y%m%d%H') > effc_tm
	and  
		msisdn_area_id=? 
	and 
		ld_area_cd 
			in (SELECT ld_area_cd from DOM_LD_AREA_CD_PROV_EXT 
					WHERE  str_to_date(?, '%Y%m%d%H') <expired_tm  
					and  
						str_to_date(?, '%Y%m%d%H') > effc_tm )
	and substr(msisdn_area_id,1,3) 
			in (select num_prefix FROM DOM_NUM_PREFIX 
					where str_to_date(?, '%Y%m%d%H') <expired_tm  
					and  str_to_date(?, '%Y%m%d%H') > effc_tm )` 
    //select unicom moble_number
    sql_unicom:=`select   count(msisdn_area_id)  from  unicom_msisdn_ld_cd
    where 
        str_to_date(?, '%Y%m%d%H') <expired_tm  
    and  
        str_to_date(?, '%Y%m%d%H') > effc_tm
    and  
        msisdn_area_id=?
    and 
        ld_area_cd 
            in (SELECT ld_area_cd from DOM_LD_AREA_CD_PROV_EXT 
                    WHERE  str_to_date(?, '%Y%m%d%H') <expired_tm  
                    and  
                        str_to_date(?, '%Y%m%d%H') > effc_tm )
    and substr(msisdn_area_id,1,3) 
            in (select num_prefix FROM DOM_NUM_PREFIX 
                    where str_to_date(?, '%Y%m%d%H') <expired_tm  
                    and  str_to_date(?, '%Y%m%d%H') > effc_tm )`

	sql_SP:=`select count(sp_int) from DOM_SP_RATE_INFO where  str_to_date(?, '%Y%m%d%H') <expired_tm 
	and  str_to_date(?, '%Y%m%d%H') > effc_tm
	and  substr(sp_int,1,5) in (12590,12586,12588,12596,12585) 
	and  substr(sp_int,1,6) in（125818,125880,125881,125886,125309)
	and  sp_int=?`

	rows_imsi,_ := db.Query(sql_imsi,start_tm,start_tm,mobile_number,start_tm,start_tm,start_tm,start_tm) 
	rows_unicom,_  := db.Query(sql_unicom,start_tm,start_tm,mobile_number,start_tm,start_tm,start_tm,start_tm)
	rows_sp ,_ := db.Query(sql_SP,start_tm,start_tm,mobile_number)
	rows_imsi.Next()
    var msisdn_area_id1 string
    rows_imsi.Scan(&msisdn_area_id1)
    
	var msisdn_area_id string
	rows_unicom.Next()
	rows_unicom.Scan(&msisdn_area_id)
	var sp_int  string
    rows_sp.Next()
    rows_unicom.Scan(&sp_int)
	aa,_:=strconv.Atoi(msisdn_area_id1)
	bb,_:=strconv.Atoi(msisdn_area_id)
	cc,_:=strconv.Atoi(sp_int)
	if   aa>0{
			result="yidong"
			num="1"
	}else if bb >0 {
			result="liantong"
			num="1"
	}else if cc>0 {
			result="sp"
			num="1"
	
	}else {
	 num="0"
	 result=""
	}
	return 
}

func main(){
	mysql("13267239916", "20190519110016" )
}

