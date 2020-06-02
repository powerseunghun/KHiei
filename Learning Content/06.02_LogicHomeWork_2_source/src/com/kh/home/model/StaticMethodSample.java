package com.kh.home.model;

public class StaticMethodSample {

	public void testMathRandom() {
		int num = (int) (Math.random() * 45) + 1;
		System.out.println("발생한 난수는 " + num + " 입니다.\n");
	}

	public void testMathAbs() {
		double value = -12.77;
		System.out.println(value + "의 절대값 : " + Math.abs(value) + "\n");
	}

	public void testMathMax() {
		int num1 = 120;
		int num2 = 54;
		
		System.out.println(num1 + "과 " + num2 + "중 큰 수는 " + 
		Math.max(num1, num2) + " 입니다.\n");
	}

}
