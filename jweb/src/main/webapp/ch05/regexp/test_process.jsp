<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

%>

<p>아이디: <%=request.getParameter("id") %>
<p>비밀번호: <%=request.getParameter("passwd") %>
<p>이 름: <%=request.getParameter("name") %>