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

@WebServlet("/community/write.do")
public class WriteCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 글쓰기 페이지로 진입할때는 다른 로직없이 포워드만 진행
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String boardType = req.getParameter("boardType");
		//System.out.println("WriteCtrl.java(doGet): "+ boardType);
		req.getRequestDispatcher("/community/write.jsp?boardType="+ boardType).forward(req, resp);
	}
	
	// 글쓰기는 post방식의 전송이므로 doPost()에서 요청을 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. 파일 업로드 처리 ===================================================================================
		// 업로드 디렉토리의 물리적 경로 확인
		String saveDiretory = req.getServletContext().getRealPath("/Uploads");
		//System.out.println("WriteCtrl.java(doPost): "+ req.getParameter("boardType"));
		
		// 파일 업로드
		String originalFileName = "";
		try {
			// 업로드가 정상적으로 완료되면 원본 파일명을 반환한다.
			originalFileName = FileUtil.uploadFile(req, saveDiretory);
		}
		catch (Exception e) {
			/*
			파일업로드 시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동한다.
			예외 발생의 이유를 확인하기위해 printStackTrace()메서드를 사용하는 것이 좋다.
			*/
			e.printStackTrace();
			JSFunction.alertLocation(resp, "파일을 첨부하지 못했습니다.", "../community/write.do?boardType="+req.getParameter("boardType"));
			return;
		}
		
		// 2. 파일 업로드 외 처리 =================================================================================
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("UserId");
		
		// 폼값 DTO객체에 저장
		BoardDTO dto = new BoardDTO();
		dto.setId(id);
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		dto.setBoardType(req.getParameter("boardType"));
		
		// 첨부파일이 정상적으로 등록되어 원본 파일명이 반환되었다면
		if (originalFileName != "") {
			// 파일명을 "날짜_시간.확장자"형식으로 변경한다.
			String savedFileName = FileUtil.renameFile(saveDiretory, originalFileName);
			
			// 원본과 변경된 파일명을 DTO에 저장한다.
			dto.setOfile(originalFileName);	// 원래 파일 이름
			dto.setSfile(savedFileName);	// 서버에 저장된 파일 이름
		}

		// DAO를 통해 DB에 게시 내용 저장
		BoardDAO dao = new BoardDAO();
		int isResult = dao.insertWrite(dto);
		dao.close();
		
		if(isResult == 1) {
			JSFunction.alertLocation(resp, "게시물을 등록하였습니다.", "../community/list.do?boardType="+req.getParameter("boardType"));
		}
		else {
			JSFunction.alertBack(resp, "게시물 작성에 실패하였습니다.");
		}
		
	}
	
}
