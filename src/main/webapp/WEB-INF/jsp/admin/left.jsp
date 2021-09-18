
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧导航menu</title>
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Assets/js/sdmenu.js"></script>
<script type="text/javascript">
	// <![CDATA[
	var myMenu;
	window.onload = function() {
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	// ]]>
</script>
<style type=text/css>
html {
	SCROLLBAR-FACE-COLOR: #538ec6;
	SCROLLBAR-HIGHLIGHT-COLOR: #dce5f0;
	SCROLLBAR-SHADOW-COLOR: #2c6daa;
	SCROLLBAR-3DLIGHT-COLOR: #dce5f0;
	SCROLLBAR-ARROW-COLOR: #2c6daa;
	SCROLLBAR-TRACK-COLOR: #dce5f0;
	SCROLLBAR-DARKSHADOW-COLOR: #dce5f0;
	overflow-x: hidden;
}

body {
	overflow-x: hidden;
	background: url(Assets/images/main/leftbg.jpg) left top repeat-y #f2f0f5;
	width: 194px;
}
</style>
</head>
<body onselectstart="return false;" ondragstart="return false;"
	oncontextmenu="return false;">
	<div id="left-top">
		<div>
			<img src="Assets/images/main/member.gif" width="44" height="44" />
		</div>
		<span>用户：${user.phonenumber} <br>角色：超级管理员
		</span>
	</div>
	<div style="float: left" id="my_menu" class="sdmenu">
		<div class="collapsed">
			<span>用户管理</span>
			<!-- <a href="main.html" target="mainFrame" onFocus="this.blur()">新增用户</a>  -->
			<a href="${pageContext.request.contextPath }/userList"
				target="mainFrame" onFocus="this.blur()">用户信息</a>
		</div>
		<div>
			<span>书籍/图片管理</span> <a
				href="${pageContext.request.contextPath }/pdfList"
				target="mainFrame" onFocus="this.blur()">书籍管理</a> <a
				href="${pageContext.request.contextPath }/photoList"
				target="mainFrame" onFocus="this.blur()">图片管理</a>
			<%-- <a href="${pageContext.request.contextPath }/table" target="mainFrame" onFocus="this.blur()">图片管理</a> --%>
			<a href="${pageContext.request.contextPath }/searchCharAdmin"
				target="mainFrame" onFocus="this.blur()">查找图片文字来源</a> <a
				href="${pageContext.request.contextPath }/searchCharFromPdfAdmin"
				target="mainFrame" onFocus="this.blur()">查找书籍文字来源</a>
		</div>
		<div>
			<span>任务管理</span> <a
				href="${pageContext.request.contextPath }/pdfrenwu?flagPage=0"
				target="mainFrame" onFocus="this.blur()">任务发布</a> <a
				href="${pageContext.request.contextPath }/pdfrenwu?flagPage=1"
				target="mainFrame" onFocus="this.blur()">任务分配</a> <a
				href="${pageContext.request.contextPath }/pdfrenwu?flagPage=2"
				target="mainFrame" onFocus="this.blur()">已分配任务查询与修改</a> <a
				href="${pageContext.request.contextPath }/pdfrenwu?flagPage=3"
				target="mainFrame" onFocus="this.blur()">任务校验</a>
		</div>
		<div>
			<span>留言管理</span> <a href="main.html" target="mainFrame"
				onFocus="this.blur()">分组权限</a> <a href="main_list.html"
				target="mainFrame" onFocus="this.blur()">级别权限</a> <a
				href="main_info.html" target="mainFrame" onFocus="this.blur()">角色管理</a>
			<a href="main.html" target="mainFrame" onFocus="this.blur()">自定义权限</a>
		</div>
		<div>
			<span>书城管理</span> <a href="main.html" target="mainFrame"
				onFocus="this.blur()">分组权限</a> <a href="main_list.html"
				target="mainFrame" onFocus="this.blur()">级别权限</a> <a
				href="main_info.html" target="mainFrame" onFocus="this.blur()">角色管理</a>
			<a href="main.html" target="mainFrame" onFocus="this.blur()">自定义权限</a>
		</div>
	</div>
</body>
</html>