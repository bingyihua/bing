package xue_xi;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class jdbc_oracle_save {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        //声明Connection对象
        Connection con;
        //驱动程序名
        String driver = "oracle.jdbc.OracleDriver";
        //URL指向要访问的数据库名mydata
        String url = "jdbc:oracle:thin:@192.168.56.156:1521:helowin";
        //MySQL配置时的用户名
        String user = "mcbdba";
        //MySQL配置时的密码
        String password = "HyxtTest_9";
         List<String> list = new ArrayList<String>();
        //遍历查询结果集    
            //加载驱动程序   
            Class.forName(driver);
            //1.getConnection()方法，连接MySQL数据库！！
            con = DriverManager.getConnection(url,user,password);
            System.out.println("成功连接数据库22");
            
            //2.创建statement类对象，用来执行SQL语句！！
            Statement statement = con.createStatement();
            //要执行的SQL语句
            String sql = "select * from DOM_SP_RATE_INFO";
            String sqlStr = "insert into student values(?,?,?,?,?)";
            //3.ResultSet类，用来存放获取的结果集！！
            int autoGeneratedKeys = 0;
	/*		PreparedStatement pstm = con.prepareStatement(sqlStr, autoGeneratedKeys);
            pstm.setString(1, "11");
            pstm.setString(2, "孙中山");
            pstm.setString(3, "1");
            pstm.setString(4, "30");
            pstm.setString(5, "北京市东城区岳山路11号");
            pstm.executeUpdate();*/
            PreparedStatement pstm1 = con.prepareStatement(sql);
            ResultSet rs = pstm1.executeQuery();

            String id = null;
            while(rs.next()){
                //获取stuname这列数据
            	 list.add(rs.getString("SP_NUMBER"));  
            }
            	 if(list != null && list.size()>0){//如果list中存入了数据，转化为数组  
                     String[] arr=new String[list.size()];//创建一个和list长度一样的数组  
                     for(int i=0;i<list.size();i++){  
                    	 arr[i]=list.get(i);//数组赋值了。  
                     } 
                     rs.close();
                     con.close();
                     //输出数组  
                    for(int i=0;i<arr.length;i++){  
                         System.out.println(arr[i]);  
                       }  
            }
        
           if(con.isClosed())
               System.out.println("Succeeded connecting to the Database!");
    
    }
}
