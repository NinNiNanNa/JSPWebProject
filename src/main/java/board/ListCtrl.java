package board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;

@WebServlet("/community/list.do")
public class ListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		BoardDAO dao = new BoardDAO();
		
		// 게시물의 구간 및 검색어 관련 파라미터 저장을 위한 Map컬렉션 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		String boardType = req.getParameter("boardType");
		//System.out.println("listCtrl.java: "+ boardType);
		map.put("boardType", boardType);

		// 검색어 파라미터가 있는 경우 req(request내장객체)를 통해 받는다.
		String keyField = req.getParameter("keyField");
		String keyString = req.getParameter("keyString");
		System.out.println(keyField+"="+keyString);
		
		//검색어가 있는 경우
		if(keyString != null){
			// Map컬렉션에 필드명과 검색어 저장
			map.put("keyField", keyField);
			map.put("keyString", keyString);
		}
		// 게시물의 갯수를 카운트(검색어가 있다면 where절 추가)
		int totalCount = dao.selectCount(map);
		
		/* 페이지 처리 start */
		/*
		모델2 방식의 게시판에서는 요청을 서블릿이 먼저 받으므로
		내장객체 사용을 위해서 반드시 아래와 같이 메서드를 통해 객체를 얻어온 후 사용해야한다.
		*/
		ServletContext application = getServletContext();
		// 한 페이지에 출력할 게시물의 갯수
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		// 한 블럭당 출력할 페이지 번호의 갯수
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// 현재 페이지 확인
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);

		// 목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		// 계산된 페이지의 범위는 Map에 추가함
		map.put("start", start);
		map.put("end", end);
		/* 페이지 처리 end */
		
		List<BoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		// 뷰에 전달할 매개변수 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../community/list.do?boardType="+ boardType);
		// 페이지 번호
		map.put("pagingImg", pagingImg);
		// 전체 게시물의 갯수
		map.put("totalCount", totalCount);
		// 한페이지에 출력할 갯수
		map.put("pageSize", pageSize);
		// 현재 페이지 번호
		map.put("pageNum", pageNum);
      
		// View(JSP페이지)로 전달할 데이터를 request영역에 저장
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		// 포워드
		req.getRequestDispatcher("/community/list.jsp?boardType="+ boardType).forward(req, resp);
	}

}
