<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<script type="text/javascript">
		function checkMember(){
			let form = document.Member;
			let id = form.id.value;
			let pw = form.passwd.value;
			let name = form.name.value;
			
			if(id == ""){
				alert("아이디를 입력해 주세요");
				form.id.focus();
				return false;
			}
			
			if(pw == ""){
				alert("비밀번호를 입력해 주세요");
				form.passwd.focus();
				return false;
			}
			
			if(pw.search(id) > -1){		//아이디와 비밀번호가 일치하면
				alert("비밀번호는 아이디를 포함할 수 없습니다");
				form.passwd.select();
				return false;
			}
			
			if(name == ""){
				alert("이름을 입력해 주세요");
				form.name.select();
				return false;
			}
			
			form.submit();
		}
	</script>
</head>
<body>
	<h3>회원 가입</h3>
	<form action="test_process.jsp" method="post" name="Member">
		<p>아이디: <input type="text" name="id">
		<p>비밀번호: <input type="password" name="passwd">
		<p>이 름: <input type="text" name="name">
		<p><button type="button" onclick="checkMember()">가입하기</button></p>
		
	</form>
</body>
</html>