<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!--A Design by W3layouts
   Author: W3layout
   Author URL: http://w3layouts.com
   License: Creative Commons Attribution 3.0 Unported
   License URL: http://creativecommons.org/licenses/by/3.0/
   -->
<!DOCTYPE html>

<html lang="en">

<head>
<title>繁体字智能识别平台</title>
<!-- Meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Gadget Sign Up Form Responsive Widget, Audio and Video players, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<script>
        addEventListener("load", function () { setTimeout(hideURLbar, 0); }, false); function hideURLbar() { window.scrollTo(0, 1); }
    </script>
<!-- Meta tags -->
<!-- font-awesome icons -->
<link href="css/font-awesome.min.css" rel="stylesheet">
<!-- //font-awesome icons -->
<!--stylesheets-->
<link href="css/style.css" rel='stylesheet' type='text/css' media="all">
<!--//style sheet end here-->
<link
	href="//fonts.googleapis.com/css?family=Montserrat:300,400,500,600"
	rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700"
	rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="Assets/use/css/bootstrap.min.css" />
<link rel="stylesheet" href="Assets/use/css/style.css" />
<link rel="stylesheet" href="Assets/css/thems.css" />
<script src="Assets/use/js/jquery-3.4.1.min.js"></script>
<script src="Assets/use/js/bootstrap.min.js"></script>
<script type="text/javascript">
		var msg = "${requestScope.msg }";
		if(msg!=""){
			alert(msg)
		}
	</script>
	<!-- 	验证码功能 -->
	<script type="text/javascript">
		/* function reloadValidCode() {
            $("#imgcode").prop('src',"${ctx}/util/VerifyCodeUtils/verifyCode?timed="+ new Date().getMilliseconds());
} */
		function changeCode() {
			$("#verifyCode-img").attr("src","${pageContext.request.contextPath}/verifyCode?time="+new Date().getTime());
		} </script>
<style type="text/css">
body {
	background: url(Assets/images/login/adminlogo.jpg) top center no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<%@ include file="head.jsp"%>
	<h1 class="error">欢迎登录</h1>
	<!---728x90--->
	<div class="w3layouts-two-grids">
		<!---728x90--->
		<div class="mid-class">
			<div class="img-right-side">

				<img src="images/b11.png" class="img-fluid" alt="">
			</div>
			<div class="txt-left-side">
				<h2>欢迎登录</h2>
				<form action="${pageContext.request.contextPath }/loginCheck"
					method="post">
					<div class="form-left-to-w3l">
						<span class="fa fa-user-o" aria-hidden="true"></span> <input
							type="text" name="phonenumber" placeholder=" 输入用户名" required="">

						<div class="clear"></div>
					</div>
					<div class="form-left-to-w3l">
						<span class="fa fa-lock" aria-hidden="true"></span> <input
							type="password" name="password" placeholder="输入密码" required="">

						<div class="clear"></div>
					</div>
					<div>
						验证码：<input type="text" id="verifyCode" name="verifyCode">
						<img src="${pageContext.request.contextPath }/verifyCode" onclick="changeCode()" id="verifyCode-img"><a href="javascript:changeCode()">看不清,换一张</a>
					</div>

					<div class="main-two-w3ls">

						<div class="right-side-forget">
							<a href="#" class="for">忘记密码?</a>
						</div>
					</div>
					<div class="btnn">
						<button type="submit">登录</button>
					</div>
				</form>
				<div class="w3layouts_more-buttn">
					<h3>
						如果没有账号? <a href="${pageContext.request.contextPath }/regist">点击注册
						</a>
					</h3>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</body>

</html>