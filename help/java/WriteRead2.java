package xue_xi;
 

import java.io.File;  
import java.io.InputStreamReader;  
import java.io.BufferedReader;  
import java.io.BufferedWriter;  
import java.io.FileInputStream;  
import java.io.FileWriter;  
  
public class WriteRead2 {  
	public static void main(String args[]) {  
        try { // ��ֹ�ļ��������ȡʧ�ܣ���catch��׽���󲢴�ӡ��Ҳ����throw  
  
            /* ����TXT�ļ� */  
            String pathname = "D:\\workspace-sts-3.9.4.RELEASE\\helloworld\\src\\xue_xi\\student"; // ����·�������·�������ԣ������Ǿ���·����д���ļ�ʱ��ʾ���·��  
            File filename = new File(pathname); // Ҫ��ȡ����·����input��txt�ļ�  
            InputStreamReader reader = new InputStreamReader(  
                    new FileInputStream(filename)); // ����һ������������reader  
            BufferedReader br = new BufferedReader(reader); // ����һ�����������ļ�����ת�ɼ�����ܶ���������  
            String line = "";  
            line = br.readLine();  
            while (line != null) {  
                line = br.readLine(); // һ�ζ���һ������  
            }  
  
            /* д��Txt�ļ� */  
            File writename = new File("./123.txt"); // ���·�������û����Ҫ����һ���µ�output��txt�ļ�  
            writename.createNewFile(); // �������ļ�  
            BufferedWriter out = new BufferedWriter(new FileWriter(writename));  
            out.write("�һ�д���ļ���\r\n"); // \r\n��Ϊ����  
            out.flush(); // �ѻ���������ѹ���ļ�  
            out.close(); // ���ǵùر��ļ�  
  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
}