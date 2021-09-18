<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字智能识别平台</title>
<!-- <link rel="shortcut icon" href="Assets/images/favicon.ico" />  -->
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script type="text/javascript" src="layui/layui.js" charset="utf-8"></script>
<script>
		 layui.use('layer',function(){});
	 </script>
</head>
<style>
body {
	margin: 0;
	padding: 0;
	border: 0;
	overflow: hidden;
	height: 100%;
	max-height: 100%;
}

#topframe {
	position: absolute;
	top: 0;
	left: 0;
	height: 95px;
	width: 100%;
	overflow: hidden;
	vertical-align: middle;
}

#topbar {
	position: fixed;
	top: 95px;
	left: 0;
	height: 12px;
	width: 100%;
	overflow: hidden;
	vertical-align: top;
}

#leftFrame {
	position: fixed;
	top: 107px;
	left: 0;
	height: 100%;
	width: 194px;
	overflow: hidden;
	vertical-align: top;
}

#leftbar {
	position: fixed;
	top: 107px;
	left: 194px;
	height: 100%;
	width: 12px;
	overflow: hidden;
	vertical-align: top;
}

#rightFrame {
	position: absolute;
	left: 206px;
	top: 107px;
	height: 100%;
	right: 0;
	bottom: 0;
	overflow: hidden;
}
</style>
<body>
	<iframe id="topframe" src="admintop" name="topframe" scrolling="no"
		frameborder="no" border="0"></iframe>
	<iframe id="topbar" src="adminTopSwitch" name="topSwitchFrame"
		scrolling="no" frameborder="no" border="0"></iframe>
	<iframe id="leftFrame" src="adminleft" frameborder="no" border="0"></iframe>
	<iframe id="leftbar" name="switchFrame" src="adminswitch"
		frameborder="no" border="0"></iframe>
	<iframe id="rightFrame" name="mainFrame" src="adminmain"
		frameborder="no" border="0"></iframe>
	<script>
    	var width = screen.width - 206;
	 	document.getElementById("rightFrame").style.width = width+"px";
	 	document.getElementById("rightFrame").width = width+"px";
	</script>
</body>
<!--框架样式-->
<!--<frameset rows="95,*,30" cols="*" frameborder="no" border="0"
	framespacing="0">
	top样式
	<frame src="admintop" name="topframe" scrolling="no" noresize
		id="topframe" title="topframe" />
	contact样式
	<frameset id="attachucp" framespacing="0" border="0" frameborder="no"
		cols="194,12,*" rows="*">
		<frame scrolling="auto" noresize="" frameborder="no" name="leftFrame"
			src="adminleft"></frame>
		<frame id="leftbar" scrolling="no" noresize="" name="switchFrame"
			src="adminswitch"></frame>
		<frame scrolling="auto" noresize="" border="0" name="mainFrame"
			src="adminmain"></frame>
	</frameset>
	bottom样式
	<frame src="adminbottom" name="bottomFrame" scrolling="No"
		noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset>
<noframes></noframes>-->
<!--不可以删除-->
</html>
