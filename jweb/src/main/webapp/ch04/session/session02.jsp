<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//발급된 세션 가져오기
	String id = (String)session.getAttribute("userID");
	String pw = (String)session.getAttribute("passwd");
	
	out.println("설정된 세션의 속성 값[1] " + id + "<br>");
	out.println("설정된 세션의 속성 값[2] " + pw + "<br>");

%>