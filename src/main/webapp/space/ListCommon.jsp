<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// DAO객체 생성을 통해 DB 연결
BoardDAO dao = new BoardDAO();

// 사용자가 선택한 필드명과 검색어 그리고 현재 게시판의 유형을 저장하고 DAO로 전달
Map<String, Object> param = new HashMap<String, Object>();

// 현재 게시판의 유형을 Map컬렉션에 저장(오류뜨지만 값은 제대로 들어옴)
param.put("boardType", boardType);
//System.out.println("(ListCommon.jsp)boardType=" + boardType);

// 검색폼에서 입력한 검색어와 필드명을 파라미터로 받기.
String keyField = request.getParameter("keyField");
String keyString = request.getParameter("keyString");
//검색어가 있는 경우
if(keyString != null){
	// Map컬렉션에 필드명과 검색어 저장
	param.put("keyField", keyField);
	param.put("keyString", keyString);
}

// Map컬렉션을 인수로 게시물의 갯수를 카운트
int totalCount = dao.selectCount(param);


/***************************** #paging관련 코드 추가 start# ********************************/

// web.xml에 설정한 컨텍스트 초기화 파라미터를 읽어옴
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

/* 
[ 전체 페이지 수 계산 ]
(전체게시물의 갯수 / 페이지당 출력할 게시물 갯수) => 결과값의 올림처리
가령 게시물의 갯수가 51개라면 나눴을때 결과가 5.1이된다.
이때 무조건 올림처리하여 6페이지로 설정하게된다. 
※ 만약 totalCount를 double형으로 변환하지 않으면 정수가 결과가 나오게 되므로 5페이지가 된다. 
*/ 
int totalPage = (int)Math.ceil((double)totalCount / pageSize);

/*
- 목록에 처음 진입했을때는 페이지 관련 파라미터가 없는 상태이므로 무조건 1page로 지정
- 만약 파라미터 pageNum이 있다면 request내장객체를 통해 받아온 후 페이지번호로 지정
	List.jsp => 이와같이 파라미터가 없는 상태일때는 null
	List.jsp?pageNum= => 이와같이 파라미터는 있는데 값이 없을때는 빈값으로 체크된다.
따라서 아래 if문은 2개의 조건으로 구성
*/
int pageNum = 1; 
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
 	pageNum = Integer.parseInt(pageTemp); 

// 게시물의 구간 계산
int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
// 계산후 DAO로 전달하기 위해 Map컬렉션에 추가
param.put("start", start);
param.put("end", end);

/*****************************  #paging관련 코드 추가 end#  ********************************/

// 목록에 출력할 게시물을 인출하여 반환받기 - 목록순서를 위해 List계열의 컬렉션 사용!(Set계열의 컬렉션 X)
List<BoardDTO> boardLists = dao.selectListPage(param);
// DB 자원해제
dao.close();
%>