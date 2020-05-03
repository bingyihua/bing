package xue_xi;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set; 
public class fan_xing {
//public class fanxing<T> {


public static void main(String[] args) {

//----------------------------泛型-------------------------------
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

 
 //--------------------------包裝類 ----------------------------------
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
//通过 new 关键字来创建的两个对象，是不存在缓存的概念的。两个用new关键字创建的对象用 == 进行比较，结果当然为 false
 // i >= -128 并且 i <= 127 的时候，第一次声明会将 i 的值放入缓存中，第二次直接取缓存里面的数据，而不是重新创建一个Ingeter 对象。那么第一个打印结果因为 i = 10 在缓存表示范围内，所以为 true。
 System.out.println(i111==i222);
 System.out.println(i333==i444);
 System.out.println(i1==i2);
 System.out.println(i3==i4);
 System.out.println(i11==i22);
 System.out.println(i33==i44);
 //------------------------集合------------------------------------------------
 
 LinkedHashSet books = new LinkedHashSet();
 books.add("Java");
 books.add("LittleHann");
 System.out.println(books);

 //Set集合不容许包含相同的元素
 Set set1 = new HashSet();
 set1.add("语文");
 System.out.println(set1);
 
 
}


}