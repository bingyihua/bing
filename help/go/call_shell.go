package main
import (
	    "fmt"
		"os/exec"
		)
func main(){
	command := "pwd"
	cmd := exec.Command("/bin/bash", "-c", command)
	bytes,err := cmd.Output()
	if err != nil {
		     fmt.Println(err)
		 }
	resp := string(bytes)
	fmt.Println(resp)
}
