<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 처리</title>
	<link rel="stylesheet" href="./resources/css/addrbook.css">
</head>
<jsp:useBean id="abDAO" class="com.dao.AddrBookDAO" scope="application" />
<%
	String email = request.getParameter("email");	//이메일을 넘겨 받아서
	boolean result = abDAO.checkLogin(email);		//체크 함수에 매개변수로 전달
	
	if(result){
		session.setAttribute("sessionId", email);	//세션 발급(이름 - sessionId)
	}else{
		out.println("<script>");
		out.println("alert('이메일이 일치하지 않습니다.')");
		out.println("history.go(-1)");
		out.println("</script>");
	}

%>
<body>
	<div id="container">
		<h2><%=session.getAttribute("sessionId") %>으로 로그인되었습니다.</h2>
		<p><a href="./addrList.jsp">[목록 보기]</a></p>
	</div>
</body>
</html>