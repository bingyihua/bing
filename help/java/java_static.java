package xue_xi;

public class java_static {
/*	其实这个问题很简单，牵扯到类加载顺序以及类中代码执行的顺序问题。
	类的初始化顺序如下：
	父类静态变量
	父类静态块
	子类静态变量
	子类静态块
	父类变量
	父类普通块
	父类构造函数(子类实例化时先要调用父类构造函数)
	子类变量
	子类普通块
	子类构造函数*/
/*	t2 t1调用静态变量-类成员变量，都对应的是一个静态成员变量，同一个内存地址空间。无论哪个实例对象修改类静态成员变量的值，
	都会反映到其他实例对象上。类静态成员变量是随class存储在方法区的，
	实例对象是存储在堆空间的。实例对象相互是独立的，类和静态变量是唯一一份，是所有实例对象共有的。*/
	public static  class AccessProperty {
		//，static修饰的变量又称作“类变量”。
		static int i = 47; // 定义静态成员变量
		public static void main(String[] args) { // 定义主方法
			AccessProperty t2 = new AccessProperty();
			System.out.println("第一个实例对象调用变量i的结果：" + t2.i);
			AccessProperty t1 = new java_static.AccessProperty(); // 创建一个对象
			AccessProperty t3 = new AccessProperty(); // 创建另一个对象
			t1.i = 60; // 将类成员变量赋值为60
			// 使用第一个对象调用类成员变量
			System.out.println("第一个实例对象调用变量i的结果：" + t1.i);
			//t1.call(); // 使用第一个对象调用类成员方法
			// 使用第二个对象调用类成员变量
			System.out.println("第二个实例对象调用变量i的结果：" + t2.i);
			//t2.call(); // 使用第二个对象调用类成员方法
		}
	}

}
