package main
import (
	"github.com/jinzhu/gorm"
	      
	 _ "github.com/jinzhu/gorm/dialects/mysql"
	"os"
	 "path/filepath"
        "context"
        "fmt"
		"time"
    _    "github.com/tsuna/gohbase/filter"
        "github.com/tsuna/gohbase"
        "github.com/tsuna/gohbase/hrpc"
		"github.com/tsuna/gohbase/pb"
)

var client gohbase.Client
func init(){
	client = gohbase.NewClient("192.168.158.172:2181")
}
func hbase_del(tab_nm  string){
	//os.Remove(ic_file_nm)
    //client := gohbase.NewClient("192.168.158.172:2181")
    scanRequest,_ := hrpc.NewScanStr(context.Background(), tab_nm)
	fmt.Println(tab_nm)
    scanres  := client.Scan(scanRequest)
    for {
		res, _ := scanres.Next()
		if res != nil {
			var row_key string
            for _, cell := range res.Cells{
				row_key=string((*pb.Cell)(cell).GetRow())
			//	fmt.Println(row_key)
			//	deleteRequest, _:= hrpc.NewDelStr(context.Background(), tab_nm, row_key, nil)
			//	client.Delete(deleteRequest)
			}
			fmt.Println(row_key)
			deleteRequest, _:= hrpc.NewDelStr(context.Background(), tab_nm, row_key, nil)
			client.Delete(deleteRequest)
		}
		
		if res == nil {
			break
		}
	
	}
}

func delalltables (prov_cd string) {
	month:= time.Now().Format("200601")
    //dat_name=os.Args[1]
	//fmt.Println(provnum)
	cdr_table:="vlthb:PRE_MERGE_CDR_VLT_HM_"+month+"_"+prov_cd
	err_table:="vlthb:ERR_CDR_VLT_"+month+"_"+prov_cd
	hr_table:="vlthb:PRE_MERGE_CDR_VLT_BR_"+month
	duk_table:="vlthb:CDR_DUPCHK"
	hbase_del(cdr_table )
	hbase_del(err_table )
	hbase_del(hr_table )
	hbase_del(duk_table)
}

type FILE_PROC_STATE struct {
	Ic_file_nm string 	
}
func (f *FILE_PROC_STATE) TableName() string {
	 return "FILE_PROC_STATE"
}

func main() {
	if len(os.Args) == 1 {
         files := os.Args[0]
             _, fileName := filepath.Split(files)
			 
             fmt.Println("./"+ fileName +"prov_cd")
    os.Exit(0)
    }else{
		prov_cd:=os.Args[1]
		delalltables(prov_cd)
		db, _:= gorm.Open("mysql", "vltdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8")
		//defer db.Close()
		var ww FILE_PROC_STATE
		db.Where(&ww).Delete(&ww)
		db.Raw("TRUNCATE table FILE_PROC_STATE")
	}
}

