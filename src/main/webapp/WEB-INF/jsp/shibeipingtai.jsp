<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">

</head>

<body>
	<%@ include file="head.jsp"%>
	<div class="scd_bg">
		<div class="scd clearfix">
			<div class="s_head clearfix">
				<nav>
					<ul>
						<li><a href="#">书籍识别</a>
							<ul>
								<li><a id="pdf"
									href="${pageContext.request.contextPath }/pdfIndex1" class=""
									target="myiframe">书籍上传</a></li>
								<li><a href="${pageContext.request.contextPath }/pdfIndex2"
									target="myiframe">已上传书籍识别</a></li>
								<li><a href="${pageContext.request.contextPath }/pdfIndex3"
									target="myiframe">书籍任务识别</a></li>
							</ul></li>
						<li><a href="#">图片识别</a>
							<ul>
								<li><a id="img"
									href="${pageContext.request.contextPath }/recognize"
									target="myiframe">图片上传</a></li>
							</ul></li>
					</ul>
				</nav>
				<div class="pst">
					<a href="">我的位置</a> - <a href="">识别平台</a>
				</div>
			</div>
			<div class="scd_m clearfix">
				<div class="company">
					<dl class="clearfix">
						<iframe name="myiframe" id="myrame"
							src="${pageContext.request.contextPath }/recognize"
							frameborder="0" align="center" width="100%" height="640px"
							scrolling="yes">
							<!--  -->

							<p>你的浏览器不支持iframe标签</p>
						</iframe>


					</dl>

				</div>
			</div>
		</div>
	</div>

	<%@ include file="foot.jsp"%>
	<script src="Assets/js/smoove.js"></script>
	<script type="text/javascript" src="Assets/js/jquery-1.7.2(1).js"></script>

</body>
<style type="text/css">
nav {
	margin: 1px auto;
	text-align: left;
}

nav ul {
	border-radius: 0px;
	background: linear-gradient(to bottom, #efefef, #bbbbbb);
	padding: 0 1px;
	display: inline-table;
	position: relative;
	box-shadow: 1px 1px 3px #666;
}

nav ul ul {
	display: none;
}

nav ul li {
	float: left;
}

nav ul::after {
	content: "";
	display: block;
	clear: both;
}

nav ul li a {
	display: block;
	padding: 1px 1px;
	color: #000;
	text-decoration: none;
	font-family: "微软雅黑";
}

nav ul li:hover>ul {
	display: block;
}

nav ul li:hover {
	background: linear-gradient(to bottom, #4f5964, #5f6975);
}

nav ul li:hover a {
	color: #FFF;
}

nav ul ul {
	background: #5f6975;
	border-radius: 0;
	position: absolute;
	top: 100%;
	padding: 0;
}

nav ul ul li {
	float: none;
	border-top: 1px solid #6b727c;
	border-bottom: 1px solid #575f6a;
}

nav ul ul li a {
	color: #FFF;
}

nav ul ul li a:hover {
	background: #4b545f;
}

nav ul ul ul {
	width: 100%;
	position: absolute;
	left: 100%;
	top: 10%;
}
</style>
</html>

