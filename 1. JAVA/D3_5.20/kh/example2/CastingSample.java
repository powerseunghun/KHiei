package com.kh.example2;

import java.util.Scanner;

public class CastingSample {
	Scanner sc = new Scanner(System.in);

	public void printUniCode() {
		char ch;
		System.out.print("���� �Է� : ");
		ch = sc.nextLine().charAt(0);

		System.out.println(ch + " is unicode : " + ((int) ch));
	}

	public void calculatorScore() {
		double kor = 0, eng = 0, mat = 0;
		int total = 0, avg = 0;
		System.out.print("���� : ");
		kor = sc.nextDouble();
		System.out.print("���� : ");
		eng = sc.nextDouble();
		System.out.print("���� : ");
		mat = sc.nextDouble();

		total = (int) (kor + eng + mat);
		avg = (int) ((kor + eng + mat) / 3.0);
		System.out.println("���� : " + total);
		System.out.println("��� : " + avg);
	}
}
