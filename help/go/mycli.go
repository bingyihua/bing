package main
 
import (
	"fmt"
	"os"
 
	"github.com/spf13/cobra"
)
var jiuqi_err_csv string
var yiqi_err_csv string
 
var RootCmd = &cobra.Command{
	Use:   "help",
	Short: "",
	Long:  `
example: Compare_Volte_Errcd -j err_200.csv -y 201908_200_err.csv`,
	Run: func(cmd *cobra.Command, args []string) {
		if len(jiuqi_err_csv) == 0 {
			fmt.Println("参数不能为空，-h 获取帮助")
			return
		}
		Show(jiuqi_err_csv, yiqi_err_csv)
	},
}
 
func Execute() {
	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}
 
func init() {
	RootCmd.Flags().StringVarP(&jiuqi_err_csv, "jiuqi_err_csv", "j", "", "输入话音9期vlt的错单csv文件名")
	RootCmd.Flags().StringVarP(&yiqi_err_csv, "yiqi_err_csv", "y", "", "输入1期结算vlt的错单csv文件名")
}
func main() {
	Execute()
}
func Show(jiuqi_err_csv string, yiqi_err_csv string) {
	fmt.Printf("My Name is %s, My age is %d\n", jiuqi_err_csv, yiqi_err_csv)
}

