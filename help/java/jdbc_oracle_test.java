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
        //����Connection����
        Connection con;
        //����������
        String driver = "oracle.jdbc.OracleDriver";
        //URLָ��Ҫ���ʵ����ݿ���mydata
        String url = "jdbc:oracle:thin:@192.168.56.156:1521:helowin";
        //MySQL����ʱ���û���
        String user = "scott";
        //MySQL����ʱ������
        String password = "tiger";
         List<String> list = new ArrayList<String>();
        //������ѯ�����    
            //������������   
            Class.forName(driver);
            //1.getConnection()����������MySQL���ݿ⣡��
            con = DriverManager.getConnection(url,user,password);
            System.out.println("�ɹ��������ݿ�22");
            Statement stmt = con.createStatement();
            String sql = "select * from emp ";
            ResultSet rs = stmt.executeQuery(sql);
            //2.����statement���������ִ��SQL��䣡��
            FileOutputStream fos = new FileOutputStream("ok.txt",true);
            PrintStream p = new PrintStream(fos);
            //3.ResultSet�࣬������Ż�ȡ�Ľ��������

            while(rs.next()){
            	System.out.println(rs.getString(2) );
            	String sb = rs.getString(2)  ;
            	p.println(sb);
            	if(con.isClosed())
               System.out.println("Succeeded connecting to the Database!");
            }
    
    }
}
