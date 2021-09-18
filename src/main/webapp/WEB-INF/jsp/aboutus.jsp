<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字识别平台</title>
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<link rel="stylesheet" type="text/css" href="Assets/css/page.css" />
<script type="text/javascript" src="Assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="Assets/plugins/FlexSlider/jquery.flexslider.js"></script>
<link rel="stylesheet" type="text/css"
	href="Assets/plugins/FlexSlider/flexslider.css">
<script type="text/javascript" src="Assets/js/js_z.js"></script>

<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">
</head>
<body>
	<!-- advert组件 -->
	<div style="width: 100%; height: 400px;">
		<div class="advert">
			<%@ include file="head.jsp"%>
			<!-- <h1></h1>
	   <h2></h2> -->
		</div>
	</div>
	<section>
		<div class="box clearfix">
			<div class="box-left">
				<div class="title">
					<h3>关于我们</h3>
				</div>
				<ul>
					<li><a href="#">老师介绍</a></li>
					<li><a href="#">参与学生介绍</a></li>
					<li><a href="#">开发历程</a></li>
				</ul>
			</div>
			<div class="box-right">
				<div class="box-right-top">
					<ul>
						<li>当前位置&nbsp>></li>
						<li>关于我们&nbsp>></li>
						<li>老师介绍</li>
					</ul>
				</div>
				<div class="box-right-mid clearfix">
					<h3>老师介绍</h3>
					<p style="font-size: 14px;">
						上海和逸金融信息服务有限公司是以科技金融为主导的公司，公司下设和逸教育、和逸科技、和逸金服以及和逸金融四大业务板块，致力于打造覆盖全行业的生态圈。</br>
					</p>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="foot.jsp"%>
</body>
</html>