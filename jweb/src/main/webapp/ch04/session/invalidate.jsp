<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String)session.getAttribute("userID");
	String pw = (String)session.getAttribute("passwd");
	
	out.println("설정된 세션의 이름 userID " + id + "<br>");
	out.println("설정된 세션의 이름 passwd " + pw + "<br>");
	
	session.invalidate();	//모든 세션 삭제
%>