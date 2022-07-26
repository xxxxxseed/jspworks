<%@page import="com.dao.AddrBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주소록 상세 보기</title>
	<link rel="stylesheet" href="./resources/css/addrbook.css">
</head>
<jsp:useBean id="abDAO" class="com.dao.AddrBookDAO" scope="application" />
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	if(session.getAttribute("sessionId") != null){
		AddrBook addrBook = abDAO.getAbByNum(num);
%>
<body>
	<div id="container">
		<h2>상세 보기</h2>
		<hr>
		<table id="tbl_view">
			<tr>
				<td>번호</td><td><%=addrBook.getNum() %></td>
			</tr>
			<tr>
				<td>이름</td><td><%=addrBook.getUsername() %></td>
			</tr>
			<tr>
				<td>전화번호</td><td><%=addrBook.getTel() %></td>
			</tr>
			<tr>
				<td>이메일</td><td><%=addrBook.getEmail() %></td>
			</tr>
			<tr>
				<td>성별</td><td><%=addrBook.getGender() %></td>
			</tr>
			<tr>
				<td>가입일</td><td><%=addrBook.getJoinDate() %></td>
			</tr>
		</table>
		<a href="addrList.jsp">목록 보기</a>
	</div>
</body>
</html>
<%
	}else{
		response.sendRedirect("addrForm.jsp");	//목록 페이지로 이동
	}
%>
