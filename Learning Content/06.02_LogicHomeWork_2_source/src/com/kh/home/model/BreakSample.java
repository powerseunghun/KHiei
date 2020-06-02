package com.kh.home.model;

public class BreakSample {

	public void sumBreak() {
		int sum = 0;
		int count = 0;
		while(true) {
			sum += count++;
			if (count > 100) break;
		}
		System.out.println("1~100까지 정수들의 합계 : " + sum + "\n");
	}

	public void guguDanBreak() {
		for (int i = 1; i <= 10; i++) {
			for (int j = 1; j < 10; j++) {
				if (j == 5) break;
				System.out.println(i + " * " + j + " = " + (i * j));
			}
			System.out.println();
		}
	}

}
