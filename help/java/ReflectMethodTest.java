package com.cui.testng;
import java.lang.reflect.Method;

public class ReflectMethodTest
{
public static void main(String[] args) throws Exception
{
Class clz=Class.forName("com.cui.helloworld.testng.Test");
System.out.println(clz);
Object test=(Test) clz.newInstance();
Method mt=clz.getMethod("doRun", new Class[]{String.class,String.class});
System.out.println(mt);
System.out.println(mt.invoke(test, new Object[]{"i love you ","i fuck you",}));
}
}