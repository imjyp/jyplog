package kr.or.ddit.prod.vo;

import lombok.Data;

@Data
public class ProdImgVo {
	private int prod_img_no;
	private int prod_no;
	private String path;

	// 위시리스트 포함 여부 필드 추가
	private boolean wished; // 해당 상품이 위시리스트에 포함되었는지 여부

}
