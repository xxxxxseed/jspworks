<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//클라이언트(로컬) 컴퓨터에 저장된 쿠키 가져옴
	Cookie[] cookies = request.getCookies();
	out.println("현재 설정된 쿠키의 개수=> " + cookies.length + "<br>");
		out.println("==================================================<br>");
	for(int i = 0; i < cookies.length; i++){
		out.println("설정된 쿠키의 속성 이름[" + i + "]: " + cookies[i].getName() + "<br>");
		out.println("설정된 쿠키의 속성 값[" + i + "]: " + cookies[i].getValue() + "<br>");
		out.println("==================================================<br>");
	}


%>