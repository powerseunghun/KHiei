package com.kh.home.model;

import java.util.Scanner;

public class ForSample {
	Scanner sc = new Scanner(System.in);
	public void sum1To100() {
		int sum = 0;
		for(int i = 1; i <= 10; i++) {
			sum += i;
		}
		System.out.println("1부터 10까지의 합 : " + sum + "\n");
	}

	public void sumEven1To100() {
		int sum = 0;
		for (int i = 1; i <= 100; i++) {
			if (i % 2 == 0) {
				sum += i;
			}
		}
		System.out.println("1부터 100까지 짝수들의 합 : " + sum + "\n");
	}

	public void oneGugudan() {
		int n = 0;
		System.out.print("출력할 구구단 단 입력 : ");
		n = sc.nextInt();
		for (int i = 1; i <= 9; i++) {
			System.out.println(n + " x " + i + " = " + (n*i));
		}
		System.out.println();
	}

	public void sumMinToMax() {
		int num1, num2;
		int start, end, sum = 0;
		
		System.out.print("첫 번째 정수 입력 : ");
		num1 = sc.nextInt();
		System.out.print("두 번째 정수 입력 : ");
		num2 = sc.nextInt();
		
		start = num1 <= num2 ? num1 : num2;
		end = num1 >= num2 ? num1 : num2;
		
		for (int i = start; i <= end; i++) {
			sum += i;
		}
		
		System.out.println(start + " 부터 " + end + "까지의 합 : " + sum + "\n");
	}

	public void printStar() {
		System.out.print("줄 수 입력 : ");
		int row = sc.nextInt();
		System.out.print("행 수 입력 : ");
		int col = sc.nextInt();
		
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		System.out.println();
	}

	public void printNumberStar() {
		for (int i = 1; i <= 7; i++) {
			for (int j = 1; j <= 7; j++) {
				if (i == j) System.out.print(j);
				else System.out.print("*");
			}
			System.out.println();
		}
		System.out.println();
	}

	public void printTriangleStar() {
		int n, l_space, r_space;
		
		do {
			System.out.print("홀수 입력 : ");
			n = sc.nextInt();
		} while(n % 2 == 0);
		if (n > 0) {
			l_space = n / 2;
			r_space = n / 2;
			for (int i = 0; i < (n / 2) + 1; i++) {
				for (int j = 0; j < n; j++) {
					if (l_space > j) System.out.print(" ");
					else {
						if (r_space + j >= n) {
							System.out.print(" ");
						}
						else System.out.print("*");
					}
				}
				l_space--;
				r_space--;
				System.out.println();
			}
			System.out.println();
		}
		else if (n < 0) {
			l_space = 0;
			r_space = 0;
			n = Math.abs(n);
			for (int i = 0; i < (n / 2) + 1; i++) {
				for (int j = 0; j < n; j++) {
					if (l_space > j) System.out.print(" ");
					else {
						if (r_space + j >= n) {
							System.out.print(" ");
						}
						else System.out.print("*");
					}
				}
				l_space++;
				r_space++;
				System.out.println();
			}
			System.out.println();
		}
		// 0인 경우
		else {
			System.out.println("0을 입력하였습니다.\n");
		}
	}

	public void guguDan() {
		for (int i = 2; i <= 9; i++) {
			for (int j = 1; j <= 9; j++) {
				System.out.println(i + " * " + j + " = " + (i*j));
			}
			System.out.println();
		}
	}

}
