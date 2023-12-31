<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:choose>
	<c:when test="${!(UserId eq null) && Account eq 'admin' }">
		<div id="top" style="border:0px solid #000;"> 
			<a href="../admin/adminMain.do"><img src="../images/logo.gif" alt="마포구립장애인 직업재활센터" id="top_logo" /></a>
			<ul id="lnb">
		<%
		// 로그아웃 상태에서는 LOGIN, JOIN을 출력
		if (session.getAttribute("UserId") == null) { 
		%>
				<!-- 로그인전 -->
				<li><a href="../member/login.jsp"><img src="../images/lnb01.gif" alt="LOGIN" /></a></li>
				<li><a href="../member/join01.jsp"><img src="../images/lnb02.gif" alt="JOIN" /></a></li>
		<%
		} else {  
		// 로그인이 된 상태에서는 LOGOUT, MODIFY을 출력
		%>
				<!-- 로그인후 -->
				<li><a href="../member/logout.jsp"><img src="../images/lnb05.gif" alt="LOGOUT" /></a></li>
		<%
		}
		%>
				<li><a href="../member/sitemap.jsp"><img src="../images/lnb03.gif" alt="SITEMAP" /></a></li>
				<li><a href="../center/sub06.jsp"><img src="../images/lnb04.gif" alt="CONTACT US" /></a></li>
				
			</ul>	 
			
			<!-- <a href="../center/sub01.jsp"><img src="../images/navi.jpg" id="navigation" /></a> -->
			<img src="../images/gnb.jpg" id="navigation"  width="753" height="65" usemap="#GNB"/>
			<map name="GNB">
				<area shape="rect" alt="" title="" coords="0,0,80,33" href="../center/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="86,0,188,33" href="../business/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="193,0,316,33" href="../product/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="321,0,420,33" href="../market/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="428,0,529,33" href="../space/listBoard_list.jsp?boardType=notice" target="" />
				<area shape="rect" alt="" title="" coords="536,0,638,33" href="../community/list.do?boardType=empinfo" target="" />
				<area shape="rect" alt="" title="" coords="641,0,749,33" href="../volunteer/sub01.jsp" target="" />
			</map>
			
			<!--  <div style="position:absolute; margin:-25px 0 0 200px;  border:0px solid #000;">	
				<object type="application/x-shockwave-flash" data="../swf/navi.swf" width="753" height="65">
					<param name="wmode" value="transparent" />
				</object>		
			</div>  -->
		</div>
	</c:when>
	<c:otherwise>
		<div id="top" style="border:0px solid #000;"> 
			<a href="../main/main.do"><img src="../images/logo.gif" alt="마포구립장애인 직업재활센터" id="top_logo" /></a>
			<ul id="lnb">
		<%
		// 로그아웃 상태에서는 LOGIN, JOIN을 출력
		if (session.getAttribute("UserId") == null) { 
		%>
				<!-- 로그인전 -->
				<li><a href="../member/login.jsp"><img src="../images/lnb01.gif" alt="LOGIN" /></a></li>
				<li><a href="../member/join01.jsp"><img src="../images/lnb02.gif" alt="JOIN" /></a></li>
		<%
		} else {  
		// 로그인이 된 상태에서는 LOGOUT, MODIFY을 출력
		%>
				<!-- 로그인후 -->
				<li><a href="../member/logout.jsp"><img src="../images/lnb05.gif" alt="LOGOUT" /></a></li>
				<li><a href="../member/modify.jsp"><img src="../images/lnb06.gif" alt="MODIFY" /></a></li>
		<%
		}
		%>
				<li><a href="../member/sitemap.jsp"><img src="../images/lnb03.gif" alt="SITEMAP" /></a></li>
				<li><a href="../center/sub06.jsp"><img src="../images/lnb04.gif" alt="CONTACT US" /></a></li>
				
			</ul>	 
			
			<!-- <a href="../center/sub01.jsp"><img src="../images/navi.jpg" id="navigation" /></a> -->
			<img src="../images/gnb.jpg" id="navigation"  width="753" height="65" usemap="#GNB"/>
			<map name="GNB">
				<area shape="rect" alt="" title="" coords="0,0,80,33" href="../center/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="86,0,188,33" href="../business/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="193,0,316,33" href="../product/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="321,0,420,33" href="../market/sub01.jsp" target="" />
				<area shape="rect" alt="" title="" coords="428,0,529,33" href="../space/listBoard_list.jsp?boardType=notice" target="" />
				<area shape="rect" alt="" title="" coords="536,0,638,33" href="../community/list.do?boardType=empinfo" target="" />
				<area shape="rect" alt="" title="" coords="641,0,749,33" href="../volunteer/sub01.jsp" target="" />
			</map>
			
			<!--  <div style="position:absolute; margin:-25px 0 0 200px;  border:0px solid #000;">	
				<object type="application/x-shockwave-flash" data="../swf/navi.swf" width="753" height="65">
					<param name="wmode" value="transparent" />
				</object>		
			</div>  -->
		</div>
	</c:otherwise>
</c:choose>


