package com.kh.practice;

import java.util.Scanner;

public class Example {
	Scanner sc = new Scanner(System.in);

	public void sample1() {
		int kor, eng, mat, total;
		double avg;
		System.out.print("���������� �Է��Ͻÿ� : ");
		kor = sc.nextInt();
		System.out.print("���������� �Է��Ͻÿ� : ");
		eng = sc.nextInt();
		System.out.print("���и� �Է��Ͻÿ� : ");
		mat = sc.nextInt();
		total = kor + eng + mat;
		avg = total / 3.0;

		if (((kor >= 40 && eng >= 40 && mat >= 40) && avg >= 60)) {
			System.out.println("�հ�.");
		} else
			System.out.println("���հ�");
	}

	public void sample2() {
		String name;
		int grade, clas, num;
		char gender;
		double score;

		System.out.print("�̸��� �Է��ϼ��� : ");
		name = sc.nextLine();
		System.out.print("�г��� �Է��ϼ��� : ");
		grade = sc.nextInt();
		System.out.print("���� �Է��ϼ��� : ");
		clas = sc.nextInt();
		System.out.print("��ȣ�� �Է��ϼ��� : ");
		num = sc.nextInt();
		sc.nextLine();
		System.out.print("������ �Է��ϼ��� : ");
		gender = sc.nextLine().charAt(0);
		System.out.print("������ �Է��ϼ��� : ");
		score = sc.nextDouble();

		System.out.print(grade + "�г� " + clas + "�� " + num + "�� ");
		if (gender == 'M')
			System.out.println("���л� " + name + "�� " + "������ " + score + "�̴�.");
		else {
			System.out.println("���л� " + name + "�� " + "������ " + score + "�̴�.");
		}
	}

	public void sample3() {
		int n;
		System.out.print("���� �ϳ� �Է�  : ");
		n = sc.nextInt();
		if (n > 0) System.out.println("�����.");
		else System.out.println("����� �ƴϴ�.");
	}
	
	public void sample4() {
		int n;
		String str;
		System.out.print("���� �ϳ� �Է� : ");
		n = sc.nextInt();
		if (n % 2 == 0) {
			str = "¦����.";
		}
		else str = "Ȧ����.";
	}
}
