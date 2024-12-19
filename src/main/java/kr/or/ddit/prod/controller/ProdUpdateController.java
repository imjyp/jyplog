package kr.or.ddit.prod.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet("/prod/updateProd.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 3, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50)
public class ProdUpdateController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private String upload_dir = "uploadProdImg";
    private IProdService prodService = ProdServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            // 상품 정보 가져오기
            int prodNo = Integer.parseInt(req.getParameter("prod_no"));
            String prodName = req.getParameter("prod_name");
            String prodDescription = req.getParameter("prod_description");
            int cateNo = Integer.parseInt(req.getParameter("cate_no"));
            int prodPrice = Integer.parseInt(req.getParameter("prod_price"));

            // 상품 객체 생성
            ProdVo prodVo = new ProdVo();
            prodVo.setProd_no(prodNo);
            prodVo.setProd_name(prodName);
            prodVo.setProd_description(prodDescription);
            prodVo.setCate_no(cateNo);
            prodVo.setProd_price(prodPrice);

            // 상품 이미지 리스트 생성
            List<ProdImgVo> imageList = new ArrayList<>();
            String uploadPath = "D:\\A_TeachingMaterial\\05\\source\\MiddleProject2\\src\\main\\webapp\\images\\" + upload_dir;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            for (Part part : req.getParts()) {
                if (part.getName().equals("prod_images") && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {
                        String filePath = uploadPath + File.separator + fileName;
                        part.write(filePath);
                        System.out.println("파일저장 성공: " + fileName);

                        // 이미지 경로 설정
                        String imagePath = "/images/" + upload_dir + "/" + fileName;
                        ProdImgVo imgVo = new ProdImgVo();
                        imgVo.setProd_no(prodNo);
                        imgVo.setPath(imagePath);
                        imageList.add(imgVo);
                    }
                }
            }

            // 상품 옵션 리스트 생성
            List<ProdOptionVo> optionList = new ArrayList<>();
            String[] optionDetails = req.getParameterValues("prod_option_detail");
            String[] optionPrices = req.getParameterValues("prod_option_price");
            String[] optionColors = req.getParameterValues("prod_color");

            if (optionDetails != null) {
                for (int i = 0; i < optionDetails.length; i++) {
                    ProdOptionVo optionVo = new ProdOptionVo();
                    optionVo.setProd_no(prodNo);
                    optionVo.setProd_option_detail(optionDetails[i]);

                    // 옵션 가격 처리
                    if (optionPrices != null && optionPrices.length > i && !optionPrices[i].isEmpty()) {
                        optionVo.setProd_option_price(Integer.parseInt(optionPrices[i]));
                    }

                    // 옵션 색상 처리
                    if (optionColors != null && optionColors.length > i && !optionColors[i].isEmpty()) {
                        optionVo.setProd_color(optionColors[i]);
                    }

                    optionList.add(optionVo);
                }
            }

            // 상품 수정 서비스 호출
            prodService.updateProd(prodVo, optionList, imageList);

            // 수정 완료 후 페이지 이동
            resp.sendRedirect(req.getContextPath() + "/admin/prodmanagement.do");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/prod/editProd.do?prod_no=" + req.getParameter("prod_no") + "&error=failed");
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
