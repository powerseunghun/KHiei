package com.kh.example2;

import java.util.Scanner;

public class CastingSample {
	Scanner sc = new Scanner(System.in);

	public void printUniCode() {
		char ch;
		System.out.print("문자 입력 : ");
		ch = sc.nextLine().charAt(0);

		System.out.println(ch + " is unicode : " + ((int) ch));
	}

	public void calculatorScore() {
		double kor = 0, eng = 0, mat = 0;
		int total = 0, avg = 0;
		System.out.print("국어 : ");
		kor = sc.nextDouble();
		System.out.print("영어 : ");
		eng = sc.nextDouble();
		System.out.print("수학 : ");
		mat = sc.nextDouble();

		total = (int) (kor + eng + mat);
		avg = (int) ((kor + eng + mat) / 3.0);
		System.out.println("총점 : " + total);
		System.out.println("평균 : " + avg);
	}
}
