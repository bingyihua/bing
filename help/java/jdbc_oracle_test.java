package xue_xi;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class jdbc_oracle_test {
    public static void main(String[] args) throws SQLException, ClassNotFoundException, FileNotFoundException {
        //声明Connection对象
        Connection con;
        //驱动程序名
        String driver = "oracle.jdbc.OracleDriver";
        //URL指向要访问的数据库名mydata
        String url = "jdbc:oracle:thin:@192.168.56.156:1521:helowin";
        //MySQL配置时的用户名
        String user = "scott";
        //MySQL配置时的密码
        String password = "tiger";
         List<String> list = new ArrayList<String>();
        //遍历查询结果集    
            //加载驱动程序   
            Class.forName(driver);
            //1.getConnection()方法，连接MySQL数据库！！
            con = DriverManager.getConnection(url,user,password);
            System.out.println("成功连接数据库22");
            Statement stmt = con.createStatement();
            String sql = "select * from emp ";
            ResultSet rs = stmt.executeQuery(sql);
            //2.创建statement类对象，用来执行SQL语句！！
            FileOutputStream fos = new FileOutputStream("ok.txt",true);
            PrintStream p = new PrintStream(fos);
            //3.ResultSet类，用来存放获取的结果集！！

            while(rs.next()){
            	System.out.println(rs.getString(2) );
            	String sb = rs.getString(2)  ;
            	p.println(sb);
            	if(con.isClosed())
               System.out.println("Succeeded connecting to the Database!");
            }
    
    }
}
