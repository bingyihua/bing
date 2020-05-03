package com.cui.testng;

import java.lang.annotation.Target;
import java.lang.reflect.Method;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.Test;
import org.testng.annotations.BeforeMethod;
@Test
public class CopyOfReflectMethodTest {
	@BeforeMethod


	public void haha() throws Throwable  {
		Class  clz = Class.forName("com.cui.helloworld.testng.Test");
		System.out.println(clz);
		Object test =  clz.newInstance();
		Method mt = clz.getMethod("doRun", new Class[] { String.class,
				String.class });
		System.out.println(mt);
		System.out.println(mt.invoke(test, new Object[] { "i love you ",
				"i fuck you", }));
	}
	@AfterMethod
	protected void startTest(Method method) throws Exception {
	    String testName = method.getName(); 
	    System.out.println("Executing test: " + testName);
	}
	public void hehe1() {
		System.out.println("hahahah");
	}

	public void gege() {
		System.out.println("gege");

	}

}