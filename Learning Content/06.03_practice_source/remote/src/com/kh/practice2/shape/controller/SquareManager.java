package com.kh.practice2.shape.controller;

import java.util.Scanner;

import com.kh.practice2.shape.model.vo.Shape;

public class SquareManager {
	public void calcPerimeter(double height, double width) {
		double periMeter = (width + height) * 2;
		System.out.println("사각형의 둘레는 " + String.format("%.2f", periMeter) + "입니다.\n");
	}
	
	public double calcArea(double height, double width) {
		return width * height;
	}
	
	public void printShape(Shape s) {
		System.out.println("도형 타입 : 사각형");
		System.out.println("높이 : " + s.getHeight());
		System.out.println("너비 : " + s.getWidth());
		System.out.println("색상 : " + s.getColor());
		System.out.println();
	}
	
	public String paintColor(Shape s) {
		Scanner sc = new Scanner(System.in);
		System.out.print("어떤 색으로 도형을 칠할까요? : ");
		String color = sc.nextLine();
		s.setColor(color);
		System.out.println();
		
		return "선택하신 도형을 " + color + "로 색칠합니다.\n";
	}
}
