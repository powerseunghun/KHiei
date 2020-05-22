package com.kh.practice;

import java.util.Scanner;

public class Example {
	Scanner sc = new Scanner(System.in);

	public void sample1() {
		int kor, eng, mat, total;
		double avg;
		System.out.print("국어점수를 입력하시오 : ");
		kor = sc.nextInt();
		System.out.print("영어점수를 입력하시오 : ");
		eng = sc.nextInt();
		System.out.print("수학를 입력하시오 : ");
		mat = sc.nextInt();
		total = kor + eng + mat;
		avg = total / 3.0;

		if (((kor >= 40 && eng >= 40 && mat >= 40) && avg >= 60)) {
			System.out.println("합격.");
		} else
			System.out.println("불합격");
	}

	public void sample2() {
		String name;
		int grade, clas, num;
		char gender;
		double score;

		System.out.print("이름을 입력하세요 : ");
		name = sc.nextLine();
		System.out.print("학년을 입력하세요 : ");
		grade = sc.nextInt();
		System.out.print("반을 입력하세요 : ");
		clas = sc.nextInt();
		System.out.print("번호를 입력하세요 : ");
		num = sc.nextInt();
		sc.nextLine();
		System.out.print("성별을 입력하세요 : ");
		gender = sc.nextLine().charAt(0);
		System.out.print("성적을 입력하세요 : ");
		score = sc.nextDouble();

		System.out.print(grade + "학년 " + clas + "반 " + num + "번 ");
		if (gender == 'M')
			System.out.println("남학생 " + name + "은 " + "성적이 " + score + "이다.");
		else {
			System.out.println("여학생 " + name + "은 " + "성적이 " + score + "이다.");
		}
	}

	public void sample3() {
		int n;
		System.out.print("정수 하나 입력  : ");
		n = sc.nextInt();
		if (n > 0) System.out.println("양수다.");
		else System.out.println("양수가 아니다.");
	}
	
	public void sample4() {
		int n;
		String str;
		System.out.print("정수 하나 입력 : ");
		n = sc.nextInt();
		if (n % 2 == 0) {
			str = "짝수다.";
		}
		else str = "홀수다.";
	}
}
