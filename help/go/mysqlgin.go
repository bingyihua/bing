package main

import (
    "fmt"
    "github.com/gin-gonic/gin"
    "github.com/jinzhu/gorm"
    _ "github.com/jinzhu/gorm/dialects/sqlite"
	 _ "github.com/jinzhu/gorm/dialects/mysql"
)

var db *gorm.DB
var err error

type IMSI_LD_cd struct {
    ID        uint   `json:"id”`
    Imsi_area_id string `json:"firstname”`
    //LastName  string `json:"lastname”`
}

func main() {
    // NOTE: See we’re using = to assign the global var
    // instead of := which would assign it only in this function
	db, err = gorm.Open("mysql", "mcbdba:lte#4ossbg@tcp(192.168.158.172:8058)/mcbdba?charset=utf8")
    if err != nil {
        fmt.Println(err)
    }
    defer db.Close()
    db.AutoMigrate(&IMSI_LD_cd{})
    r := gin.Default()

    r.GET("/", GetProjects)
    r.GET("/people/:id", GetIMSI_LD_cd)

    r.Run(":10086")
}

func GetProjects(c *gin.Context) {
    var people []IMSI_LD_cd
    if err := db.Find(&people).Error; err != nil {
        c.AbortWithStatus(404)
        fmt.Println(err)
    } else {
        c.JSON(200, people)
    }
}

func GetPerson(c *gin.Context) {
    id := c.Params.ByName("id")
    var IMSI_LD_cd IMSI_LD_CD
    if err := db.Where("imsi_area_id = ?", id).First(&IMSI_LD_cd).Error; err != nil {
        c.AbortWithStatus(404)
        fmt.Println(err)
    } else {
        c.JSON(200, IMSI_LD_cd)
    }

}
