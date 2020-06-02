package com.kh.home.model;

import java.util.Scanner;

public class SwitchSample {
	Scanner sc = new Scanner(System.in);
	public void calculator() {
		System.out.print("첫 번째 정수 입력 : ");
		int n1 = sc.nextInt();
		System.out.print("두 번째 정수 입력 : ");
		int n2 = sc.nextInt();
		sc.nextLine();
		System.out.print("연산문자 입력 : ");
		char op = sc.nextLine().charAt(0);
		
		int max = n1 >= n2 ? n1 : n2;
		int min = n1 >= n2 ? n2 : n1;
		
		int result = 0;
		
		switch (op) {
		case '+':
			result = max + min;
			break;
		case '-':
			result = max - min;
			break;
		case '*':
			result = max * min;
			break;
		case '/':
			result = max / min;
			break;
		case '%':
			result = max % min;
			break;
		default:
			System.out.println("잘못된 연산자 입니다.");
			return;
		}
		System.out.println(max + " " + op + " " + min + " = " + result + "\n");
	}

	public void fruitPrice() {
		System.out.print("과일 이름 입력 : ");
		String fruit = sc.nextLine();
		
		switch(fruit) {
		case "딸기":
			System.out.println("딸기는 3000원 입니다.\n");
			break;
		case "사과":
			System.out.println("사과는 2000원 입니다.\n");
			break;
		case "바나나":
			System.out.println("바나나는 5000원 입니다.\n");
			break;
		case "포도":
			System.out.println("포도는 3500원 입니다.\n");
			break;
		default:
			System.out.println("없는 과일 입니다.\n");
			break;
		}
	}

}
