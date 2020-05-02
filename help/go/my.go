package main

import (
	"fmt"
	"os"
	"strings"
)
var wiki map[string]string
var wiki_list []string
func main() {
	wiki=make(map[string]string)
	wiki["go-strings"]=`
	a = "123456" //"strconv"
	b,_ := strconv.Atoi(a)
	var c int = 1234
	d := strconv.Itoa(c)

	fmt.Println(strings.Contains(\"seafood\", \"foo\")) //true
    fmt.Println(strings.Contains(\"seafood\", \"bar\")) //false
    fmt.Println(strings.Contains(\"seafood\", \"\"))//true
    fmt.Println(strings.Contains(\"\", \"\")) //true

    s := string\"foo\", \"bar\", \"baz\"
    fmt.Println(strings.Join(s, \", \"))
    //运行结果:foo, bar, baz

    fmt.Println(strings.Index(\"chicken\", \"ken\")) //4
    fmt.Println(strings.Index(\"chicken\", \"dmr\")) //-1
    功能：在字符串s中查找sep所在的位置，返回位置值，找不到返回-1

    fmt.Println(\"ba\" + strings.Repeat(\"na\", 2))
    //运行结果:banana

    fmt.Println(strings.Replace(\"oink oink oink\", \"k\", \"ky\", 2))
    fmt.Println(strings.Replace(\"oink oink oink\", \"oink\", \"moo\", -1))
    //运行结果:
    //oinky oinky oink
    //moo moo moo`
	wiki[`一期awk`]=`#9是呼叫类型，61是错误码
awk -F'|' '{if($3=="VLTCG33_GZVOLTEAS121_H_190101_20190519121752_01348422.dat")print $3,$9,$61}'  201908_200_err.csv
#把err文件的话单从跑
for i in $(awk -F'|' '{a[$1]++}END{for(i in a){print i}}' err_200.csv) ;do hadoop fs -cp /vltdat/200/$i /vlt/src/200/;echo $i; done
awk -F'|' '{print $47}' //拜访信息字段`
	
	
	////////////////////////////////////////////////////
	wiki_list=make([]string,len(wiki))
	i:=0
	if len(os.Args) != 2 {

		for j,_:=range wiki{
			i++
			wiki_list[i-1]= j
		}
	fmt.Println("./my + 下面的关键字")	
	fmt.Println(wiki_list)
    os.Exit(0)

    }else{
		for j,_:=range wiki{
			if strings.Contains(j,os.Args[1]) {
				fmt.Println(wiki[j])
			}
		}

	}	
}
