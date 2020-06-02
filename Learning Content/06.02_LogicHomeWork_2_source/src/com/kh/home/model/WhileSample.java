package com.kh.home.model;

import java.util.Scanner;

import javax.swing.plaf.synth.SynthSpinnerUI;

public class WhileSample {
	Scanner sc = new Scanner(System.in);
	public void printUniCode() {
		char ch = ' ';
		while(true) {
			System.out.print("문자 하나 입력 : ");
			ch = sc.nextLine().charAt(0);
			if (ch == '0') break;
			System.out.println(ch + "의 아스키 코드 : " + (int)ch);
		}
		System.out.println();
	}

	public void sum1To100() {
		int i = 1;
		int sum = 0;
		while(i <= 100) {
			sum += (i++);
		}
		System.out.println("1부터 100까지 정수의 합 : " + sum + "\n");
	}

	public void numberGame() {
		int random = (int) (Math.random() * 100) + 1;
		int answer;
		while (true) {
			System.out.print("숫자를 맞추어 보세요 : ");
			answer = sc.nextInt();
			
			if (random == answer) {
				System.out.println("정답입니다!");
				break;
			}
			else {
				System.out.println("오답입니다!");
			}
		}
		System.out.println();
	}

	public void countCharacter() {
		System.out.print("문자열을 입력해주세요 : ");
		String str = sc.nextLine();
		int i = 0, count = 0;
		
//		while(str.charAt(i) != '\0') {
//			if (str.charAt(i) >= )
//		}
	}

	public void countInChar() {
		System.out.print("문자열을 입력해주세요 : ");
		String str = sc.nextLine();
		System.out.print("문자를 입력해주세요 : ");
		char ch = sc.nextLine().charAt(0);
		
		int idx = 0, count = 0;
		System.out.println("str.len : " + str.length());
		
		while (idx < str.length()) {
			if (str.charAt(idx) == ch) count++;
			idx++;
		}
		System.out.println(ch + " in " + str + " = " + count + "개 있습니다.\n");
	}

}
