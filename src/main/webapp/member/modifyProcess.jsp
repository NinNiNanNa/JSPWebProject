<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>
<%
// 폼값받기
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String tel = request.getParameter("tel1")
				+"-"+request.getParameter("tel2")
				+"-"+request.getParameter("tel3");
String mobile = request.getParameter("mobile1")
				+"-"+request.getParameter("mobile2")
				+"-"+request.getParameter("mobile3");
String email = request.getParameter("email_1")+"@"+request.getParameter("email_2");
String open_email = request.getParameter("open_email");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
// 저장되어 있는 아이디 폼값도 받아야됨
String id = request.getParameter("id");

// DTO객체에 저장하기
MemberDTO dto = new MemberDTO();
dto.setName(name);
dto.setPass(pass);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setOpen_email(open_email);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);
//저장되어 있는 아이디값 받아왔으니 저장
dto.setId(id);

// DAO객체 생성 및 update처리
MemberDAO dao = new MemberDAO();
int result = dao.memberModify(dto);

if(result == 1){
	// session영역에 회원 이름 저장
	session.setAttribute("UserName", dto.getName());
	JSFunction.alertLocation("회원정보가 변경되었습니다.", "login.jsp", out);
}
else{
	JSFunction.alertBack("회원정보변경에 실패했습니다.", out);
}
%>