package main
import (
	"fmt"
_	"unicode/utf8"
	"strings"
	)
func main() {
str1 := "see"
  byteS := []byte(str1)
  byteS[2] = 'a'
  fmt.Println(string(byteS))
  fmt.Println(strings.Contains("seafood", "foo"))
  //used strings pakage return bool,  must import it 
  fmt.Println(strings.ContainsAny("team", "i"))              //false
  fmt.Println(strings.ContainsAny("failure", "u & i"))       //true
  fmt.Println(strings.ContainsAny("in failure", "s g"))      //true
  fmt.Println(strings.ContainsAny("foo", ""))                //false
  fmt.Println(strings.ContainsAny("", ""))                   //false
  ////join///
  s := []string{"foo", "bar", "baz"}
  fmt.Println(strings.Join(s, ", "))
  ///if func findout the str  return index,else return -1///
  fmt.Println(strings.Index("chicken", "ken"))
  fmt.Println(strings.Index("chicken", "dmr"))

  fmt.Println("ba" + strings.Repeat("na", 2))
  ///result : banana

  fmt.Println(strings.Replace("oink oink oink", "k", "ky", 2))
  //func Replace(s, old, new string, n int) string
  //n is replace counts  ,result:oinky oinky oink
  //if n <0  replace all
  
  fmt.Printf("%q\n", strings.Split("a,b,c", ","))
  fmt.Printf("%q\n", strings.Split("a man a plan a canal panama", "a "))
  //return list ,result://["a" "b" "c"] ["" "man " "plan " "canal panama"]

  fmt.Printf("[%q]", strings.Trim(" !!! Achtung !!! ", "! "))
  //result:["Achtung"]

  fmt.Printf("Fields are: %q", strings.Fields("  foo bar  baz   "))
  //result:Fields are: ["foo" "bar" "baz"]

  var slice_ []int = make([]int,5,10)
  fmt.Println(slice_)
  var m_ map[string]int = make(map[string]int)
  m_["one"] = 1
  fmt.Println(m_)

  var m map[string]int = map[string]int{"1":1}
  m["2"] = 2
  fmt.Println(m)
  
  //func of make ,use for only type of slice,map , chan  to init new obj  

  d := []string{"niubi", "for", "guanzhang, ", "job", "in", "ziguang"} 
  insertSlice := []string{"live", "in", "beatiful", "of", "hangzhoou, "} 
  insertSliceIndex := 3 
  d = append(d[:insertSliceIndex], append(insertSlice, d[insertSliceIndex:]...)...) 
  fmt.Println(d)
  a := [...]int{1, 2}
	fmt.Println(a)
  test3 := map[string]string{
	"one" : "php",
	"two" : "golang",
	"three" : "java",
	}
	fmt.Println(test3)
	v := [...]string{"123","123","444","44433"}
	v1 := []string{"123","123","ddd","dddd"}
	fmt.Println(v1[:2],v[2:3])
}
