package com.kh.home.model;

public class ContinueSample {

	public void sumJumpThree() {
		int sum = 0;
		
		for (int i = 1; i <= 100; i++) {
			if (i % 3 == 0) continue;
			sum += i;
		}
		System.out.println("합계 : " + sum + "\n");
	}

	public void rowColJump() {
		int[][] arr = new int[3][5];
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr[i].length; j++) {
				if ((i == 0) && (j >= 2 && j <= 4)) continue;
				System.out.print(arr[i][j] + " ");
			}
			System.out.println();
		}
		System.out.println();
	}
}
