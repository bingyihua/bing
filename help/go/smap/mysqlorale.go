package smap

import (
	"database/sql"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/mattn/go-oci8"
	"regexp"
	"strings"
	"time"
)

var odb *sql.DB
var err error
var mdb *gorm.DB

func init() {
	odb, err = sql.Open("oci8", "mcbdba/HyxtTest_9@vlt")
	if err != nil {
		panic(err)
	}
	mdb, _ = gorm.Open("mysql", "mcbdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8")
	mdb.DB().SetMaxIdleConns(10)                   //连接池中最大空闲连接数
	mdb.DB().SetMaxOpenConns(20)                   //打开的最大连接数
	mdb.DB().SetConnMaxLifetime(300 * time.Second) //连接的最大空闲时间(可选)
}

//defer db.Close()
func odbcheck(errcd, starttm, number string) string {
	res := 0
	CARRIER_TYPE := 0
	var result string
	switch errcd {
	case "F093", "F092", "F091", "F071", "F072":
		odb.QueryRow(`select CARRIER_TYPE FROM MCBDBA.DOM_NUM_PREFIX WHERE NUM_PREFIX=substr(:1,0,3)`, number).Scan(&CARRIER_TYPE)
		//fmt.Println(CARRIER_TYPE,number[0:3])
		if CARRIER_TYPE == 0 {
			result = "false"
		} else if CARRIER_TYPE == 1 {
			odb.QueryRow(`SELECT count(*) from IMSI_LD_CD a INNER JOIN DOM_LD_AREA_CD_PROV_EXT b  ON a.LD_AREA_CD=b.LD_AREA_CD and a.MSISDN_AREA_ID=substr(:1,0,7) and a.EFFC_TM <   to_date(:2,'yyyy-mm-dd hh24:mi:ss') and a.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss') and  b.EFFC_TM < to_date(:2,'yyyy-mm-dd hh24:mi:ss') and b.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss')`, number, starttm).Scan(&res)
			if res == 0 {
				result = "false1"
				//fmt.Println(number+"九期移动号码公参校验无效")
			} else {
				result = "true1"
				//fmt.Println(number+"九期移动号码公参校验有效")
			}
		} else if CARRIER_TYPE == 2 || CARRIER_TYPE == 3 || CARRIER_TYPE == 4 || CARRIER_TYPE == 5 {
			odb.QueryRow(`SELECT count(*) from UNICOM_MSISDN_LD_CD a INNER JOIN DOM_LD_AREA_CD_PROV_EXT b  ON a.LD_AREA_CD=b.LD_AREA_CD and a.MSISDN_AREA_ID=substr(:1,0,7) and a.EFFC_TM <   to_date(:2,'yyyy-mm-dd hh24:mi:ss') and a.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss') and  b.EFFC_TM < to_date(:2,'yyyy-mm-dd hh24:mi:ss') and b.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss')`, number, starttm).Scan(&res)
			//		fmt.Println(res)
			if res == 0 {
				result = "false2"
				//fmt.Println(number+"九期非移动号码公参校验无效")
			} else {
				result = "true2"
				//fmt.Println(number+"九期非移动号码公参校验有效")
			}
		}

	case "F371":
		odb.QueryRow(`SELECT count(*) from SWCH_ID_LD_CD a INNER JOIN DOM_LD_AREA_CD_PROV_EXT b  ON a.LD_AREA_CD=b.LD_AREA_CD and a.SWCH_AREA_ID=substr(:1,2,8) and a.EFFC_TM <   to_date(:2,'yyyy-mm-dd hh24:mi:ss') and a.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss') and  b.EFFC_TM < to_date(:2,'yyyy-mm-dd hh24:mi:ss') and b.EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss')`, number, starttm).Scan(&res)
		if res == 0 {
			result = "false"
			//fmt.Println(number+"九期交换机公参校验无效")
		} else {
			result = "true"
			//fmt.Println(number+"九期交换机公参校验有效")
		}
	case "F351":
		var res int = 0
		str_dom := regexp.MustCompile(`sbc-domain=.[^;]+`).FindString(number)
		Area_code := strings.Split(str_dom, ".")[1]
		odb.QueryRow(`SELECT count(*) from DOM_LD_AREA_CD_PROV_EXT where ld_area_cd=:1 and  EFFC_TM < to_date(:2,'yyyy-mm-dd hh24:mi:ss') and EXPIRED_TM > to_date(:2,'yyyy-mm-dd hh24:mi:ss')`, Area_code, starttm).Scan(&res)
		if res == 0 {
			result = "false"
			// fmt.Println(Area_code+"九期交换机公参校验无效")
		} else {
			result = "true"
			//   fmt.Println(Area_code+"九期交换机公参校验有效")
		}
	default:
		result = ""
	}
	return result
}

type DOM_NUM_PREFIX struct {
	Num_prefix string `json:"firstname"`
	//Msisdn_area_id string
	Carrier_type string
}

