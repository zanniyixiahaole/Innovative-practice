<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字后台管理系统</title>
<!-- <link rel="shortcut icon" href="Assets/images/favicon.ico" />  -->
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
</head>
<!--框架样式-->
<frameset rows="95,*,30" cols="*" frameborder="no" border="0"
	framespacing="0">
	<!--top样式-->
	<frame src="admintop" name="topframe" scrolling="no" noresize
		id="topframe" title="topframe" />
	<!--contact样式-->
	<frameset id="attachucp" framespacing="0" border="0" frameborder="no"
		cols="194,12,*" rows="*">
		<frame scrolling="auto" noresize="" frameborder="no" name="leftFrame"
			src="adminleft"></frame>
		<frame id="leftbar" scrolling="no" noresize="" name="switchFrame"
			src="adminswitch"></frame>
		<frame scrolling="auto" noresize="" border="0" name="mainFrame"
			src="adminmain"></frame>
	</frameset>
	<!--bottom样式-->
	<frame src="adminbottom" name="bottomFrame" scrolling="No"
		noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset>
<noframes></noframes>
<!--不可以删除-->
</html>
