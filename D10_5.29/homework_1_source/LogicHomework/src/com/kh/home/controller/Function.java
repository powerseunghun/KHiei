package com.kh.home.controller;

import java.util.Scanner;

public class Function {
	Scanner sc = new Scanner(System.in);

	public void calculator() {
		int result = 0, max = 0, min = 0;
		System.out.print("첫번째 정수 : ");
		int n1 = sc.nextInt();
		System.out.print("두번째 정수 : ");
		int n2 = sc.nextInt();
		sc.nextLine();
		System.out.print("연산 문자 : ");
		char op = sc.nextLine().charAt(0);

		max = n1 >= n2 ? n1 : n2;
		min = n1 >= n2 ? n2 : n1;
		switch (op) {
		case '+':
			result = max + min;
			break;
		case '-':
			result = max - min;
			break;
		case 'x':
			result = max * min;
			break;
		case '/':
			if (min == 0) {
				System.out.println("0으로 나눌 수 없습니다.");
				result = 0;
			} else
				result = max / min;
			break;
		}
		System.out.println(max + " " + op + " " + min + " = " + result);
	}

	public void totalCalculator() {
		int n1 = 0, n2 = 0;
		int begin = 0, end = 0, sum = 0;
		System.out.print("첫 번째 정수 : ");
		n1 = sc.nextInt();
		System.out.print("두 번째 정수 : ");
		n2 = sc.nextInt();

		begin = n1 <= n2 ? n1 : n2;
		end = n2 >= n1 ? n2 : n1;
		
		for (int i = begin; i <= end; i++) {
			sum += i;
		}
		System.out.println(begin + "부터 " + end + "까지 정수들의 합계 : " + sum);
	}
	
	public void profile() {
		String name = "홍길동";
		int age = 26;
		String gender = "남자";
		String personality = "고집불통";
		
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		System.out.println("성별 : " + gender);
		System.out.println("성격 : " + personality);
	}
	
	public void sungjuk() {
		System.out.print("이름 입력 : ");
		String name = sc.nextLine();
		System.out.print("학년 입력 : ");
		int level = sc.nextInt();
		System.out.print("반 입력 : ");
		int ban = sc.nextInt();
		System.out.print("번호 입력 : ");
		int std_num = sc.nextInt();
		sc.nextLine();
		System.out.print("성별 입력(M/F) : ");
		char gender = sc.nextLine().charAt(0);
		System.out.print("성적 입력 : ");
		double grade= sc.nextDouble();
//		System.out.print("학점 입력 : ");
//		char credit = sc.nextLine().charAt(0);
		char credit;
		
		String print = "";
		if(grade >= 90) credit = 'A';
		else if(grade >= 80) credit = 'B';
		else if(grade >= 70) credit = 'C';
		else if(grade >= 60) credit = 'D';
		else credit = 'F';
		
		String printGender = gender == 'M' ? "남학생" : "여학생";
		System.out.println(level + "학년 " + ban + "번 " + printGender + 
				" " + name + "의 점수는 " + grade + "이고, " + 
				credit + "학점 입니다.");		
	}
	
	public void printStarNumber() {
		int n = 0;
		
		System.out.print("정수 하나 입력 : ");
		n = sc.nextInt();
		
		if (n <= 0) {
			System.out.println("양수가 아닙니다.");
			return;
		}
		for (int i = 1; i <= n ; i++) {
			for (int j = 1; j <= i; j++) {
				if (i == j) System.out.print(j);
				else System.out.print("*");
			}
			System.out.println();
		}
	}
	
	public void sumRandomNumber() {
		int randomNumber = (int) (Math.random() * 100) + 1;
		int sum = 0;
		for (int i = 1; i <= randomNumber; i++) {
			sum += i;
		}
		
		System.out.println("1부터 " + randomNumber + "까지의 합 = " + sum);
	}
	
	public void continueGugudan() {
		Scanner sc = new Scanner(System.in);
		int dan = 0, except = 0;
		System.out.print("단수 : ");
		dan = sc.nextInt(); 
		
		if (!(dan > 0)){
			System.out.println("양수가 아닙니다.");
			return;
		}
		System.out.print("제외할 배수 : ");
		except = sc.nextInt();
		
		for (int i = 1; i <= 9; i++) {
			if (i % dan == 0) continue;
			if (i % except == 0) continue;
			System.out.println(dan + " * " + i + " = " + (dan * i));
		}
	}
	
	public void shutnumber() {
		int dice1 = 0, dice2 = 0;
		int result = 0, answer = 0;
		char con = ' ';
		boolean flag = true;
		
		dice1 = (int) (Math.random() * 6) + 1;
		dice2 = (int) (Math.random() * 6) + 1;
		result = dice1 + dice2;
		
		do {
			System.out.print("두 주사위 눈의 합은? : ");
			answer = sc.nextInt();
			
			if (answer != result) {
				System.out.println("틀렸습니다.");
			}
			sc.nextLine();
			System.out.print("계속 하시겠습니까?(y/n) : ");
			con = sc.nextLine().charAt(0);
			if (con == 'n' || con == 'N') flag = false;
		} while(flag);
	}
}
