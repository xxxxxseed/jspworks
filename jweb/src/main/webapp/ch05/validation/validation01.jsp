<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>유효성 검사</title>
	<script type="text/javascript">
		function checkForm(){
			//document.폼이름.입력항목이름.value
			let form = document.loginForm;
			let userid = form.userid.value;
			let passwd = form.passwd.value;
			
			alert("아이디: " + userid + "\n" + "비밀번호: " + passwd);
			
			form.submit();
		}
	</script>
</head>
<body>
	<form action="loginProcess.jsp" method="post" name="loginForm">
		<p>
			<label for="userid">아이디 : </label>
			<input type="text" id="userid" name="userid">
		</p>
		<p>
			<label for="passwd">비밀번호 : </label>
			<input type="password" id="passwd" name="passwd">
		</p>
		<p><input type="button" value="로그인" onclick="checkForm()"></p>
	</form>
</body>
</html>