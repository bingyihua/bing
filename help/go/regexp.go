package main

import
(	"regexp"
	"fmt"
)

func main() {
	str:="UTRAN;utran-cell-id=583B;sbc-dom=sbc11.153.004.zj.com;ue-ip=[2409:880593];ue-port=40575;network-provided ;"
                                                                   
	//fmt.Println(regexp.MustCompile(`sbc-dom=.*?;`).FindString(str))
	fmt.Println(regexp.MustCompile(`sbc-dom=.[^.]+`).FindString(str))
	fmt.Println(regexp.MustCompile(`\d{3,4}`).FindString(""))
	match, _ := regexp.MatchString(`\d{3,4}\.`,"s")
	fmt.Println(match)
}
