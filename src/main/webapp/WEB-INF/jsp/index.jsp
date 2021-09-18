<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字识别平台</title>
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<script type="text/javascript" src="Assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="Assets/plugins/FlexSlider/jquery.flexslider.js"></script>
<link rel="stylesheet" type="text/css"
	href="Assets/plugins/FlexSlider/flexslider.css">
<script type="text/javascript" src="Assets/js/js_z.js"></script>

<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">
<script language="javascript">
window.onresize = function () {
    reinitIframe();
}
function reinitIframe(){
    var iframe = document.getElementById("menuFrame");
    try{
        var bHeight = iframe.contentWindow.document.body.scrollHeight;
        var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
        var height = Math.min(bHeight, dHeight);
        iframe.height = height+50;
        // console.log(iframe.height);
    }catch (ex){}
}
// 定时触发
window.setInterval("reinitIframe()", 200);

</script>
</head>

<body>
	<%@ include file="head.jsp"%>
	<!--主体盒子-->
	<iframe name="menuFrame" id="menuFrame" onload="reinitIframe()"
		style="overflow: visible;" scrolling="no" height="100%" width="100%"
		src="${pageContext.request.contextPath }/first">
		<p>你的浏览器不支持iframe标签</p>
	</iframe>

	<%@ include file="foot.jsp"%>
</body>
</html>
