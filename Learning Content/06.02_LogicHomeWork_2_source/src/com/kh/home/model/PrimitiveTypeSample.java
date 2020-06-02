package com.kh.home.model;

import java.util.Scanner;

public class PrimitiveTypeSample {
	Scanner sc = new Scanner(System.in);
	public void typeSize() {
		System.out.println("byte형 크기 : " + Byte.BYTES + "바이트");
		System.out.println("short형 크기 : " + Short.BYTES + "바이트");
		System.out.println("int형 크기 : " + Integer.BYTES + "바이트");
		System.out.println("long형 크기 : " + Long.BYTES + "바이트");
		System.out.println("float형 크기 : " + Float.BYTES + "바이트");
		System.out.println("double형 크기 : " + Double.BYTES + "바이트");
		System.out.println("char형 크기 : " + Character.BYTES + "바이트");
//		System.out.println("boolean형 크기 : " + Boolean);
	}

	public void minMaxValue() {
		System.out.println("byte형의 최소값 : " + Byte.MIN_VALUE);
		System.out.println("byte형의 최대값 : " + Byte.MAX_VALUE);
		System.out.println("short형의 최소값 : " + Short.MIN_VALUE);
		System.out.println("short형의 최대값 : " + Short.MAX_VALUE);
		System.out.println("int형의 최소값 : " + Integer.MIN_VALUE);
		System.out.println("int형의 최대값 : " + Integer.MAX_VALUE);
		System.out.println("long형의 최소값 : " + Long.MIN_VALUE);
		System.out.println("long형의 최대값 : " + Long.MAX_VALUE);
		System.out.println("float형의 최소값 : " + Float.MIN_VALUE);
		System.out.println("float형의 최대값 : " + Float.MAX_VALUE);
		System.out.println("double형의 최소값 : " + Double.MIN_VALUE);
		System.out.println("double형의 최대값 : " + Double.MAX_VALUE);
		System.out.println("char형의 최소값 : " + Character.MIN_VALUE);
		System.out.println("char형의 최대값 : " + Character.MAX_VALUE + "\n");
//		System.out.println("boolean형의 최소값 : " + "");
//		System.out.println("boolean형의 최대값 : " + "");
	}

	public void bitSize() {
		System.out.println("byte형의 비트 수 : " + Byte.SIZE + "비트");
		System.out.println("short형의 비트 수 : " + Short.SIZE + "비트");
		System.out.println("int형의 비트 수 : " + Integer.SIZE + "비트");
		System.out.println("long형의 비트 수 : " + Long.SIZE + "비트");
		System.out.println("float형의 비트 수 : " + Float.SIZE + "비트");
		System.out.println("double형의 비트 수 : " + Double.SIZE + "비트");
		System.out.println("char형의 비트 수 : " + Character.SIZE + "비트\n");
//		System.out.println("boolean형의 비트 수 : " + "");
	}

}
