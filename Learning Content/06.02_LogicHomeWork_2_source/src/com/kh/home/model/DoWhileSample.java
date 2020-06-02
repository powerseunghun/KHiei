package com.kh.home.model;

import java.util.Scanner;

public class DoWhileSample {
	Scanner sc = new Scanner(System.in);
	
	public void addDashToken() {
		System.out.print("문자열 입력 : ");
		String str = sc.nextLine();
		int idx = 0;
		
		do {
			if (idx == str.length() - 1) {
				System.out.print(str.charAt(idx++));
			}
			else System.out.print(str.charAt(idx++) + "-");
		} while(idx < str.length());
		System.out.println();
	}
	public void menuCall() {
		System.out.println("============= Menu =============");
		System.out.println("------------ 버거류 ---------------");
		System.out.println("1. 상하이 스파이스 치킨버거 ------ 5,500원");
		System.out.println("2. 빅맥 --------------------- 5,000원");
		System.out.println("3. 베이컨 토마토 디럭스 ---------- 6,000원");
		System.out.println("-------------- 음료 ---------------");
		System.out.println("4. 콜라 --------------------- 1,500원");
		System.out.println("5. 사이다 -------------------- 1,500원");
		System.out.println("6. 오렌지쥬스 ----------------- 2,000원");
		System.out.println("7. 커피 ---------------------- 1,000원");
		System.out.println("-------------- 사이드 --------------");
		System.out.println("8. 감자튀김 -------------------- 700원");
		System.out.println("9. 아이스크림 ------------------ 1,000원");
		System.out.println("10. 이전메뉴로 이동----------------------");
		System.out.println("=================================");
		System.out.print("메뉴 선택 : ");
	}
	public void burgerKingMenu() {
		int menu = 0;
		
		do {
			menuCall();
			menu = sc.nextInt();
			
			switch(menu) {
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
				break;
			case 10:
				System.out.println("이전 메뉴로 이동합니다.\n");
				return;
			}
		} while(menu >= 1 && menu <= 10);
	}

	public void isStringAlphabet() {
		int idx = 0;
		boolean isAlpha = true;
		char alpha = ' ';
		System.out.print("문자열 입력 : ");
		String str = sc.nextLine();
		
		do {
			alpha = str.charAt(idx++);
			// 공백 제외
			if (alpha != ' ') {
				if ((!(alpha >= 'a' && alpha <= 'z')) && 
						(!(alpha >= 'A' && alpha <= 'Z'))) {
					isAlpha = false;
				}
			}
		}while(idx < str.length());
		
		if(isAlpha) System.out.println("모든 글자가 영문자입니다.\n");
		else System.out.println("모든 글자가 영문자가 아닙니다.\n");
	}
	
}
