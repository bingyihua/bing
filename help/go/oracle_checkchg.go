package main

import (
    "database/sql"
    "fmt"
    _  "github.com/mattn/go-oci8"
)

func chg(str string)(chg_res int) {

    db, err := sql.Open("oci8", "vltdba/HyxtTest_9@vlt")
    if err != nil {
        panic(err)
    }
    defer db.Close()

    rows, err := db.Query("select * from dual")
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
func main() {
}
