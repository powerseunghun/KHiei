package com.kh.example;

import java.util.Scanner;

public class Example {
	Scanner sc = new Scanner(System.in);

	public void example1() {
		int a = 0, b = 0;

		System.out.print("첫번째 정수 : ");
		a = sc.nextInt();
		System.out.print("두번째 정수 : ");
		b = sc.nextInt();

		System.out.println("더하기 결과 : " + (a + b));
		System.out.println("빼기 결과 : " + (a - b));
		System.out.println("곱하기 결과 : " + (a * b));
		System.out.println("나누기한 몫 : " + (a / b));
		System.out.println("나누기한 나머지 : " + (a % b));
	}

	public void example2() {
		double width = 0, height = 0;
		System.out.print("가로 : ");
		width = sc.nextDouble();
		System.out.print("세로 : ");
		height = sc.nextDouble();

		System.out.println("면적 : " + (width * height));
		System.out.println("면적 : " + ((width + height) * 2));
	}
	
	public void example3() {
		String str = "";
		System.out.print("문자열을 입력하시오 : ");
		str = sc.nextLine();
		
		System.out.println("첫번째 문자 : " + str.charAt(0));
		System.out.println("두번째 문자 : " + str.charAt(1));
		System.out.println("세번째 문자 : " + str.charAt(2));
	}
}
