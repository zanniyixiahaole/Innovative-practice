<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字智能识别平台</title>
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<script type="text/javascript" src="Assets/js/jquery-3.0.0.min.js"></script>
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
<style type="text/css">
/*
          .main{
              width: 100%;
              height:100%;
              position: absolute;
              background-color:		#FFFFE0;
          } */
.quarter-div {
	width: 49%;
	height: 300px;
	float: left;
	margin-left: 10px;
}

.green {
	background-color: #FFFFE0;
	margin-top: 40px;
}

.blue {
	background-color: #FFFFE0;
	margin-top: 10px;
}

.pic a {
	text-decoration: none;
	background-size: 100% 100%;
}

.slip {
	width: 800px;
	height: 150px;
	overflow: hidden;
	box-sizing: border-box;
	margin: 0 auto;
	box-sizing: border-box;
	padding: 1px;
}

.pic ul {
	height: 100%;
	padding: 0;
	margin: 0;
	width: 1600px;
}

.pic li {
	list-style: none;
	width: 400px;
	float: left;
	height: 100%;
	position: relative;
	transition: all 0.5s;
	background-size: 100% 100%;
	background-repeat: no-repeat;
}

.pic li div {
	height: 100%;
	width: 200px;
	background-color: rgba(0, 0, 0, 0.5);
	text-align: center;
	line-height: 150px;
	font-size: smaller;
	color: whitesmoke;
}

.topa {
	display: flex;
	width: 800px;
	height: 150px;
	margin: 0 auto 1px auto;
	box-sizing: border-box;
}

.topa a {
	flex: 1;
	margin: 1px;
	background-size: 100%;
}

.atitle {
	background-color: rgba(0, 0, 0, 0.3);
	height: 100%;
	width: 100%;
	transition: all 0.3s;
}

.atitle:hover {
	background-color: rgba(255, 255, 255, 0.3);
}

.bottoma {
	width: 800px;
	height: 200px;
	display: flex;
	flex-wrap: wrap;
	box-sizing: border-box;
	margin: 0 auto
}

.bottoma a {
	box-sizing: border-box;
	padding: 1px;
	width: 200px;
	height: 150px;
	background-clip: content-box;
}

.bottoma a div, .topa a div {
	text-align: center;
	line-height: 150px;
	font-size: smaller;
	color: whitesmoke;
}

.pic {
	display: flex;
	justify-content: space-around;
	margin-top: 20px;
}

.pic>div {
	flex: 1;
	background-color: #FFFFE0;
	min-weight:
}

.pic>:first-child {
	margin: 0 5px 0 10px;
}

.pic>:nth-child(2) {
	margin: 0 10px 0 5px;
}
</style>
</head>

<body>
	<!--幻灯片-->
	<div class="banner">
		<div class="slider">
			<div class="flexslider">
				<ul class="slides">
					<li><a href=""><img src="Assets/upload/banner_a.png"
							alt="古代文献扫一扫\获取简体字" /></a></li>
					<li><a href=""><img src="Assets/upload/banner_b.png"
							alt="" /></a></li>
					<li><a href=""><img src="Assets/upload/banner_c.png"
							alt="" /></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!--幻灯片-->
	<!--主体盒子-->
	<div class="pic">
		<div>
			<div class='topa'>
				<a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/05/quan_jie_tu_shuo22-705x360.jpg);"><div
						class="atitle">劝解图说</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/05/bing_yuan_si_bian22-705x360.jpg);"><div
						class="atitle">兵垣四编</div></a>
			</div>
			<div class='slip'>
				<ul>
					<a href="#"><li id='1'
						style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/05/qian_kun_sheng_yi_tu0-845x321.jpg);"><div>乾坤生意图</div></li>
					</a>
					<a href="#"><li
						style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/04/jian_nan_shi_gao00-845x321.jpg); right: 200px;"
						id='2'><div>剑南诗稿</div></li></a>
					<a href="#">
						<li
						style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/04/sunzi_can_tong01-845x321.jpg); right: 400px"
						id='3'><div>孙子参同</div></li>
					</a>
					<a href="#">
						<li
						style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/04/yin_shi_shu01-845x321.jpg); right: 600px;"
						id='4'><div>饮食书</div></li>
					</a>
				</ul>
			</div>
		</div>
		<div>
			<div class='bottoma'>
				<a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/04/jian_nan_shi_gao00-705x360.jpg);"><div
						class="atitle">剑南诗稿</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2020/02/hong_xue_lou_jiu_zhong_qu0-705x360.jpg);"><div
						class="atitle">红雪楼九种曲</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2019/09/wen_mei_zhai_shi_jian_pu01-705x360.jpg);"><div
						class="atitle">文美斋诗笺谱</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2019/10/fan_yin_dou_ke01-705x360.jpg);"><div
						class="atitle">梵音斗科</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2020/05/yu_sui_zhen_jing01-705x360.jpg);"><div
						class="atitle">玉髓真经</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2021/01/jiu_bian_tu_shuo01-705x360.jpg);"><div
						class="atitle">九边图说</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2019/10/chi_xiu_bai_zhang_qing_gui00-705x360.jpg);"><div
						class="atitle">敕修百丈清规</div></a> <a href="#"
					style="background-image: url(https://new.shuge.org/wp-content/uploads/2020/01/chuan_xi_lu01-705x360.jpg);"><div
						class="atitle">传习录</div></a>
			</div>
		</div>

	</div>

	<div class="banner">
		<div class="main">
			<div class="quarter-div green">
				<img src="Assets/images/banne1.png">
			</div>
			<div class="quarter-div green">
				<img src="Assets/images/banne2.png">
			</div>
		</div>
	</div>
	<div class="banner">
		<div class="main">
			<div class="quarter-div blue">
				<img src="Assets/images/banne3.png">
			</div>
			<div class="quarter-div blue">
				<img src="Assets/images/banne4.png">
			</div>
		</div>
	</div>
	<script>
	var li1=document.getElementById('1')
	var li2=document.getElementById('2')
	var li3=document.getElementById('3')
	var li4=document.getElementById('4')
	li1.onmousemove=()=>{
		li2.style.right=0
		li3.style.right=266+'px'
		li4.style.right=533+'px'
	}
	li2.onmousemove=()=>{
		li2.style.right=266+'px'
		li3.style.right=266+'px'
		li4.style.right=533+'px'
	}
	li3.onmousemove=()=>{
		li2.style.right=266+'px'
		li3.style.right=533+'px'
		li4.style.right=533+'px'
	}
	li4.onmousemove=()=>{
		li2.style.right=266+'px'
		li3.style.right=533+'px'
		li4.style.right=800+'px'
	}
	li1.onmouseleave=()=>{
		li2.style.right=200+'px'
		li3.style.right=400+'px'
		li4.style.right=600+'px'
	}
	li2.onmouseleave=()=>{
		li2.style.right=200+'px'
		li3.style.right=400+'px'
		li4.style.right=600+'px'
	}
	li3.onmouseleave=()=>{
		li2.style.right=200+'px'
		li3.style.right=400+'px'
		li4.style.right=600+'px'
	}
	li4.onmouseleave=()=>{
		li2.style.right=200+'px'
		li3.style.right=400+'px'
		li4.style.right=600+'px'
	}

</script>

</body>
</html>
