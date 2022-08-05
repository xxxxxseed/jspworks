<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글쓰기</title>
	<link rel="stylesheet" href="../resources/css/common.css">
	<script src="./resources/js/checkMember.js"></script>
</head>
<jsp:useBean id="memberDAO" class="com.repository.MemberDAO" scope="application"/>
<%
	if(session.getAttribute("sessionId") == null){	//로그인이 안된 상태라면
		out.println("<script>");
		out.println("alert('로그인 해주세요')");
		out.println("location.href='../loginMember.jsp'");
		out.println("</script>");
	}
%>
<body>
	<jsp:include page="../menu.jsp" />
	<div id="container">
		<div class="title">
			<h1>글쓰기</h1>
		</div>
		<div>
		<form action="./writeProcess.jsp" method="post" name="regForm">
			<table class="tbl_write">
				<tr>
					<td><input type="text" name="title" class="w_title"
							placeholder="글 제목" required="required"></td>
				</tr>
				<tr>
					<td>
						<textarea rows="15" cols="50" name="content"
							 placeholder="글 내용" required="required"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="글쓰기">
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</form>
		</div>
		
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>