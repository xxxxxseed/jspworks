<%@ page import="com.repository.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인</title>
<link rel="stylesheet" href="./resources/css/common.css">
</head>
<jsp:useBean id="memberDAO" class="com.repository.MemberDAO" scope="application" />
<body>
	<jsp:include page="./menu.jsp" />
	<div id="container">
		<div class="title">
			<h1>회원 로그인</h1>
		</div>
		<div>
		<form action="./loginProcess.do" method="post">
			<table class="tbl">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" placeholder="ID"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" placeholder="PASSWORD"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인">
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
	<jsp:include page="./footer.jsp" />
</body>
</html>