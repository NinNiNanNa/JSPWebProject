package board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.FileUtil;
import utils.JSFunction;

@WebServlet("/community/edit.do")
public class EditCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String boardType = req.getParameter("boardType");
		String idx = req.getParameter("idx");
		//System.out.println("EditCtrl"+boardType);
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.selectView(idx);
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/community/edit.jsp?boardType="+ boardType).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. 파일 업로드 처리 ===================================================================================
		// 업로드 디렉토리의 물리적 경로 확인
		String saveDiretory = req.getServletContext().getRealPath("/Uploads");
			
		// 파일 업로드
		String originalFileName = "";
		try {
			originalFileName = FileUtil.uploadFile(req, saveDiretory);
		}
		catch (Exception e) {
			e.printStackTrace();
			JSFunction.alertBack(resp, "파일 업로드 오류입니다.");
			return;
		}
		// 2. 파일 업로드 외 처리 =================================================================================
		String idx = req.getParameter("idx");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		String boardType = req.getParameter("boardType");
		
		BoardDTO dto = new BoardDTO();
		dto.setIdx(idx);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setBoardType(boardType);

		//원본 파일명과 저장된 파일 이름 설정
		if (originalFileName != "") {
			   /*
			   수정페이지에서 새롭게 등록한 파일이 있다면 기존 내용을 수정해야한다.
			   파일명의 이름을 변경한 후 원본파일명과 저장된 파일명을 DTO에 저장한다.
			   */
			   String savedFileName = FileUtil.renameFile(saveDiretory, originalFileName);
			
			   dto.setOfile(originalFileName);	// 원래 파일 이름
			   dto.setSfile(savedFileName);		// 서버에 저장된 파일 이름
			   
			   // 기존 파일 삭제
			   FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		else {
			   //첨부 파일이 없으면 기존 이름 유지
			   dto.setOfile(prevOfile);
			   dto.setSfile(prevSfile);
		}

		BoardDAO dao = new BoardDAO();
		// 본인 확인을 위해 기존 게시물을 인출
		int editResult = dao.updatePost(dto);

		dao.close();

		if (editResult == 1){
			// 게시물이 수정되면 목록으로 이동한다.
			JSFunction.alertLocation(resp, "게시물 수정이 완료되었습니다.", "../community/view.do?boardType="+boardType+"&idx="+idx);
		}
		else {
			// 수정에 실패하면 뒤로 이동한다.
			JSFunction.alertBack(resp, "게시물 수정에 실패하였습니다.");
		}
	}

}
