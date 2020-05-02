package main
import (
	"bytes"
  "os/exec"
	"os"
	 "path/filepath"
        "context"
        "fmt"
		"strconv"
		"strings"
    _    "github.com/tsuna/gohbase/filter"
        "github.com/tsuna/gohbase"
        "github.com/tsuna/gohbase/hrpc"
		"github.com/tsuna/gohbase/pb"
)

const ShellToUse = "bash"
func Shellout(command string) (error, string, string) {
	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd := exec.Command(ShellToUse, "-c", command)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	err := cmd.Run()
	return err, stdout.String(), stderr.String()
}

func tracefile(str_content string,name string)  {
	fd,_:=os.OpenFile(name,os.O_RDWR|os.O_CREATE|os.O_APPEND,0644)
	fd_content:=strings.Join([]string{str_content},"")
	buf:=[]byte(fd_content)
	fd.Write(buf)
	fd.Close()
}
var client gohbase.Client
func init(){
        client = gohbase.NewClient("192.168.158.172:2181")
}
func hbase_exp( num int,tab_nm string,file_nm string){
	os.Remove(file_nm)
//	var rsp_list [140] string
//	var rsp [] string = rsp_list[:num]  
 //   client := gohbase.NewClient("192.168.158.172:2181")
    scanRequest,err := hrpc.NewScanStr(context.Background(), tab_nm)
    if err != nil {
            fmt.Println("mei you zhe zhang biao !")
                }
    scanres  := client.Scan(scanRequest)
        for {
            res, err := scanres.Next()

            if err != nil {
                fmt.Println("hahah")
			}
			 if res != nil {
			var rsp_list [140] string
			var rsp [] string = rsp_list[:num+1]
			var row_key string

            for _, cell := range res.Cells{
            //获取列的值c15 并截取数字 转为int类型
            nu,_ := strconv.Atoi(string((*pb.Cell)(cell).GetQualifier())[1:])
			//fmt.Println(nu)
			//fmt.Println(strconv.Atoi(string((*pb.Cell)(cell).GetQualifier())))
			//fmt.Println(string((*pb.Cell)(cell).GetRow()))
            rsp[nu]=string((*pb.Cell)(cell).GetValue())
			row_key=string((*pb.Cell)(cell).GetRow())
            }
			//fmt.Println(row_key)
			rsp[0]=row_key
			aa:=strings.Join(rsp[:],"|")
            tracefile(aa+"\n",file_nm)
		}
		if res == nil {
			break
		}

        }
    }

func main() {
  if len(os.Args) == 1 {
         files := os.Args[0]
             _, fileName := filepath.Split(files)
			 fmt.Println("hbase_exp_tools ")
			 fmt.Println("example: ./"+ fileName + " 201907 571 err  //exp err to csv file")
			 fmt.Println("example: ./"+ fileName + " 201907 571 cdr  //exp cdr to csv file")
			 fmt.Println("example: ./"+ fileName + " 201907  hr  //exp hr to csv file")			 
	os.Exit(0)

	}


	if len(os.Args)==3 {
		num:=61
    	file_nm :=os.Args[1]+"_"+os.Args[2]+".csv"
		tab_nm :="vlthb:PRE_MERGE_CDR_VLT_BR_"+os.Args[1]
    	hbase_exp(num,tab_nm,file_nm)
		 _, out,_ :=Shellout("clear;echo -n \"[info]:hbase exp totel is \""+";wc -l "+file_nm)
		 fmt.Println(out)
	}
	if len(os.Args)==4{	
		var tab_nm string
		switch os.Args[3] {
    	case "err":
			num:=70
			file_nm :=os.Args[1]+"_"+os.Args[2]+"_"+os.Args[3]+".csv"
			tab_nm ="vlthb:ERR_CDR_VLT_"+os.Args[1]+"_"+os.Args[2]
			hbase_exp(num,tab_nm,file_nm)
			_, out,_ :=Shellout("clear;echo -n \"[info]:hbase exp totel is \""+";wc -l "+file_nm)
			fmt.Println(out)
    	case "cdr":
			num:=61
			file_nm :=os.Args[1]+"_"+os.Args[2]+"_"+os.Args[3]+".csv"
			tab_nm ="vlthb:PRE_MERGE_CDR_VLT_HM_"+os.Args[1]+"_"+os.Args[2]
			hbase_exp(num,tab_nm,file_nm)
			_, out,_ :=Shellout("clear;echo -n \"[info]:hbase exp totel is \""+";wc -l "+file_nm)
			fmt.Println(out)
    	default:
		
			fmt.Println("args is bad;"+"example: ./"+ "hbase_exp" + " 201907  hr")
		}	
	}

}
