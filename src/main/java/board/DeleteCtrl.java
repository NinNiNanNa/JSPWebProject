package board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.FileUtil;
import utils.JSFunction;

@WebServlet("/community/delete.do")
public class DeleteCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시판 유형 파라미터 받기
		String boardType = req.getParameter("boardType");
		// 일련번호를 폼값으로 받기
		String idx = req.getParameter("idx");
		
		req.setAttribute("boardType", boardType);
		req.setAttribute("idx", idx);
		
		BoardDTO dto = new BoardDTO();
		BoardDAO dao = new BoardDAO();
		// 본인 확인을 위해 기존 게시물을 인출
		dto = dao.selectView(idx);
		
		HttpSession session = req.getSession();
		String sessionId = (String)session.getAttribute("UserId");
		String sessionAccount = (String)session.getAttribute("Account");

		int delResult = 0;

		//세션아이디와 게시물의 아이디가 일치하면 작성자 본인이므로...
		if (sessionId.equals(dto.getId()) || sessionAccount.equals("admin")){
			// 게시판 유형가져오기
			dto.getBoardType();
			// 게시물을 삭제한다.
			dto.setIdx(idx);
			//System.out.println("boardType:" + dto.getBoardType());
			delResult = dao.deletePost(dto);
			dao.close();
			
			if (delResult == 1){
				String saveFileName = dto.getSfile();
				FileUtil.deleteFile(req, "/Uploads", saveFileName);
				// 게시물이 삭제되면 목록으로 이동한다.
				JSFunction.alertLocation(resp, "게시물 삭제가 완료되었습니다.", "../community/list.do?boardType="+req.getParameter("boardType"));
			}
			else {
				// 삭제에 실패하면 뒤로 이동한다.
				JSFunction.alertBack(resp, "게시물 삭제에 실패하였습니다.");
			}
		}
		else {
			// 작성자 본인이 아니면 삭제할 수 없다.
			JSFunction.alertBack(resp, "삭제할 권한이 없습니다.");
			return;
		}
	}

}
