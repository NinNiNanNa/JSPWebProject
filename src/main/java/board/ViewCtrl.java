package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/community/view.do")
public class ViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String boardType = req.getParameter("boardType");
		String idx = req.getParameter("idx");
		//DAO객체 생성을 통해 오라클에 연결
		BoardDAO dao = new BoardDAO();
		//게시물의 조회수 증가
		dao.updateVisitCount(idx);
		//게시물의 내용을 인출하여 DTO에 저장
		BoardDTO dto = dao.selectView(idx);
		dao.close();
		
		// 내용의 경우 Enter를 통해 줄바꿈을 하게되므로 웹브라우저 출력시 <br>로 변경해야한다.
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		
		// 첨부파일 확장자 추출 및 이미지 타입 확인
		String ext = null, fileName = dto.getSfile();
		if(fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".")+1);
		}
		String[] mimeStr = {"png","jpg","gif"};
		List<String> mimeList = Arrays.asList(mimeStr);
		boolean isImage = false;
		if(mimeList.contains(ext)){
			isImage = true;
		}
		
		
		// 게시물(dto)을 request 영역에 저장한 후 뷰로 포워드한다.
		req.setAttribute("dto", dto);
		req.setAttribute("isImage", isImage);
		req.getRequestDispatcher("/community/view.jsp?boardType="+boardType).forward(req, resp);
	}
	
}
