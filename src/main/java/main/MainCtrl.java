package main;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/main/main.do")
public class MainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// DB연결
		
		// DAO로 전달할 파라미터를 저장하기 위한 컬렉션
		
		// 공지사항 최근 게시물 4개 인출(board)
		
		
		// 자유게시판 최근 게시물 4개 인출(freeboard)
		
		// request 영역에 저장
		
		// View로 포워드
		req.getRequestDispatcher("main.jsp").forward(req, resp);
	}
	
}
