package main

import (
	"fmt"
	"bufio"
)

func readline_list  (file string ) ( file_list [] string){
    fi, err := os.Open(file)
    if err != nil {
        fmt.Printf("Error: %s\n", err)
       }

    br := bufio.NewReader(fi)
    for {
        line, _, c := br.ReadLine()
        if c == io.EOF {
            break
            }

         file_list = append(file_list,string(line))
        }
    fi.Close()
    return
}


func main() {
	fmt.Println("vim-go")
}
