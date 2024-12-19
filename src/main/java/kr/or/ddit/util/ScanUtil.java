package kr.or.ddit.util;

import java.util.Scanner;

public class ScanUtil {
	private static Scanner sc = new Scanner(System.in);
	
	public static String nextLine(String message) {
		System.out.println(message);
		return sc.nextLine();
	}
	
	public static int nextInt(String message) {
		System.out.println(message);
		return nextInt();
	}
	
	private static int nextInt() {
		while(true) {
			try {
				
				int result = Integer.parseInt(sc.nextLine());
				return result;				
			} catch (Exception e) {
				System.out.println("숫자만 입력");
			}
			
		}
	}
	
	
}
