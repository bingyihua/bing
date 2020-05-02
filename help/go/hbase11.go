package main
import (
	"os"
        "context"
        "fmt"
		"strconv"
		"strings"
        "github.com/tsuna/gohbase/filter"
        "github.com/tsuna/gohbase"
        "github.com/tsuna/gohbase/hrpc"
		"github.com/tsuna/gohbase/pb"
)
func tracefile(str_content string)  {
	fd,_:=os.OpenFile("a.txt",os.O_RDWR|os.O_CREATE|os.O_APPEND,0644)
	fd_content:=strings.Join([]string{str_content},"")
	buf:=[]byte(fd_content)
	fd.Write(buf)
	fd.Close()
}
func main() {
	client := gohbase.NewClient("192.168.158.172:2181")
    pFilter := filter.NewPrefixFilter([]byte("0"))
	scanRequest,err := hrpc.NewScanStr(context.Background(), "vlthb:PRE_MERGE_CDR_VLT_HM_201907_551",hrpc.Filters(pFilter))
	var rsp [61]string
	if err != nil {
			fmt.Println("hahahhaha")
				}
	scanres  := client.Scan(scanRequest)
        for {
			res, err := scanres.Next()
			if res == nil {
							break
						}
			if err != nil {
				fmt.Println("heheheh")
				}
			
			for _, cell := range res.Cells{
			//获取列的值c15 并截取数字 转为int类型
			num,_ := strconv.Atoi(string((*pb.Cell)(cell).GetQualifier())[1:])
			
			rsp[num-1]=string((*pb.Cell)(cell).GetValue())
			}
			aa :=strings.Replace(strings.Trim(fmt.Sprint(rsp), "[]"), " ", "|", -1)
			fmt.Println(aa)

			tracefile(aa+"\n")
		
		}

}