func (d *DOM_NUM_PREFIX) TableName() string {
	return "DOM_NUM_PREFIX"
}
func mdbcheck(errcd, starttm, number string) string {

	var result string
	switch errcd {
	case "F093", "F092", "F091", "F071", "F072":
		var r DOM_NUM_PREFIX
		mdb.Select("carrier_type").Where("num_prefix =substr(?,1,3)", number).First(&r)
		CarrierType := r.Carrier_type
		//	fmt.Println(CarrierType)
		if CarrierType == "1" {
			var res int = 0
			mdb.Table("IMSI_LD_CD").Joins(" INNER JOIN DOM_LD_AREA_CD_PROV_EXT ON IMSI_LD_CD.ld_area_cd = DOM_LD_AREA_CD_PROV_EXT.ld_area_cd ").Where("IMSI_LD_CD.msisdn_area_id = ? and IMSI_LD_CD.effc_tm < str_to_date(?, '%Y%m%d%H')  and IMSI_LD_CD.expired_tm > str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.effc_tm < str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.expired_tm > str_to_date(?, '%Y%m%d%H')", number, starttm, starttm, starttm, starttm).Count(&res)
			//		fmt.Println("yidong",res)
			if res == 0 {
				result = "false1"
				//fmt.Println(number+"一期移动号码公参校验无效")
			} else {
				result = "true1"
				//fmt.Println(number+"一期移动号码公参校验有效")
			}

		} else if CarrierType != "1" && CarrierType != "0" {
			var res int = 0
			mdb.Table("UNICOM_MSISDN_LD_CD").Joins(" INNER JOIN DOM_LD_AREA_CD_PROV_EXT ON UNICOM_MSISDN_LD_CD.ld_area_cd = DOM_LD_AREA_CD_PROV_EXT.ld_area_cd ").Where("UNICOM_MSISDN_LD_CD.msisdn_area_id = ? and UNICOM_MSISDN_LD_CD.effc_tm < str_to_date(?, '%Y%m%d%H')  and UNICOM_MSISDN_LD_CD.expired_tm > str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.effc_tm < str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.expired_tm > str_to_date(?, '%Y%m%d%H')", number, starttm, starttm, starttm, starttm).Count(&res)
			//		fmt.Println("liantong",res)
			if res == 0 {
				result = "false2"
				//fmt.Println(number+"一期非移动号码公参校验无效")
			} else {
				result = "true2"
				//fmt.Println(number+"一期非移动号码公参校验有效")
			}
		} else {
			result = "false"
		}
	case "F371":
		var res int = 0
		mdb.Table("SWCH_ID_LD_CD").Joins(" INNER JOIN DOM_LD_AREA_CD_PROV_EXT ON SWCH_ID_LD_CD.ld_area_cd = DOM_LD_AREA_CD_PROV_EXT.ld_area_cd ").Where("SWCH_ID_LD_CD.swch_area_id = substr(?,3,10) and SWCH_ID_LD_CD.effc_tm < str_to_date(?, '%Y%m%d%H')  and SWCH_ID_LD_CD.expired_tm > str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.effc_tm < str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.expired_tm > str_to_date(?, '%Y%m%d%H')", number, starttm, starttm, starttm, starttm).Count(&res)
		//fmt.Println(res)
		if res == 0 {
			result = "false"
			//fmt.Println(number+"一期交换机公参校验无效")
		} else {
			result = "true"
			//fmt.Println(number+"一期交换机公参校验有效")
		}
	case "F351":
		var res int = 0
		str_dom := regexp.MustCompile(`sbc-domain=.[^;]+`).FindString(number)
		Area_code := strings.Split(str_dom, ".")[1]
		//fmt.Println(Area_code)
		mdb.Table("DOM_LD_AREA_CD_PROV_EXT").Where("DOM_LD_AREA_CD_PROV_EXT.LD_AREA_CD =? and DOM_LD_AREA_CD_PROV_EXT.effc_tm < str_to_date(?, '%Y%m%d%H') AND DOM_LD_AREA_CD_PROV_EXT.expired_tm > str_to_date(?, '%Y%m%d%H')", Area_code, starttm, starttm).Count(&res)
		//fmt.Println(res)
		if res == 0 {
			result = "false"
			//fmt.Println(Area_code+"一期长途区号公参校验无效")
		} else {
			result = "true"
			//fmt.Println(Area_code+"一期长途区号公参校验有效")
		}
	default:
		result = ""
	}
	return result
}

/*
func main() {
	defer odb.Close()
	fmt.Println(odbcheck("F093","20190217","13267239916" ))
	fmt.Println(odbcheck("F351","20190511","3GPP-E-UTRAN;utran-cell-id-3gpp=46000570BB96D301;sbc-domain=SBC4.0570.001.zj.chinamobile.com;ue-ip=[2409:8805:8341:D2B7:1:1:B8B9:3240];ue-port=50046;network-provided" ))

}*/
