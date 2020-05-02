package main

import (
    "database/sql"
    "fmt"
    _  "github.com/mattn/go-oci8"
)

var db *sql.DB
var  err  error
func init() {
    db, err = sql.Open("oci8", "mcbdba/HyxtTest_9@vlt")
    if err != nil {
        panic(err)
    }
}
func main() {
 /*   db, err := sql.Open("oci8", "mcbdba/HyxtTest_9@vlt")
    if err != nil {
        panic(err)
    }*/
    defer db.Close()
	num:="132"
	rows, err := db.Query(`select CARRIER_TYPE FROM MCBDBA.DOM_NUM_PREFIX WHERE NUM_PREFIX=:1`,num)
    if err != nil {
        panic(err)
    }
    defer rows.Close()

    dummy := ""
    for rows.Next() {
        if err = rows.Scan(&dummy); err != nil {
            panic(err)
        }
        fmt.Println(dummy)
    }
}
