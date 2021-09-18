<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>recognizeDetail</title>

</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style type="TEXT/CSS">
body {
	width: 100%;
	overflow: hidden
}
</style>
<%
	String sourcePhotoSrc = (String) request.getAttribute("sourcePhotoSrc");
	String simplifiedPhotoSrc = (String) request.getAttribute("simplifiedPhotoSrc");
%>
<body bgcolor="#E6E6FA">
	<div class="mydiv">
		<img id="sourcePhoto" src="<%=sourcePhotoSrc %>" width="600"
			height="580" /> <img id="simplifiedPhoto"
			src="<%=simplifiedPhotoSrc %>" width="600" height="580" />
	</div>
	<script type="text/javascript">
		$(window).resize(function() {
			$(".mydiv").css({
				position : "absolute",

				top : ($(window).height() - $(".mydiv").outerHeight()) / 2,
				left : ($(window).width() - $(".mydiv").outerWidth()) / 2
			});
		});
		$(function() {
			$(window).resize();
		});
	</script>
</body>
</html>