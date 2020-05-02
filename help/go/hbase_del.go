package main
import (
_	"bytes"
 _ "os/exec"
	"os"
	 "path/filepath"
        "context"
        "fmt"
		"time"
		"strconv"
		"strings"
    _    "github.com/tsuna/gohbase/filter"
        "github.com/tsuna/gohbase"
        "github.com/tsuna/gohbase/hrpc"
		"github.com/tsuna/gohbase/pb"
		 "database/sql"
		 _ "mysql"
		   "bytes"
		     "os/exec"
)
var client gohbase.Client
func init(){
    client = gohbase.NewClient("192.168.158.172:2181")
}

func hbase_del(tab_nm string,ic_file_nm string){
	os.Remove(ic_file_nm)
 //   client := gohbase.NewClient("192.168.158.172:2181")
    scanRequest,_ := hrpc.NewScanStr(context.Background(), tab_nm)
    scanres  := client.Scan(scanRequest)
	if tab_nm!="vlthb:CDR_DUPCHK"{
        for {
			res, _ := scanres.Next()
			if res != nil {
				var rsp [71] string
				var row_key string
            	for _, cell := range res.Cells{
            		//获取列的值c15 并截取数字 转为int类型
            		nu,_ := strconv.Atoi(string((*pb.Cell)(cell).GetQualifier())[1:])
            		rsp[nu]=string((*pb.Cell)(cell).GetValue())
					row_key=string((*pb.Cell)(cell).GetRow())
            	}
				rsp[0]=row_key
        		if rsp[2]==ic_file_nm{
					rowkey:=rsp[0]
            		deleteRequest, _:= hrpc.NewDelStr(context.Background(), tab_nm, rowkey, nil)
					client.Delete(deleteRequest)
					fmt.Println("delete" + rowkey  )
        		}
			}
		
			if res == nil {
				break
			}
	
		}	
	}else{
		for {
            res, _ := scanres.Next()
            if res != nil {
            	for _, cell := range res.Cells{
					rowkey:=string((*pb.Cell)(cell).GetRow())
					deleteRequest, _:= hrpc.NewDelStr(context.Background(), tab_nm, rowkey, nil)
					client.Delete(deleteRequest)
				}
			}
			if res == nil {
            	break
        	}
		}
	}	
}

func delalltables (dat_name string) {
	month:= time.Now().Format("200601")
	prov:=map[string]string{"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250","11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771","21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991","31":"230"}
    //dat_name=os.Args[1]
    provnum:=strings.Split(dat_name, "_")[3][0:2]
	//fmt.Println(provnum)
    prov_cd:=prov[provnum]
	cdr_table:="vlthb:PRE_MERGE_CDR_VLT_HM_"+month+"_"+prov_cd
	err_table:="vlthb:ERR_CDR_VLT_"+month+"_"+prov_cd
	hr_table:="vlthb:PRE_MERGE_CDR_VLT_BR_"+month
	duk_table:="vlthb:CDR_DUPCHK"
	hbase_del(cdr_table ,dat_name)
	hbase_del(err_table ,dat_name)
	hbase_del(hr_table ,dat_name)
	hbase_del(duk_table ,dat_name)
}
const ShellToUse = "bash"
func shell_cmd(command string) (error, string, string) {
    var stdout bytes.Buffer
    var stderr bytes.Buffer
    cmd := exec.Command(ShellToUse, "-c", command)
    cmd.Stdout = &stdout
    cmd.Stderr = &stderr
    err := cmd.Run()
    return err, stdout.String(), stderr.String()
}

func delmysql(dat_name string){
	//var db = &sql.DB{}
	db,_ := sql.Open("mysql", "vltdba:lte#4ossbg@tcp(192.168.158.172:8058)/vlt?charset=utf8")
	res_sql:="select count(ic_file_nm) from FILE_PROC_STATE where ic_file_nm="+"'"+dat_name+"'"

	rows_res ,_ := db.Query(res_sql)
	var res int
	rows_res.Next()
	rows_res.Scan(&res)
	fmt.Println(res_sql)
	fmt.Println(res)
	if res > 0{
		mysql_cli:="\"|mysql -uvltdba -plte#4ossbg -h192.168.158.172 -P8058 vlt"
    	resv_sql:="select ic_merge_file_nm from FILE_PROC_STATE where ic_file_nm="+"'"+dat_name+"'"
    	bbb:="echo \""+resv_sql+mysql_cli+"|grep VLT"
    	_,merge_nm,_:=shell_cmd(bbb)
    	del_IC_FILE_AUDIT_sql:="delete  from IC_FILE_AUDIT  where ic_merge_file_nm="+"'"+merge_nm+"';commit;"
    	del_MERGE_FILE_AUDIT_sql:="delete  from MERGE_FILE_AUDIT where ic_file_nm="+"'"+dat_name+"';commit;"
    	del_PRE_MERGE_FILE_AUDIT_sql:="delete  from PRE_MERGE_FILE_AUDIT where ic_merge_file_nm="+"'"+merge_nm+"';commit;"
    	del_PRE_MERGE_FILE_AUDIT_BR_sql:="delete  from PRE_MERGE_FILE_AUDIT_BR  where ic_merge_file_nm="+"'"+merge_nm+"';commit;"
    	del_FILE_PROC_STATE_sql:="delete  from FILE_PROC_STATE  where  ic_file_nm="+"'"+dat_name+"';commit;"
		
		shell_cmd("echo \""+del_FILE_PROC_STATE_sql+mysql_cli)
		shell_cmd("echo \""+del_IC_FILE_AUDIT_sql+mysql_cli)
		shell_cmd("echo \""+del_MERGE_FILE_AUDIT_sql+mysql_cli)
		shell_cmd("echo \""+del_PRE_MERGE_FILE_AUDIT_sql+mysql_cli)
		shell_cmd("echo \""+del_PRE_MERGE_FILE_AUDIT_BR_sql+mysql_cli)
		shell_cmd("echo \""+del_FILE_PROC_STATE_sql+mysql_cli)
		shell_cmd("clear")
		fmt.Println("mysql和hbase" +dat_name+"数据已删除成功")
		fmt.Println("mysql和hbase数据删除成功")
		prov:=map[string]string{"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250","11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771","21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991","31":"230"}
    //dat_name=os.Args[1]
    	provnum:=strings.Split(dat_name, "_")[3][0:2]
		prov_cd:=prov[provnum]
		fmt.Println("执行下面命令重跑话单：")
		fmt.Println("hadoop fs -cp /vltdat/" +prov_cd+"/"+dat_name + " /vlt/src/"+prov_cd)
	
	}else{
		db.Close()
		shell_cmd("clear;")

		fmt.Println("mysql没有对应dat的数据")
		prov:=map[string]string{"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250","11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771","21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991","31":"230"}
    //dat_name=os.Args[1]
        provnum:=strings.Split(dat_name, "_")[3][0:2]
        prov_cd:=prov[provnum]
        fmt.Println("执行下面命令重跑话单：")
        fmt.Println("hadoop fs -cp /vltdat/" +prov_cd+"/"+dat_name + " /vlt/src/"+prov_cd)
	}
	
}
func main() {
	if len(os.Args) == 1 {
         files := os.Args[0]
             _, fileName := filepath.Split(files)
			 
             fmt.Println("./"+ fileName +" ic_file_nm")
    os.Exit(0)
    }else{
		dat_name:=os.Args[1]
		delalltables(dat_name)
		delmysql(dat_name)
	}
}

