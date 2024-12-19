package kr.or.ddit.board.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.Websocket;
import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.vo.BoardVo;

@WebServlet("/postupload.do")
@MultipartConfig(fileSizeThreshold=1024*1024*3, 
    maxFileSize = 1024*1024*50, maxRequestSize = 1024*1024*50)
public class PostUploadController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String upload_dir = "upload_files";

    public PostUploadController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("postCode", "post");
        RequestDispatcher disp = req.getRequestDispatcher("/WEB-INF/post.jsp");
        disp.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String postTitle = req.getParameter("title");
        String postContent = req.getParameter("content");
        int postWriter = 0;
        try {
            postWriter = Integer.parseInt(req.getParameter("mem_no"));
        } catch (NumberFormatException e) {
            // Handle invalid mem_no
            System.out.println("Invalid mem_no parameter");
            RequestDispatcher disp = req.getRequestDispatcher("/WEB-INF/error.jsp");
            disp.forward(req, resp);
            return;
        }
        // <p> 태그 제거
        postContent = postContent.replaceAll("<p>", "").replaceAll("</p>", "");

        // 게시글 정보 저장
        BoardVo post = new BoardVo();
        post.setTitle(postTitle);
        post.setContent(postContent);
        post.setMem_no(postWriter);
        // post.setPath(PostimgPath); // path는 별도로 처리

        BoardService postService = BoardServiceImpl.getInstance();
        int board_no = postService.PostAdd(post); // 게시글 등록 후 ID 반환

        System.out.println("게시글 번호: " + board_no);

        // 게시글 저장 성공 후 이미지 처리
        if (board_no > 0) {
            // 동적으로 업로드 경로 설정
            String uploadPath = getServletContext().getRealPath("/images/" + upload_dir);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            for (Part part : req.getParts()) {
                if (part.getName().equals("files")) { // 파일 파트 이름 일치
                    String fileName = getFileName(part);
                    System.out.println("파일 이름: " + fileName); // 파일 이름 로그 출력

                    if (fileName != null && !fileName.isEmpty()) {
                        try {
                            String filePath = uploadPath + File.separator + fileName;
                            part.write(filePath);
                            System.out.println("파일 저장 성공: " + fileName);

                            // 이미지 경로를 데이터베이스에 저장
                            String imagePath = "/images/" + upload_dir + "/" + fileName;
                            postService.savePostImage(board_no, imagePath);
                            System.out.println("이미지 경로 DB 저장 성공: " + imagePath);
                        } catch (IOException e) {
                            e.printStackTrace();
                            System.out.println("파일 저장 중 오류 발생: " + e.getMessage());
                        }
                    }
                }
            }

            // 게시글 작성 성공 후 WebSocket을 통해 알림 전송
            String notification = "새로운 [" + postTitle + "] 게시글이 작성되었습니다";
            Websocket.sendNotification(notification); // WebSocket으로 알림 전송
            
            System.out.println(notification);
            // 게시글 작성 성공 후 메인 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/boardList?boardcode_no=4");
        } else {
            System.out.println("게시글 작성 실패!");
            RequestDispatcher disp = req.getRequestDispatcher("/WEB-INF/error.jsp");
            disp.forward(req, resp);
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
