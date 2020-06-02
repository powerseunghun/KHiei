package com.kh.home.model;

import java.util.Scanner;

public class IfSample {
	Scanner sc = new Scanner(System.in);
	
	public void maxNumber() {
		System.out.print("첫 번째 정수 입력 : ");
		int n1 = sc.nextInt();
		System.out.print("두 번째 정수 입력 : ");
		int n2 = sc.nextInt();
		int max = n1 > n2 ? n1 : n2;
		
		System.out.println("두 수중 큰 수는 " + max + " 입니다.\n");
	}

	public void minNumber() {
		System.out.print("첫 번째 정수 입력 : ");
		int n1 = sc.nextInt();
		System.out.print("두 번째 정수 입력 : ");
		int n2 = sc.nextInt();
		int min = n1 > n2 ? n2 : n1;
		System.out.println("두 수중 작은 수는 " + min + " 입니다.\n");
	}

	public void threeMaxMin() {
		System.out.print("첫 번째 정수 입력 : ");
		int n1 = sc.nextInt();
		System.out.print("두 번째 정수 입력 : ");
		int n2 = sc.nextInt();
		System.out.print("세 번째 정수 입력 : ");
		int n3 = sc.nextInt();
		
		int max = (n1 > n2) ? (n1 > n3 ? n1 : n3) : (n2 > n3 ? n2 : n3);
		int min = (n1 > n2) ? (n2 > n3 ? n3 : n2) : (n1 > n3 ? n3 : n1);
		
		System.out.println("가장 큰 수 : " + max);
		System.out.println("가장 작은 수 : " + min + "\n");
	}

	public void checkEven() {
		System.out.print("정수 입력 : ");
		int n1 = sc.nextInt();
		String flag = n1 % 2 == 0 ? "짝수" : "홀수";
		
		System.out.println("입력하신 정수 " + n1 + "은 " + flag + " 입니다.\n");
	}

	public void isPassFail() {
		// 모든 과목 40점 이상, 평균 60점 이상
		System.out.print("국어 점수 입력 : ");
		int kor = sc.nextInt();
		System.out.print("영어 점수 입력 : ");
		int eng = sc.nextInt();
		System.out.print("수학 점수 입력 : ");
		int mat = sc.nextInt();
		double avg = (kor + eng + mat) / 3.0;
		
		if ((kor >= 40 && eng >= 40 && mat >= 40) && avg >= 60) {
			System.out.println("합격입니다.\n");
		}
		else System.out.println("불합격입니다.\n");
	}

	public void scoreGrade() {
		System.out.print("점수 입력 : ");
		int score = sc.nextInt();
		char grade = ' ';
		if (score >= 90) {
			grade = 'A';
		}
		else if (score >= 80) {
			grade = 'B';
		}
		else if (score >= 70) {
			grade = 'C';
		}
		else if (score >= 60) {
			grade = 'D';
		}
		else grade = 'F';
		
		System.out.println("당신의 학점은 " + grade + " 입니다.\n");
	}

	public void checkPlusMinusZero() {
		System.out.print("정수 입력 : ");
		int n = sc.nextInt();
		
		if (n == 0) System.out.println("입력한 숫자는 0 입니다.\n");
		else {
			if (n > 0) System.out.println("입력한 숫자는 양수입니다.\n");
			else System.out.println("입력한 숫자는 음수입니다.\n");
		}
	}

	public void whatCharacter() {
		System.out.print("문자 입력 : ");
		char ch = sc.nextLine().charAt(0);
		
		if (ch >= 'A' && ch <= 'Z') {
			System.out.println("입력한 문자는 영어 대문자입니다.\n");
		}
		else if (ch >= 'a' && ch <= 'z') {
			System.out.println("입력한 문자는 영어 소문자입니다.\n");
		}
		else if (ch >= '0' && ch <= '9') {
			System.out.println("입력한 문자는 숫자 문자 입니다.\n");
		}
		else {
			System.out.println("입력한 문자는 기타문자입니다.\n");
		}
	}
}
