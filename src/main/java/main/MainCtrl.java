package main;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board.BoardDAO;
import board.BoardDTO;
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
		BoardDAO dao = new BoardDAO();
		
		// DAO로 전달할 파라미터를 저장하기 위한 컬렉션
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("start", 1);
		param.put("end", 4);
		
		// 공지사항 최근 게시물 4개 인출(board)
		param.put("boardType", "notice");
		List<BoardDTO> notice = dao.selectListPage(param);
		
		// 자유게시판 최근 게시물 4개 인출(freeboard)
		param.put("boardType", "free");
		List<BoardDTO> free = dao.selectListPage(param);
		
		// request 영역에 저장
		req.setAttribute("notice", notice);
		req.setAttribute("free", free);
		
		// View로 포워드
		req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
	}
	
}
