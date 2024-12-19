package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdReviewVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.prod.vo.ReviewVo;

@WebServlet("/prod/prodDetail.do")
public class ProdController extends HttpServlet{
   
   IProdService prodService = ProdServiceImpl.getInstance();
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      int prod_no = Integer.parseInt(req.getParameter("prod_no"));
      
      // 조회수 증가 로직 추가
        int updateCount = prodService.updateProdClickCount(prod_no);
        if (updateCount > 0) {
            System.out.println("조회수 증가 성공: 상품 번호 = " + prod_no);
        } else {
            System.out.println("조회수 증가 실패: 상품 번호 = " + prod_no);
        }
      
      ProdVo prodDetail = prodService.prodDetail(prod_no);
      if(prodDetail == null) {
         resp.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 상품 정보를 찾을 수 없습니다.");
         return;
      }

      req.setAttribute("prodDetail", prodDetail);
      
      List<ProdReviewVo> reviewList = prodService.reviewList(prod_no);
      
      
      req.setAttribute("reviewList", reviewList);
      
      int cateNo = prodDetail.getCate_no();
      if(cateNo <= 0) {
         System.out.println("유효하지 않은 cate_no: " + cateNo);
         resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "카테고리 정보가 유효하지 않습니다.");
         return;
      }
      List<ProdVo> recommendedProd = prodService.recommendedProd(cateNo);
      req.setAttribute("recommendedProd", recommendedProd);
      
      req.getRequestDispatcher("/WEB-INF/view/prod/proddetail.jsp").forward(req, resp);
      
   }
   
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       // 인코딩 설정
       req.setCharacterEncoding("UTF-8");

       // 세션에서 회원 정보 가져오기
       HttpSession session = req.getSession();
       MemberVo member = (MemberVo) session.getAttribute("loginUser");
       if (member == null) {
           // 회원이 로그인하지 않은 경우 로그인 페이지로 리다이렉트
           resp.sendRedirect(req.getContextPath() + "/member/login.do");
           return;
       }
       int mem_no = member.getMem_no();

       // 액션 파라미터로 어떤 작업인지 판단 (등록, 수정, 삭제)
       String action = req.getParameter("action");
       int prod_no = Integer.parseInt(req.getParameter("prod_no"));

       if ("insert".equals(action)) {
           // 리뷰 등록 처리
           int rating = Integer.parseInt(req.getParameter("rating"));
           String content = req.getParameter("content");

           // 리뷰 객체 생성
           ReviewVo review = new ReviewVo();
           review.setProd_no(prod_no);
           review.setMem_no(mem_no);
           review.setRating(rating);
           review.setContent(content);

           // 리뷰 저장
           int insertCount = prodService.insertReview(review);
           if (insertCount > 0) {
               System.out.println("리뷰 등록 성공");
           } else {
               System.out.println("리뷰 등록 실패");
           }
       } else if ("update".equals(action)) {
           // 리뷰 수정 처리
           int review_no = Integer.parseInt(req.getParameter("review_no"));
           int rating = Integer.parseInt(req.getParameter("rating"));
           String content = req.getParameter("content");

           // 리뷰 객체 생성
           ReviewVo review = new ReviewVo();
           review.setReview_no(review_no);
           review.setMem_no(mem_no);
           review.setRating(rating);
           review.setContent(content);

           // 리뷰 수정
           int updateCount = prodService.updateReview(review);
           if (updateCount > 0) {
               System.out.println("리뷰 수정 성공");
           } else {
               System.out.println("리뷰 수정 실패");
           }
       } else if ("delete".equals(action)) {
           // 리뷰 삭제 처리
           int review_no = Integer.parseInt(req.getParameter("review_no"));

           // 리뷰 객체 생성
           ReviewVo review = new ReviewVo();
           review.setReview_no(review_no);
           review.setMem_no(mem_no);

           // 리뷰 삭제
           int deleteCount = prodService.deleteReview(review);
           if (deleteCount > 0) {
               System.out.println("리뷰 삭제 성공");
           } else {
               System.out.println("리뷰 삭제 실패");
           }
       }

       // 상품 상세 페이지로 리다이렉트
       resp.sendRedirect(req.getContextPath() + "/prod/prodDetail.do?prod_no=" + prod_no);
   }
}


   
   

