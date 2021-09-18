<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<script type="text/javascript" src="Assets/js/js_z.js"></script>
<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">
<script src="Assets/js/jquery-1.8.3.min.js"></script>
<script src="Assets/js/smoove.js"></script>
<script type="text/javascript" src="Assets/js/jquery-1.7.2(1).js"></script>
<script type="text/javascript">
</script>
</head>

<body>
	<!--幻灯片-->
	<div>
		<form action="${pageContext.request.contextPath }/fileupload"
			method="post" enctype="multipart/form-data">
			<input id="file_upload" type="file" name="file" value="选择" /> <input
				type="submit" name="识别">
			<div class="image_container">
				<img id="preview" width="600" height="600">
			</div>

		</form>

	</div>

</body>
</html>
<script>
$(function() {
	$("#file_upload").change(function() {
	var $file = $(this);
	var fileObj = $file[0];
	var windowURL = window.URL || window.webkitURL;
	var dataURL;
	var $img = $("#preview");
	 
	if(fileObj && fileObj.files && fileObj.files[0]){
	dataURL = windowURL.createObjectURL(fileObj.files[0]);
	$img.attr('src',dataURL);
	}else{
	dataURL = $file.val();
	var imgObj = document.getElementById("preview");
	// 两个坑:
	// 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
	// 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
	imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image)";
	imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL; 
	}
	});
});
</script>
