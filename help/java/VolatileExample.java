package xue_xi;

public class VolatileExample extends Thread {

	// �����ྲ̬����,���̷߳�����ͬһ�������
	//private static volatile boolean flag = false;
	private static boolean flag = false;

	// ����ѭ��,�ȴ�flag��Ϊtrueʱ������ѭ��

	public void run() {
		while (!flag) {
			System.out.println(1);
		}
		;
	}

	public static void main(String[] args) throws Exception {

		new VolatileExample().start();

		// sleep��Ŀ���ǵȴ��߳��������,Ҳ����˵����run������ѭ������

		Thread.sleep(1);

		flag = true;

	}

}
