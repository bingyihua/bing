package xue_xi;

/**
 * 
 * һ���򵥵�չʾHappen-Before������.
 * 
 * �����������������:a��flag,��ʼֵ�ֱ�Ϊ0��false.��ThreadA���ȸ�a=1,Ȼ��flag=true.
 * 
 * �����������Ļ�,��ô��ThreadB�����if(flag)�ɹ��Ļ�,��Ӧ��a=1,��a=a*1֮��a��ȻΪ1,�·���if(a==0)Ӧ����Զ����Ϊ��,��Զ�����ӡ.
 * 
 * ��ʵ�������:������100�ε�����»����0�λ򼸴εĴ�ӡ���,������1000�ν��������,��ʮ���δ�ӡ.
 * 
 */

public class SimpleHappenBefore {

	/** ����һ����֤����ı��� */

	private static int a = 0;

	/** ����һ����־λ */

	private static boolean flag = false;

	public static void main(String[] args) throws InterruptedException {

		// ���ڶ��߳������δ�ػ��Գ�������Ľ���,���Զ���һЩ��

		for (int i = 0; i < 1000; i++) {

			ThreadA threadA = new ThreadA();

			ThreadB threadB = new ThreadB();

			threadA.start();

			threadB.start();

			// ����ȴ��߳̽�����,���ù������,��ʹ��֤����Ĺ�����ü�Щ.

			threadA.join();

			threadB.join();

			a = 0;

			flag = false;

		}

	}

	static class ThreadA extends Thread {

		public void run() {

			a = 1;

			flag = true;

		}

	}

	static class ThreadB extends Thread {

		public void run() {

			if (flag) {

				a = a * 1;

			}

			if (a == 0) {

				System.out.println("ha,a==0");

			}

		}

	}

}
