<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>展开合闭按钮</title>
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script language="javascript">
	var topFrame = parent.document.getElementById('topframe');
	var topBarFrame = parent.document.getElementById('topbar');
	var leftFrame = parent.document.getElementById('leftFrame');
	var barFrame = parent.document.getElementById('leftbar');
	var rightFrame = parent.document.getElementById('rightFrame');
	function switchSysBar(){
		if(topFrame.style.height != "0px"){
			topFrame.style.height = "0px";
			topBarFrame.style.position = "absolute";
			leftFrame.style.position = "absolute";
			barFrame.style.position = "absolute";
			rightFrame.style.position = "absolute";
			if(leftFrame.style.width == "0px"){
			} else {
				leftFrame.style.top = "12px";	
			}
			topBarFrame.style.top = "0px";
			barFrame.style.top = "12px";
			rightFrame.style.top = "12px";
			document.getElementById('topbar').style.display="";
			document.getElementById('bottombar').style.display="none";
		} else {
			topFrame.style.height = "95px";
			topBarFrame.style.position = "absolute";
			leftFrame.style.position = "absolute";
			barFrame.style.position = "absolute";
			rightFrame.style.position = "absolute";
			if(leftFrame.style.width == "0px"){
			} else {
				leftFrame.style.top = "107px";	
			}
			topBarFrame.style.top = "95px";
			barFrame.style.top = "107px";
			rightFrame.style.top = "107px";
			document.getElementById('topbar').style.display="none";
			document.getElementById('bottombar').style.display="";
		}
	 }
	function load(){
	 	if (topFrame.style.height != "0px"){
	 		document.getElementById('topbar').style.display="none";
	 	} 
	}
</script>
</head>
<body marginwidth="0" marginheight="0" onLoad="load()" topmargin="0"
	leftmargin="0" onselectstart="return false" oncontextmenu=return(false)
	style="overflow-x: hidden;">
	<center>
		<table height="100%" cellspacing="0" cellpadding="0" border="0"
			width="100%">
			<tbody>
				<tr>
					<td bgcolor="#ededb1" width="1"></td>
					<td id="topbar"
						style="display: none; background: url(Assets/images/main/switchbg1.png) repeat-y #d2d2d0 0px 0">
						<a onClick="switchSysBar()" href="javascript:void(0);"> <img
							src="Assets/images/main/pic26.png" width="72" height="12"
							border="0" alt="隐藏菜单" title="显示菜单">
					</a>
					</td>
					<td id="bottombar"
						style="background: url(Assets/images/main/switchbg.jpg) repeat-y #f2f0f5 0px 0">
						<a onClick="switchSysBar()" href="javascript:void(0);"> <img
							src="Assets/images/main/pic25.png" width="72" height="12"
							border="0" alt="隐藏菜单" title="隐藏菜单">
					</a>
					</td>
				</tr>
			</tbody>
		</table>
	</center>
</body>
</html>