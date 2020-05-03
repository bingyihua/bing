package xue_xi;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream; 
import java.util.Iterator;
import java.util.Properties; 

public class WriteRead {
    public static void main(String[] args) { 
        Properties prop = new Properties();     
        try{
            //��ȡ�����ļ�a.properties
            InputStream in = new BufferedInputStream (new FileInputStream("D:\\workspace-sts-3.9.4.RELEASE\\helloworld\\src\\conf\\student"));
            prop.load(in);     ///���������б�
            Iterator<String> it=prop.stringPropertyNames().iterator();
            while(it.hasNext()){
                String key=it.next();
                System.out.println(key+":"+prop.getProperty(key));
            }
            in.close();
            
            ///�������Ե�b.properties�ļ�
            FileOutputStream oFile = new FileOutputStream("../conf/13bb.properties", true);//true��ʾ׷�Ӵ�
            prop.setProperty("phone", "10086");
            prop.store(oFile, "The New properties file");
            oFile.close();
        }
        catch(Exception e){
            System.out.println(e);
        }
    } 
}