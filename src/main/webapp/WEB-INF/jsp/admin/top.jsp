<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台页面头部</title>
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
</head>
<body onselectstart="return false" oncontextmenu=return(false)
	style="overflow-x: hidden;">
	<!--禁止网页另存为-->
	<noscript>
		<iframe scr="*.htm"></iframe>
	</noscript>
	<!--禁止网页另存为-->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		id="header">
		<tr>
			<td rowspan="2" align="left" valign="top" id="logo"><img
				src="Assets/images/main/logo.jpg" width="74" height="64"></td>
			<td align="left" valign="bottom">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" valign="center" id="header-name">繁体字智能识别平台</td>
						<td align="right" valign="top" id="header-right"><a href=""
							target="topFrame" onFocus="this.blur()" class="admin-out">注销</a>
							<a href="" target="top" onFocus="this.blur()" class="admin-home">管理首页</a>
							<a href="Index" target="_top" onFocus="this.blur()"
							class="admin-index">网站首页</a> <span> <!-- 日历 --> <SCRIPT
									type=text/javascript src="Assets/js/clock.js"></SCRIPT> <SCRIPT
									type=text/javascript>showcal();</SCRIPT>
						</span></td>
					</tr>
				</table>
			</td>
		</tr>

	</table>
</body>
</html>