package com.kh.home.view;

import java.util.Scanner;

import com.kh.home.controller.Function;

public class Menu {
	public static void displayMenu() {
//		System.out.println("displayMenu");
		Scanner sc = new Scanner(System.in);
		Function f = new Function();
		int menu = 0;
		
		do {
			System.out.println("*** 지역변수/연산자/제어문 연습 프로그램 ***");
			System.out.println("1. 간단계산기");
			System.out.println("2. 작은수에서 큰수까지 합계 구하기");
			System.out.println("3. 신상정보 확인하기");
			System.out.println("4. 학생정보 확인하기");
			System.out.println("5. 별과 숫자 출력하기");
			System.out.println("6. 난수까지의 합계 구하기");
			System.out.println("7. 구구단");
			System.out.println("8. 주사위 숫자 알아맞추기 게임");
			System.out.println("9. 프로그램 종료");
			System.out.print("메뉴 번호 입력 : ");
			menu = sc.nextInt();
		} while(!(menu >= 1 && menu <= 9));
		
		switch(menu) {
		case 1:
			f.calculator();
			break;
		case 2:
			f.totalCalculator();
			break;
		case 3:
			f.profile();
			break;
		case 4:
			f.sungjuk();
			break;
		case 5:
			f.printStarNumber();
			break;
		case 6:
			f.sumRandomNumber();
			break;
		case 7:
			f.continueGugudan();
			break;
		case 8:
			f.shutnumber();
			break;
		case 9:
			System.out.println("프로그램을 종료합니다.");
			return;
		}
		
	}
}
