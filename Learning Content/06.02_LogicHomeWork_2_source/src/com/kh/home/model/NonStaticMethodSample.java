package com.kh.home.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.Scanner;

public class NonStaticMethodSample {
	Scanner sc = new Scanner(System.in);
	public void testScanner() {
		System.out.print("Byte 입력 : ");
		byte bnum = sc.nextByte();
		System.out.print("Short 입력 : ");
		short snum = sc.nextShort();
		System.out.print("int 입력 : ");
		int inum = sc.nextInt();
		System.out.print("long 입력 : ");
		long lnum = sc.nextLong();
		System.out.print("float 입력 : ");
		float fnum = sc.nextFloat();
		System.out.print("double 입력 : ");
		double dnum = sc.nextDouble();
		sc.nextLine();
		System.out.print("char 입력 : ");
		char cnum = sc.nextLine().charAt(0);
		System.out.print("String 입력 : ");
		String str = sc.nextLine();
		
		System.out.println("bnum : " + bnum);
		System.out.println("snum : " + snum);
		System.out.println("inum : " + inum);
		System.out.println("lnum : " + lnum);
		System.out.println("fnum : " + fnum);
		System.out.println("dnum : " + dnum);
		System.out.println("cnum : " + cnum);
		System.out.println("str : " + str);
		System.out.println();
	}

	public void testDate() {
		Date d = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy/mm/dd");
		SimpleDateFormat time = new SimpleDateFormat("hh:mm:ss a");
		
		System.out.println("오늘 날짜 : " + date.format(d));
		System.out.println("현재 시간 : " + time.format(d));
	}

	public void testRandom() {
		Random rnd = new Random();
		
		int r_num1 = rnd.nextInt(45);
		double r_num2 = rnd.nextDouble();
		
		System.out.println("정수 난수 : " + r_num1);
		System.out.println("실수 난수 : " + r_num2);
		
	}

}
