package main

import (
	"fmt"
	"strings"
)

func main() {
	str := "3GPP-E-UTRAN;utran-cell-id-3gpp=46000571D927F983;sbc-domain=sbc10.0571.013.zj.chinamobile.com;ue-ip=[2409:8805:85E1:F3B2:B56E:6DF4:18C5:169B"
	a:=strings.Index(str, "46000")
	c:=str[a:][5:9]   
	d:=str[a:][9:16]
	e:=strings.Split(str, "=")[2]
	f:=strings.Split(e, ".")[1]
	fmt.Println(c,d,f)
}
