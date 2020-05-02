package main
import (
_	"fmt"
	"database/sql"
	"strconv"
	_ "mysql"
)

func mysql(mobile_number, start_tm  string )(num string ,result string ){
	db,_ := sql.Open("mysql", "mcbdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8")
	//select imsi moble_number
	sql_imsi:=`select   COUNT(msisdn_area_id)  from  imsi_ld_cd a , dom_ld_area_cd_prov_ext b , dom_num_prefix c 
    where a.ld_area_cd=b.ld_area_cd
		and c.num_prefix=substr(?,1,3)
        and a.msisdn_area_id=substr(?,1,7)
        and str_to_date(?, '%Y%m%d%H')> a.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<a.expired_tm 
        and str_to_date(?, '%Y%m%d%H')> b.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<b.expired_tm
        and str_to_date(?, '%Y%m%d%H')> c.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<c.expired_tm`
    //select unicom moble_number
    sql_unicom:=`select   COUNT(carrier_type)   from  unicom_msisdn_ld_cd a , dom_ld_area_cd_prov_ext b , dom_num_prefix c 
	where a.ld_area_cd=b.ld_area_cd
        and c.num_prefix=substr(?,1,3)
        and a.msisdn_area_id=substr(?,1,7)
        and str_to_date(?, '%Y%m%d%H')> a.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<a.expired_tm 
        and str_to_date(?, '%Y%m%d%H')> b.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<b.expired_tm
        and str_to_date(?, '%Y%m%d%H')> c.effc_tm 
        and str_to_date(?, '%Y%m%d%H')<c.expired_tm`
	// select sp moble_number
	sql_SP:=`select count(sp_int) from DOM_SP_RATE_INFO where  str_to_date(?, '%Y%m%d%H') <expired_tm 
	and  str_to_date(?, '%Y%m%d%H') > effc_tm
	and  sp_int=?
	and  substr(sp_int,1,5) in (12590,12586,12588,12596,12585) 
	and  substr(sp_int,1,6) in（125818,125880,125881,125886,125309)`
	sql_area:=`select count(ld_area_cd) from DOM_LD_AREA_CD_PROV_EXT  where ld_area_cd=?
	and  str_to_date(?, '%Y%m%d%H') <expired_tm  
	and  str_to_date(?, '%Y%m%d%H') > effc_tm ) `

	// select switch moble_number
	sql_Msc:=`select count(swch_area_id) from SWCH_ID_LD_CD  where swch_area_id=?
	str_to_date(?, '%Y%m%d%H') <expired_tm  
	and  str_to_date(?, '%Y%m%d%H') > effc_tm ) `

	//
	rows_imsi,_ := db.Query(sql_imsi,mobile_number,mobile_number,start_tm,start_tm,start_tm,start_tm,start_tm,start_tm) 
	rows_unicom,_:= db.Query(sql_unicom,mobile_number,mobile_number,start_tm,start_tm,start_tm,start_tm,start_tm,start_tm) 
	rows_sp ,_ := db.Query(sql_SP,start_tm,start_tm,mobile_number)
	rows_area ,_ := db.Query(sql_area,mobile_number,start_tm,start_tm)
	rows_Msc ,_ := db.Query(sql_Msc,mobile_number,start_tm,start_tm)


	var msisdn_area_id string
    rows_imsi.Next()	    
	rows_imsi.Scan(&msisdn_area_id)
    
	var carrier_type  string
	rows_unicom.Next()
	rows_unicom.Scan(&carrier_type)
	var sp_int  string
    rows_sp.Next()
    rows_sp.Scan(&sp_int)
	
	var ld_area_cd  string
	rows_area.Next()
	rows_area.Scan(&ld_area_cd)

	var swch_area_id  string
	rows_Msc.Next()
	rows_Msc.Scan(&swch_area_id)

	yidong,_:=strconv.Atoi(msisdn_area_id)	
	liantong,_:=strconv.Atoi(carrier_type)
	sp,_:=strconv.Atoi(sp_int)
	area_code,_:=strconv.Atoi(ld_area_cd)
	switch_code,_:=strconv.Atoi(swch_area_id)
	
	if yidong  >0{
		result="yidong"
		num="1"
	}else if liantong >0 {
		result="liantong"
		num="1"
	}else if sp>0 {
		result="sp"
		num="1"
	}else if area_code>0 {
		num="1"
		result="area_code"
	}else if switch_code>0 {
		num="1"
		result="swich_code"
	}else {
	 	num="0"
	 	result="feifa"
	}
	 //db.Close()
	return 
}

func main(){
mysql("13267239916", "20190519110016" )
}

