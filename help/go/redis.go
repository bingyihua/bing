package main

import (
	"fmt"
	"github.com/gomodule/redigo/redis"
)

func main() {
	c, err := redis.Dial("tcp", "127.0.0.1:6379")
	if err != nil {
		fmt.Println("conn redis failed,", err)
		return
	}
	/*if _, err := c.Do("AUTH", "abc@123A"); err != nil {
		c.Close()
		fmt.Println(err)
		return
	}	*/

	defer c.Close()
	_, err = c.Do("Set", "aaa", 100)
	if err != nil {
		fmt.Println(err)
		return
	}
	_, err = c.Do("lpush", "key1", "aaaa")
	if err != nil {
		fmt.Println("get abc failed,", err)
		return
	}
	a, _ := redis.Values(c.Do("lrange", "MCBDBA.DOM_SPE_SVC_NR", 0, -1))
	for _, v := range a {
		fmt.Println(string(v.([]byte)))
	}
	// lset key1 2 "dddd" 修改下标为2的list的值为dddd
	//lrem key1 2  删除下标为2的值，删除后，其他下标会移位已删除的下标
}
