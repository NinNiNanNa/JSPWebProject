package board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.FileUtil;

// 요청명에 대한 매핑은 어노테이션으로 설정
@WebServlet("/community/download.do")
public class DownloadCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 다운로드 링크를 클릭하므로 get방식의 요청
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터 받기
		String ofile = req.getParameter("ofile");	// 원본 파일명
		String sfile = req.getParameter("sfile");	// 저장된 파일명
		String idx = req.getParameter("idx");		// 게시물 일련번호
		
		// 파일 다운로드
		FileUtil.download(req, resp, "/Uploads", sfile, ofile);
		
		// 해당 게시물의 다운로드 수 1 증가
		BoardDAO dao = new BoardDAO();
		dao.downCountPlus(idx);
		dao.close();
	}
	
}
