<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字智能识别平台</title>
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<script type="text/javascript" src="Assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="Assets/plugins/FlexSlider/jquery.flexslider.js"></script>
<link rel="stylesheet" type="text/css"
	href="Assets/plugins/FlexSlider/flexslider.css">
<script type="text/javascript" src="Assets/js/js_z.js"></script>
<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">
<script language="javascript">
$(function() {
  $('.flexslider').flexslider({
	animation: "slide"
  });
});
</script>
</head>

<body>
	<style style="text/css">
#back {
	width: 24px;
	height: 24px;
	/* padding: 10px ; */
	position: absolute;
	left: 65px;
	top: 5px;
}
</style>
	<div class="h_bg">
		<div class="head clearfix">
			<div class="logo">
				<a href="#" onclick="javascript :history.back();"><img id="back"
					src="Assets/images/back.jpg" border="0″ title="返回上一页"></a> <font
					size="5" color="white">繁体字智能识别平台</font>
			</div>
			<div class="head_r">
				<div class="nav clearfix">
					<a href="${pageContext.request.contextPath }/Index" class="now"
						target="_top"> 首页</a> <a
						href="${pageContext.request.contextPath }/notice" target="_top">公告</a>
					<a href="${pageContext.request.contextPath }/aboutus" target="_top">关于我们
					</a> <a href="${pageContext.request.contextPath }/shibeipingtai"
						target="_top">文字识别</a> <a
						href="${pageContext.request.contextPath }/resource" target="_top">资源交流</a>
					<a href="${pageContext.request.contextPath }/adminlogin"
						target="_top">管理平台</a>

				</div>
				<ul>
					<li><a style="align: right"
						href="${pageContext.request.contextPath }/login" id='login0'><font
							size="1" color="white">用户登录/注册</font></a></li>
					<li><a
						href="${pageContext.request.contextPath }/personalCenter"
						target="_top" id='login2'><font size="1" color="white">${user.phonenumber },你好&nbsp&nbsp
								个人中心</font></a></li>
					<li><a href="${pageContext.request.contextPath }/logout"
						target="_top" id='login1'><font size="1" color="white">注销</font></a></li>
				</ul>
			</div>
		</div>
	</div>
	<script>
check();
function check(){
var ss='${user.phonenumber }';
if(ss=='')
	{
	document.getElementById('login0').style.display='block';
	document.getElementById('login1').style.display='none';
	document.getElementById('login2').style.display='none';
	}
else{
	document.getElementById('login0').style.display='none';
	document.getElementById('login1').style.display='block';
	document.getElementById('login2').style.display='block';
}
}
</script>
</body>

</html>
