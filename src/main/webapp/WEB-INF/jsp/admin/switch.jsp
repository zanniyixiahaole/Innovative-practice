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
var leftFrame = parent.document.getElementById('leftFrame');
var barFrame = parent.document.getElementById('leftbar');
var rightFrame = parent.document.getElementById('rightFrame');
function switchSysBar(){
	if(leftFrame.style.width != "0px"){
		leftFrame.style.width = "0px";
		barFrame.style.position = "absolute";
		rightFrame.style.position = "absolute";
		if(topFrame.style.height == "0px"){
			barFrame.style.top = "12px";				
			rightFrame.style.top = "12px";				
		} else {
			barFrame.style.top = "107px";				
			rightFrame.style.top = "107px";				
		}
		barFrame.style.left = "0px";
		rightFrame.style.left = "12px";
		var width = screen.width - 12;
		rightFrame.width = width + "px";
		rightFrame.style.width = width + "px";
		document.getElementById('leftbar').style.display="";
		document.getElementById('rightbar').style.display="none";
	} else {
		leftFrame.style.width = "194px";
		barFrame.style.position = "absolute";
		rightFrame.style.position = "absolute";
		if(topFrame.style.height == "0px"){
			leftFrame.style.top = "12px";
			barFrame.style.top = "12px";				
			rightFrame.style.top = "12px";				
		} else {
			leftFrame.style.top = "107px";				
			barFrame.style.top = "107px";				
			rightFrame.style.top = "107px";				
		} 
		barFrame.style.left = "194px";
		rightFrame.style.left = "206px";
		var width = screen.width - 12 - 194;
		rightFrame.width = width + "px";
		rightFrame.style.width = width + "px";
		document.getElementById('leftbar').style.display="none";
		document.getElementById('rightbar').style.display="";
	}
 }
function load(){
 	if (leftFrame.style.width != "0px"){
 		document.getElementById('leftbar').style.display="none";
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
					<td id="leftbar"
						style="display: none; background: url(Assets/images/main/switchbg.jpg) repeat-y #d2d2d0 0px 0">
						<a onClick="switchSysBar()" href="javascript:void(0);"> <img
							src="Assets/images/main/pic24.jpg" width="12" height="72"
							border="0" alt="隐藏左侧菜单" title="显示左侧菜单">
					</a>
					</td>
					<td id="rightbar"
						style="background: url(Assets/images/main/switchbg.jpg) repeat-y #f2f0f5 0px 0">
						<a onClick="switchSysBar()" href="javascript:void(0);"> <img
							src="Assets/images/main/pic23.jpg" width="12" height="72"
							border="0" alt="隐藏左侧菜单" title="隐藏左侧菜单">
					</a>
					</td>
				</tr>
			</tbody>
		</table>
	</center>
</body>
</html>