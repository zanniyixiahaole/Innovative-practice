<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>繁体字智能识别平台</title>
<link rel="stylesheet" type="text/css"
	href="../common/css/normalize.css" />
<script type="text/javascript" src="../common/jquery/jquery.min-1.11.js"></script>
<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

body {
	background: url(Assets/images/login/adminlogo.jpg) top center no-repeat;
	background-size: cover;
}

.center {
	width: 100%;
	height: 100%;
}

.sysname-div {
	position: absolute;
	left: 250px;
	top: 30px;
}

.logoimg {
	position: relative;
	width: 60px;
	height: 60px;
	border-radius: 40px;
}

#logoimg+label {
	position: relative;
	font-size: 35px;
	color: #fff;
	top: -15px;
	left: 5px;
}

.lgmain-div {
	position: absolute;
	left: 900px;
	top: 230px;
	width: 400px;
	height: 260px;
	padding-top: 20px;
	border: 1px solid #999999;
	border-radius: 4px;
	box-shadow: 0px 0px 30px #000;
	background: white;
}

.lgtop-div {
	width: 100%;
	text-align: left;
	text-indent: 25px;
	font-size: 18px;
	margin-bottom: -10px; //
	color: #fff;
}

.lg-div {
	width: 350px;
	text-align: center;
	padding: 20px;
}

.login-div {
	width: 350px;
	height: 50px;
	border: 1px solid #cccccc;
	background: white;
}

input {
	border: none;
	outline: none;
}

.username {
	width: 85%;
	height: 100%;
	padding-left: 50px;
	background: url(images/login3.png) 15px 14px no-repeat;
}

.password {
	width: 85%;
	height: 100%;
	padding-left: 50px;
	background: url(images/login4.png) 15px 14px no-repeat;
}

.checkbox-div {
	margin-top: 10px;
	width: 100px;
	height: 25px;
	vertical-align: middle;
	text-align: left;
}

.isRemember {
	cursor: pointer;
	width: 15px;
	height: 15px;
	position: relative;
}

#isRemember+label {
	width: 20px;
	height: 20px;
	cursor: pointer;
	position: relative;
	font-size: 12px; //
	color: #fff;
	top: -4px;
	left: 0px;
}

.btn-div {
	margin-top: 10px;
	width: 130px;
	height: 35px;
}

button {
	border: none;
	outline: none;
}

#loginBtn {
	width: 100%;
	text-align: center;
	height: 100%;
	display: inline-block;
	font-weight: bold;
	color: #FFF;
	font-size: 14px;
	vertical-align: middle;
	margin-right: 5px;
	background-color: #238834f2;
	border-radius: 5px;
}

#loginBtn:hover {
	background-color: #007a00;
	border-radius: 5px;
	cursor: pointer;
}

.loginMessage {
	height: 15px;
	margin-bottom: 5px;
	text-align: left;
	color: red;
	font-size: 13px;
	font-weight: normal;
}
</style>
</head>
<body>
	<%@ include file="adminhead.jsp"%>
	<div class="center" align="center">
		<div class="background">
			<form action="loginIndex" id="fom">
				<div class="lgmain-div">
					<div class="lgtop-div">登录</div>
					<div class="lg-div">

						<div id="loginMessage" class="loginMessage"></div>
						<div class="login-div">
							<input id="username" class="username" name="username"
								placeholder="用户名" value="" type="text" />
						</div>
						<div class="login-div">
							<input id="password" name="password" class="password"
								placeholder="密码" value="" type="password" />
						</div>
						<div class="checkbox-div">
							<input type="checkbox" id="isRemember" class="isRemember"
								name="isRemember" /> <label for="isRemember">记住密码</label>
						</div>
						<div class="btn-div">
							<button id="loginBtn" type="button" onclick="doSubmit()">登&nbsp;&nbsp;&nbsp;录</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		var msg = "${requestScope.msg }";
		if(msg!=""){
			alert(msg)
		}
	</script>
	<script type="text/javascript">
function doSubmit(){
	var form = document.getElementById('fom');
	//再次修改input内容

	form.submit();
}
</script>
</body>
</html>