package xue_xi;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set; 
public class fan_xing {
//public class fanxing<T> {


public static void main(String[] args) {

//----------------------------����-------------------------------
//fanxing<String> demo = new fanxing<String>();
 List<String> array = new ArrayList<String>(); 
 
 array.add("fuck"); 
 array.add("java");
 List<String> b = new ArrayList<String> (array);
 //List<String> b = new ArrayList(array);
 System.out.println((array)); 
 (array).add("bad egg");
 System.out.println(b);
 //System.out.println(c);
 System.out.println(array); 

 
 //--------------------------���b� ----------------------------------
 int i111 = 100;
 int i222 = 100;
 int i333 = 200;
 int i444 = 200;
 Integer i1 = 100;
 Integer i2 = 100;
 Integer i3 = 200;
 Integer i4 = 200;
 Double  i11 = 100.0;
 Double  i22 = 100.0;
 Double  i33 = 200.0;
 Double  i44 = 200.0;
//ͨ�� new �ؼ��������������������ǲ����ڻ���ĸ���ġ�������new�ؼ��ִ����Ķ����� == ���бȽϣ������ȻΪ false
 // i >= -128 ���� i <= 127 ��ʱ�򣬵�һ�������Ὣ i ��ֵ���뻺���У��ڶ���ֱ��ȡ������������ݣ����������´���һ��Ingeter ������ô��һ����ӡ�����Ϊ i = 10 �ڻ����ʾ��Χ�ڣ�����Ϊ true��
 System.out.println(i111==i222);
 System.out.println(i333==i444);
 System.out.println(i1==i2);
 System.out.println(i3==i4);
 System.out.println(i11==i22);
 System.out.println(i33==i44);
 //------------------------����------------------------------------------------
 
 LinkedHashSet books = new LinkedHashSet();
 books.add("Java");
 books.add("LittleHann");
 System.out.println(books);

 //Set���ϲ����������ͬ��Ԫ��
 Set set1 = new HashSet();
 set1.add("����");
 System.out.println(set1);
 
 
}


}