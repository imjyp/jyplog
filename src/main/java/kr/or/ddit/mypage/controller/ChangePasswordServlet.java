package kr.or.ddit.mypage.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        // 사용자 ID를 세션에서 가져온다고 가정합니다.
        String userId = (String) request.getSession().getAttribute("userId");

        // 비밀번호 변경 로직을 여기에 추가합니다.
        // 예: DB에서 현재 비밀번호 확인 후 새로운 비밀번호로 변경

        // 비밀번호 변경 성공 여부에 따라 응답 처리
        boolean isPasswordChanged = changeUserPassword(userId, currentPassword, newPassword);
        if (isPasswordChanged) {
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
        }
    }

    private boolean changeUserPassword(String userId, String currentPassword, String newPassword) {
        // 여기에 데이터베이스와 연결하여 비밀번호를 변경하는 로직을 구현합니다.
        // 비밀번호가 현재 비밀번호와 일치하는지 확인하고, 일치하면 새로운 비밀번호로 업데이트합니다.

        // 이 부분은 데이터베이스 연결 및 쿼리 실행을 포함합니다.
        // 아래는 단순히 예시로 true를 반환합니다. 실제 구현에서는 DB 작업이 필요합니다.
        return true; // 비밀번호 변경 성공 여부에 따라 true 또는 false 반환
    }
}
