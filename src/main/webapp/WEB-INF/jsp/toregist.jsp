<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

<head>
<title>Gadget Sign Up Form a Flat Responsive Widget Template ::
	w3layouts</title>
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
<script src="Assets/use/js/jquery-3.4.1.min.js"></script>
<script src="Assets/use/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/Assets/js/jquery-1.7.2(1).js"></script>
<script type="text/javascript">
    	$(function(){
    		//?????????????????????????????????
    		$("#sub").click(function(){
    			//alert("????????????")
    			//???????????????????????????
    			var password = $("#password").val();
    			//??????????????????
    			var passwordReg = /^[a-zA-Z0-9]{6,16}$/;
    			//????????????????????????
    			if(passwordReg.test(password)!=true){
    				alert("???????????????????????????????????????6-16??????");
    				return false;
    			}
    			//?????????????????????????????????
    			var rePwd = $("#rePwd").val();
    			//??????????????????????????????
    			if(rePwd!=password){
    				alert("?????????????????????????????????")
    				//?????????????????????Value???????????????????????????????????????value????????????
    				$("#rePwd").val("");
    				return false;
    			}
    		})
    	})
    </script>
<style type="text/css">
body {
	background: url(Assets/images/login/adminlogo.jpg) top center no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<%@ include file="head.jsp"%>
	<h1 class="error">????????????</h1>
	<!---728x90--->
	<div class="w3layouts-two-grids">
		<!---728x90--->
		<div class="mid-class">
			<div class="img-right-side">
				<img src="images/b11.png" class="img-fluid" alt="">
			</div>
			<div class="txt-left-side">
				<h2>????????????</h2>
				<form action="${pageContext.request.contextPath }/registCheck"
					method="post">
					<div class="form-left-to-w3l">
						<span class="fa fa-user-o" aria-hidden="true"></span> <input
							type="text" name="phonenumber" placeholder=" ???????????????" required>

						<div class="clear"></div>
					</div>
					<div class="form-left-to-w3l">
						<span class="fa fa-lock" aria-hidden="true"></span> <input
							type="password" name="password" placeholder="????????????" id="password"
							required>

						<div class="clear"></div>
					</div>
					<div class="form-left-to-w3l">
						<span class="fa fa-lock" aria-hidden="true"></span> <input
							type="password" name="repwd" placeholder="????????????" id="rePwd"
							required>

						<div class="clear"></div>
					</div>
					<div class="main-two-w3ls">
						<div class="right-side-forget">
							<a href="#" class="for">?????????????</a>
						</div>
					</div>
					<div class="btnn">
						<button type="submit" id="sub">??????</button>
					</div>
				</form>
				<div class="w3layouts_more-buttn">
					<h3>
						????????????? <a href="${pageContext.request.contextPath }/login">????????????
						</a>
					</h3>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</body>

</html>