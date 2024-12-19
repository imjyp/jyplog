package kr.or.ddit.prod.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdImgVo;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/prod/addProd.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 3, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50)
public class ProdAddController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private String upload_dir = "uploadProdImg";
	private IProdService prodService = ProdServiceImpl.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 카테고리 목록 조회
		List<ProdVo> cateList = prodService.prodCateList();
		req.setAttribute("cateList", cateList);
		// 상품 등록 페이지로 포워딩
		req.getRequestDispatcher("/WEB-INF/view/admin/prodaddmanagement.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		try {

			// 상품 정보 가져오기
			String prodName = req.getParameter("prod_name");
			String prodDescription = req.getParameter("prod_description");
			int cateNo = Integer.parseInt(req.getParameter("cate_no"));

			// 상품 객체 생성
			ProdVo prodVo = new ProdVo();
			prodVo.setProd_name(prodName);
			prodVo.setProd_description(prodDescription);
			prodVo.setCate_no(cateNo);

			// 상품 추가 서비스 호출
			int prodResult = prodService.insertProd(prodVo);
			if (prodResult <= 0) {
				throw new Exception("상품 등록에 실패했습니다.");
			}

			// 등록된 상품 번호 가져오기
			int prodNo = prodVo.getProd_no(); // ProdVo 객체에 삽입된 prod_no를 가져옴
			if (prodNo == 0) {
				throw new Exception("상품 번호를 가져오지 못했습니다.");
			}

			int prodPrice = Integer.parseInt(req.getParameter("prod_price"));
			prodVo.setProd_price(prodPrice);

			// 가격 추가 서비스 호출 (필요하다면)
			int priceResult = prodService.insertPrice(prodVo);
			if (priceResult <= 0) {
				throw new Exception("상품 가격 등록에 실패했습니다.");
			}

			// 동적으로 업로드 경로 설정
			String uploadPath = req.getServletContext().getRealPath("/images/" + upload_dir);
			File uploadDir = new File(uploadPath);
			System.out.println("파일 업로드 경로: " + uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			// 상품 이미지 추가
			if (prodNo > 0) {
	            for (Part part : req.getParts()) {
	                if (part.getName().equals("prod_images") && part.getSize() > 0) { // 파일 파트 이름 일치, 파일 크기 확인
	                    String fileName = getFileName(part);
	                    if (fileName != null && !fileName.isEmpty()) {
	                        try {
	                            String filePath = uploadPath + File.separator + fileName;
	                            part.write(filePath);
	                            System.out.println("파일 저장 성공: " + fileName);

	                            // 이미지 경로를 데이터베이스에 저장하기 위해 ProdImgVo 객체 생성
	                            String imagePath = "/images/" + upload_dir + "/" + fileName;
	                            ProdImgVo imgVo = new ProdImgVo();
	                            imgVo.setProd_no(prodVo.getProd_no());
	                            imgVo.setPath(imagePath);

	                            // 이미지 추가 서비스 호출
	                            int imgInsertResult = prodService.insertProdImage(imgVo);
	                            if (imgInsertResult <= 0) {
	                                throw new Exception("상품 이미지 등록에 실패했습니다.");
	                            }
	                        } catch (IOException e) {
	                            e.printStackTrace();
	                            throw new Exception("파일 저장 중 오류 발생: " + e.getMessage());
	                        }
	                    }
	                }
	            }
	        }


			String[] optionDetails = req.getParameterValues("prod_option_detail");
			String[] optionPrices = req.getParameterValues("prod_option_price");
			String[] optionColors = req.getParameterValues("prod_color");
			String[] addOptionPrices = req.getParameterValues("add_prod_price");  // 추가 가격 정보 가져오기
			String[] addOptions = req.getParameterValues("add_prod_option");  // 추가 옵션 정보 가져오기
			
			if (optionDetails != null) {
			    for (int i = 0; i < optionDetails.length; i++) {
			        ProdOptionVo optionVo = new ProdOptionVo();
			        optionVo.setProd_no(prodVo.getProd_no());
			        optionVo.setProd_option_detail(optionDetails[i]);
			        
			        // 옵션 가격 처리
			        if (optionPrices != null && optionPrices.length > i && !optionPrices[i].isEmpty()) {
			            optionVo.setProd_option_price(Integer.parseInt(optionPrices[i]));
			        }

			        // 옵션 색상 처리
			        if (optionColors != null && optionColors.length > i && !optionColors[i].isEmpty()) {
			            optionVo.setProd_color(optionColors[i]);
			        }
			        
			        // 추가 가격 처리
			        if (addOptionPrices != null && addOptionPrices.length > i && !addOptionPrices[i].isEmpty()) {
			            optionVo.setAdd_prod_price(Integer.parseInt(addOptionPrices[i]));
			        }

			        // 추가 옵션 처리
			        if (addOptions != null && addOptions.length > i && !addOptions[i].isEmpty()) {
			            optionVo.setAdd_prod_option(addOptions[i]);
			        }

			        // 옵션 추가 서비스 호출
			        int optionInsertResult = prodService.insertProdOption(optionVo);
			        if (optionInsertResult <= 0) {
			            throw new Exception("상품 옵션 등록에 실패했습니다.");
			        }
			    }
			}

			// 최종 결과 확인 및 응답
			resp.sendRedirect(req.getContextPath() + "/admin/prodmanagement.do");

		} catch (NumberFormatException e) {
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			resp.getWriter().write("잘못된 입력 형식입니다.");
		} catch (Exception e) {
			resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			resp.getWriter().write("상품 등록 중 오류가 발생했습니다.");
			e.printStackTrace();
		}
	}

	// 파일명 추출 메소드
	private String getFileName(Part part) {
		String contentDisp = part.getHeader("Content-Disposition");
		if (contentDisp != null && !contentDisp.isEmpty()) {
			String[] tokens = contentDisp.split(";");
			for (String token : tokens) {
				token = token.trim();
				if (token.startsWith("filename")) {
					return token.substring(token.indexOf("=") + 1).trim().replace("\"", "");
				}
			}
		}
		return null;
	}

}
