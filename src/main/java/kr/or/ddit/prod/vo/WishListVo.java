package kr.or.ddit.prod.vo;

import java.util.List;

import lombok.Data;

@Data
public class WishListVo {

	// 기본 위시리스트 정보
	private int wishlist_no; // 위시리스트 고유 번호
	private int prod_no; // 상품 번호
	private int mem_no; // 회원 번호
	private String wish_date; // 위시리스트 추가 날짜
	private int wish_state;

	// 상품 정보 추가
	private String prod_name; // 상품 이름
	private String prod_path; // 상품 이미지 경로
	private int prod_price; // 상품 가격

	// 카테고리 정보 (필요한 경우)
	private int cate_no; // 카테고리 번호
	private String cate_name; // 카테고리 이름

	private List<Integer> prodNos; // 여러 상품 번호를 저장하기 위한 필드

}
