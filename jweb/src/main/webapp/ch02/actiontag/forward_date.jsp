<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Action Tag</title>
</head>
<body>
	<h2>오늘의 날짜와 시간</h2>
	
	<p><%=new Date().toLocaleString() %>
</body>
</html>