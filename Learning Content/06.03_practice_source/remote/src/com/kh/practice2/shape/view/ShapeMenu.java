package com.kh.practice2.shape.view;

import java.util.Scanner;

import com.kh.practice2.shape.controller.SquareManager;
import com.kh.practice2.shape.controller.TriangleManager;
import com.kh.practice2.shape.model.vo.Shape;

public class ShapeMenu {
	private Scanner sc = new Scanner(System.in);
	
	public void inputMenu() {
		int menu = 0;
		double height, width;
		
		do {
			System.out.println("======= 도형 계산기 =======");
			System.out.println("3. 삼각형");
			System.out.println("4. 사각형");
			System.out.println("9. 프로그램 종료");
			System.out.println("=======================");
			System.out.print("계산하려는 도형을 선택하세요 : ");
			menu = sc.nextInt();
			
//			Shape triangle = new Shape(menu, height, width);
//			Shape square = null;
			switch(menu) {
			case 3:
				System.out.print("도형의 높이를 입력하세요 : ");
				height = sc.nextDouble();
				System.out.print("도형의 너비를 입력하세요 : ");
				width = sc.nextDouble();
				Shape triangle = new Shape(menu, height, width);
				this.triangleMenu(triangle);
				break;
			case 4:
				System.out.print("도형의 높이를 입력하세요 : ");
				height = sc.nextDouble();
				System.out.print("도형의 너비를 입력하세요 : ");
				width = sc.nextDouble();
				Shape square = new Shape(menu, height, width);
				this.squareMenu(square);
				break;
			case 9:
				System.out.println("프로그램을 종료합니다.");
				return;
			}
		} while(true);
	}
	
	public void triangleMenu(Shape s) {
		int tri_menu = 0;
		Shape triangle = s;
		TriangleManager tm = new TriangleManager();
		
		do {
			System.out.println("======= 삼각형 계산기 =======");
			System.out.println("1. 삼각형의 둘레 구하기");
			System.out.println("2. 삼각형의 면적 구하기");
			System.out.println("3. 선택한 도형 정보 출력하기");
			System.out.println("4. 도형의 색상 칠하기");
			System.out.println("9. 메인으로 돌아가기");
			System.out.print("메뉴를 선택하세요 : ");
			tri_menu = sc.nextInt();
			
			switch(tri_menu) {
			case 1:
				tm.calcPeriphery(s.getHeight(), s.getWidth());
				break;
			case 2:
				double Area = tm.calcArea(s.getHeight(), s.getWidth());
				System.out.println("삼각형의 면적은  " + Area + "입니다.");
				System.out.println();
				break;
			case 3:
				tm.printShape(s);
				break;
			case 4:
				System.out.println(tm.paintColor(s));
				break;
			case 9:
				System.out.println("메인 메뉴로 돌아갑니다.");
				return;
			default:
				System.out.println("올바른 메뉴가 아닙니다.");
				break;
			}
		}while(true);
	}
	
	public void squareMenu(Shape s) {
		int sqr_menu = 0;
		Shape square = s;
		SquareManager sm = new SquareManager();
		
		do {
			System.out.println("======= 사각형 계산기 =======");
			System.out.println("1. 사각형의 둘레 구하기");
			System.out.println("2. 사각형의 넓이 구하기");
			System.out.println("3. 선택한 도형 정보 출력하기");
			System.out.println("4. 도형의 색상 칠하기");
			System.out.println("9. 메인으로 돌아가기");
			System.out.print("메뉴를 선택하세요 : ");
			sqr_menu = sc.nextInt();
			
			switch(sqr_menu) {
			case 1:
				sm.calcPerimeter(s.getHeight(), s.getWidth());
				break;
			case 2:
				double area = sm.calcArea(s.getHeight(), s.getWidth());
				System.out.println("사각형의 면적은 " + area + "입니다.");
				System.out.println();
				break;
			case 3:
				sm.printShape(square);
				break;
			case 4:
				System.out.println(sm.paintColor(square));
				break;
			case 9:
				System.out.println("메인 메뉴로 돌아갑니다.");
				return;
			default:
				System.out.println("올바른 메뉴가 아닙니다.");
				break;
			}
		}while(true);
	}
}
