package kr.or.ddit.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo; // 회원 정보를 담을 VO 클래스
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdOptionVo;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/cart.do")
public class CartController extends HttpServlet {

    private IProdService prodService = ProdServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 세션에서 회원 정보 가져오기. 없으면 기본 회원 정보를 설정
        MemberVo member = (MemberVo) session.getAttribute("loginMember");
        if (member == null) {
            member = new MemberVo(); // 기본 값으로 처리
            member.setMem_no(0); // 임시 회원 번호 설정
            member.setMem_name("비회원"); // 임시 회원 이름 설정
        }

        // 회원 정보를 JSP로 전달
        req.setAttribute("member", member);

        // 장바구니 처리
        List<ProdVo> cartItems = (List<ProdVo>) session.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
            req.setAttribute("message", "장바구니가 비어 있습니다.");
        } else {
            // 상품 가격 및 총 금액 계산
            int totalProductPrice = cartItems.stream()
                    .mapToInt(prod -> prod.getProd_price() * prod.getQuantity()).sum();
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("totalProductPrice", totalProductPrice);
            req.setAttribute("totalPrice", totalProductPrice); // 필요한 추가 데이터
        }

        req.getRequestDispatcher("/WEB-INF/view/pay/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 세션에서 회원 정보 가져오기. 없으면 기본 회원 정보를 설정
        MemberVo member = (MemberVo) session.getAttribute("loginMember");
        if (member == null) {
            member = new MemberVo(); // 기본 값으로 처리
            member.setMem_no(0); // 임시 회원 번호 설정
            member.setMem_name("비회원"); // 임시 회원 이름 설정
        }

        String action = req.getParameter("action");

        // 상품 정보 수집 및 처리
        String prodNoStr = req.getParameter("prodNo");
        String optionNoStr = req.getParameter("optionDetail");
        String quantityStr = req.getParameter("quantity");

        try {
            int prodNo = Integer.parseInt(prodNoStr);
            int optionNo = Integer.parseInt(optionNoStr);
            int quantity = Integer.parseInt(quantityStr);

            // 상품 기본 정보 조회
            ProdVo prodDetail = prodService.prodDetail(prodNo);

            // 옵션 정보 처리
            List<ProdOptionVo> options = prodService.prodOptions(prodNo);
            ProdOptionVo selectedOption = options.stream()
                    .filter(option -> option.getProd_option_no() == optionNo)
                    .findFirst()
                    .orElseThrow(() -> new IllegalArgumentException("해당 옵션을 찾을 수 없습니다."));

            // 세션에서 장바구니를 가져옴
            List<ProdVo> cartItems = (List<ProdVo>) session.getAttribute("cartItems");
            if (cartItems == null) {
                cartItems = new ArrayList<>();
            }

            if ("addToCart".equals(action)) {
                boolean itemExists = false;
                for (ProdVo item : cartItems) {
                    // 동일 상품 및 동일 옵션이 장바구니에 이미 있는지 확인
                    if (item.getProd_no() == prodDetail.getProd_no() && item.getProdOptions().contains(selectedOption)) {
                        item.setQuantity(item.getQuantity() + quantity); // 기존 상품 수량 업데이트
                        itemExists = true;
                        break;
                    }
                }

                // 장바구니에 상품이 없거나 동일 옵션이 없으면 새로 추가
                if (!itemExists) {
                    prodDetail.setQuantity(quantity);
                    prodDetail.setProdOptions(List.of(selectedOption));
                    cartItems.add(prodDetail);
                }

                session.setAttribute("cartItems", cartItems);
                resp.sendRedirect(req.getContextPath() + "/cart.do"); // 장바구니 페이지로 리다이렉트

            } else if ("remove".equals(action)) {
                cartItems.removeIf(item -> item.getProd_no() == prodNo);
                session.setAttribute("cartItems", cartItems);
                resp.sendRedirect(req.getContextPath() + "/cart.do");

            } else if ("increase".equals(action)) {
                for (ProdVo item : cartItems) {
                    if (item.getProd_no() == prodNo) {
                        item.setQuantity(item.getQuantity() + 1);
                        break;
                    }
                }
                session.setAttribute("cartItems", cartItems);
                resp.sendRedirect(req.getContextPath() + "/cart.do");

            } else if ("decrease".equals(action)) {
                for (ProdVo item : cartItems) {
                    if (item.getProd_no() == prodNo && item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                        break;
                    }
                }
                session.setAttribute("cartItems", cartItems);
                resp.sendRedirect(req.getContextPath() + "/cart.do");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "잘못된 입력 값이 있습니다.");
            req.getRequestDispatcher("/WEB-INF/view/pay/cart.jsp").forward(req, resp);
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/pay/cart.jsp").forward(req, resp);
        }
    }
}
