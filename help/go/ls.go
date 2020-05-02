package main

import (
    "io/ioutil"
    "os"
    "fmt"
)

func main() {
    if len(os.Args) != 2 {
        fmt.Println("错误,参数不足")
        return
    }
    targetDirPath := os.Args[1]
    if dirList, err := ioutil.ReadDir(targetDirPath); err == nil {
        for _, dirInfo := range dirList {
            fmt.Println(dirInfo.Name())
        }
    } else {
        fmt.Println(err.Error())
    }

}
