package com.cui.testng;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.AfterTest;

@Test
public class NewTest {
  public void f() {
	  System.out.println("����ִ��001");
  }
  @BeforeMethod
  public void f1() {
	  System.out.println("���Է���ǰִ��001");
  }
  
  public void fo1() {
	  System.out.println("����ִ��002");
  }
  @BeforeClass
  public void beforeClass() {
	  System.out.println("��ǰ���е�");
  }

  @AfterClass
  public void afterClass() {
	  System.out.println("������е�");
  }
  @BeforeTest
  public void beforeTest() {
	  System.out.println("����ǰ���е�");
  }

  @AfterTest
  public void afterTest() {
	  System.out.println("����֮�����е�");
  }

}
