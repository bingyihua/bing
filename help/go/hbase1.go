package main

import (

//"github.com/sirupsen/logrus"
//"os"
"github.com/tsuna/gohbase"
"github.com/tsuna/gohbase/hrpc"
"context"
"fmt"
"github.com/tsuna/gohbase/pb"
)

//func init() {
//logrus.SetOutput(os.Stdout)

//logrus.SetLevel(logrus.DebugLevel)
//}

func main() {

client := gohbase.NewClient("192.168.158.172")

getRequest, _ := hrpc.NewGetStr(context.Background(), "vlthb:PRE_MERGE_CDR_VLT_HM_201907_551", "03117VLT_MERGE_20190714_551_100000299172")
getRsp, _ := client.Get(getRequest)

for _, cell := range getRsp.Cells{
fmt.Println(string((*pb.Cell)(cell).GetFamily()))
fmt.Println(string((*pb.Cell)(cell).GetQualifier()))
fmt.Println(string((*pb.Cell)(cell).GetValue()))
fmt.Println((*pb.Cell)(cell).GetTimestamp())
}

}

