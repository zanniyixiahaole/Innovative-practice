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
		<span>用户：${user.phonenumber }<br>角色：普通用户
		</span>
	</div>
	<div style="float: left" id="my_menu" class="sdmenu">
		<div class="collapsed">
			<span>个性设置</span> <a href="personInformation" target="mainFrame"
				onFocus="this.blur()">用户信息</a> <a href="ChangPassword"
				target="mainFrame" onFocus="this.blur()">修改密码</a> <a
				href="Changeinfo" target="mainFrame" onFocus="this.blur()">修改信息</a>
		</div>
		<div>
			<span>书籍/图片管理</span> <a
				href="${pageContext.request.contextPath }/personalPdfList"
				target="mainFrame" onFocus="this.blur()">书籍管理</a> <a
				href="${pageContext.request.contextPath }/personalPhotoList"
				target="mainFrame" onFocus="this.blur()">图片管理</a> <a
				href="${pageContext.request.contextPath }/searchChar"
				target="mainFrame" onFocus="this.blur()">查找图片文字来源</a> <a
				href="${pageContext.request.contextPath }/searchCharFromPdf"
				target="mainFrame" onFocus="this.blur()">查找书籍文字来源</a>
		</div>
		<div>
			<span>任务管理</span> <a
				href="${pageContext.request.contextPath }/TaskManageList?flag=0"
				target="mainFrame" onFocus="this.blur()">任务领取</a>
			<!-- <a href="pdfrenwu" target="mainFrame" onFocus="this.blur()">任务领取</a> -->
			<a href="${pageContext.request.contextPath }/TaskManageList?flag=1"
				target="mainFrame" onFocus="this.blur()">我的任务</a>
		</div>
		<div>
			<span>留言管理</span> <a href="personreply?page=1&size=10"
				target="mainFrame" onFocus="this.blur()">我的留言/回复</a> <a
				href="personfeedback?page=1&size=10" target="mainFrame"
				onFocus="this.blur()">我的反馈</a> <a href="addfeedback"
				target="mainFrame" onFocus="this.blur()">反馈</a>
		</div>
	</div>
</body>
</html>