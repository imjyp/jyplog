package kr.or.ddit.board.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/boardimgupload.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 3, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50)
public class BoardImgUploadServlet extends HttpServlet {

	String upload_dir = "upload_files";

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("멀티 파싱 전 :" + req.getParameter("sender"));

		String uploadPath = "D:/A_TeachingMaterial/05_MIDDLE2/MiddleProject2/src/main/webapp/images/" + upload_dir;
		File uploadDir = new File(uploadPath);

		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		String fileName = "";

		for (Part part : req.getParts()) {
			System.out.println("header :" + part.getHeader("content-disposition"));

			fileName = getFileName(part);

			if (fileName != null && !fileName.equals("")) {
				part.write(uploadPath + "/" + fileName);
				System.out.println("파일명 =>" + fileName + "저장 완료@#@#@");
			}
		}

	}

	private String getFileName(Part part) {

		for (String content : part.getHeader("Content-Disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf("=") + 1).trim().replace("\"", "");
			}
		}

		return null;

	}
}
