package com.kh.home.model;

import java.util.Scanner;

public class VariableSample {
	Scanner sc = new Scanner(System.in);
	byte bnum;
	short snum;
	int inum;
	long lnum;
	float fnum;
	double dnum;
	char ch;
	boolean b;
	
	public void myProfile() {
		String name = "안승훈";
		double height = 200.0;
		double weight = 100.4;
		String blood = "O형";
		
		System.out.println(name + "님은 키 " + height + "cm, 몸무게 " + 
		weight + "kg, 혈액형은 " + blood + " 입니다.\n");
	}
	
	public void empInformation() {
		String name = null;
		double height = 0.0;
		double weight = 0.0;
		String blood = null;
		
		System.out.print("이름 입력 : ");
		name = sc.nextLine();
		System.out.print("키 입력 : ");
		height = sc.nextDouble();
		System.out.print("몸무게 입력 : ");
		weight = sc.nextDouble();
		sc.nextLine();
		System.out.print("혈액형 입력 : ");
		blood = sc.nextLine();
		
		System.out.println(name + "님은 키 " + height + "cm, 몸무게 " + 
		weight + "kg, 혈액형은 " + blood + " 입니다.\n");
	}
	
	public void defaultValue() {
		System.out.println("byte형 : " + bnum);
		System.out.println("short형 : " + snum);
		System.out.println("int형 : " + inum);
		System.out.println("long형 : " + lnum);
		System.out.println("float형 : " + fnum);
		System.out.println("double형 : " + dnum);
		System.out.println("char형 : " + ch);
		System.out.println("boolean형 : " + b + "\n");
	}
}
