package kr.or.ddit.prod.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProdVo {
	private int prod_no;
	private String prod_name;
	private String prod_description;
	private int prod_img_no;
	private int cate_no;
	
	private String cate_name;
	
	private int prod_price;
	
	private int rn;
	
	private List<String> imagePaths; // 여러 이미지를 담기 위한 리스트
	private String path;
	private List<ProdOptionVo> prodOptions; // 여러 옵션을 담기 위한 리스트
	private int quantity;
	
	private int prod_click_cnt;
	
	private int mem_no;
	
	private int wish_state;
	
}
