package com.kh.example;

import java.util.Scanner;

public class Example {
	Scanner sc = new Scanner(System.in);

	public void example1() {
		int a = 0, b = 0;

		System.out.print("ù��° ���� : ");
		a = sc.nextInt();
		System.out.print("�ι�° ���� : ");
		b = sc.nextInt();

		System.out.println("���ϱ� ��� : " + (a + b));
		System.out.println("���� ��� : " + (a - b));
		System.out.println("���ϱ� ��� : " + (a * b));
		System.out.println("�������� �� : " + (a / b));
		System.out.println("�������� ������ : " + (a % b));
	}

	public void example2() {
		double width = 0, height = 0;
		System.out.print("���� : ");
		width = sc.nextDouble();
		System.out.print("���� : ");
		height = sc.nextDouble();

		System.out.println("���� : " + (width * height));
		System.out.println("���� : " + ((width + height) * 2));
	}
	
	public void example3() {
		String str = "";
		System.out.print("���ڿ��� �Է��Ͻÿ� : ");
		str = sc.nextLine();
		
		System.out.println("ù��° ���� : " + str.charAt(0));
		System.out.println("�ι�° ���� : " + str.charAt(1));
		System.out.println("����° ���� : " + str.charAt(2));
	}
}
