package com.kh.practice2.shape.controller;

import java.util.Scanner;

import com.kh.practice2.shape.model.vo.Shape;

public class TriangleManager {
	public void calcPeriphery(double height, double width) {
		double tmp1 = height * height;
		double tmp2 = width * width;
		
		double bitbyun = Math.sqrt(tmp1 + tmp2);
		
		double periPhery = width + bitbyun + height;
		System.out.println("삼각형의 둘레는 " + (String.format("%.2f",periPhery)) + "입니다.");
		System.out.println();
 	}
	
	public double calcArea(double height, double width) {
		double Area = (width * height) / 2.0;
		return Area;
	}
	
	public void printShape(Shape s) {
		System.out.println("도형 타입 : 삼각형");
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
		
		return "선택하신 도형을 " + s.getColor() + "로 색칠합니다.\n";
	}
}
