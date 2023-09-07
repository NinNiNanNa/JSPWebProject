<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 폼에서 전송한 아이디,패스워드,아이디저장체크박스 폼값 받기
String userID = request.getParameter("user_id");
String userPW = request.getParameter("user_pw");
String save_check = request.getParameter("save_check");
// 출력결과 Console에 띄우기
System.out.println(userID+"="+userPW+"="+save_check);

// DAO객체 생성 및 DB 연결
MemberDAO dao = new MemberDAO();
// 폼값으로 받은 아이디,패스워드를 인수로 전달 후 일치하는 레코드가 있으면 DTO에 저장하여 반환
MemberDTO dto = dao.memberLogin(userID, userPW);
// 자원해제
dao.close();

if(dto.getId() != null){// 로그인 성공
	// session영역에 회원 아이디,이름,이메일 저장
	session.setAttribute("UserId", dto.getId());
	session.setAttribute("UserName", dto.getName());
	session.setAttribute("UserEmail", dto.getEmail());
	
	if (save_check!=null && save_check.equals("Y")){
		// 쿠키생성
		CookieManager.makeCookie(response, "idSave", userID, 86400);
	}
	else {
		// 쿠키삭제
		CookieManager.deleteCookie(response, "idSave");
	}
	
	// 로그인 페이지로 '이동' 한다.
	response.sendRedirect("../main/main.do");
	
}
else{//로그인 실패
	// 로그인 페이지로 돌아가기
	JSFunction.alertBack(response, "아이디 또는 비밀번호를 잘못 입력했습니다.");
}
%>