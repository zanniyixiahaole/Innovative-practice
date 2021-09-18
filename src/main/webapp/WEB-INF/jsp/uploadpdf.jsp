<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>

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
<style>
#loadDiv {
	display: none;
	width: 100%;
	height: 100%;
	position: fixed;
	z-index: 9999;
	background-color: rgba(235, 235, 235, 0.95);
	top: 0px;
}

#gif {
	margin: auto;
	margin-top: 30%;
	border: 1px solid #f5f5f5;
	background-color: white;
	width: 86px;
	border-radius: 10px;
}

#gifText {
	padding-top: 20px;
	width: 100%;
	color: #5c5c63;
	text-align: center;
}
</style>
</head>
<body>
	<div>
		<div id="loadDiv">
			<div id="gif">
				<img style="padding: 10px" src="Assets/images/wait.gif" _height="64"
					_width="64">
			</div>
			<div id="gifText">
				<div id="loadText">正在验证数据，请稍后！</div>
			</div>
		</div>
	</div>
	<div>
		<input type="file" name="fileName1" id="fileName1" /> <input
			type="button" onclick="sendToUser()" id="sendToUser" value="提交" />


	</div>

	<div>
		<form action="toImagepdf" method="" id="forms">
			<input type="hidden" name="bookid" id="bookid" value="" />
		</form>
	</div>
</body>

<script type="text/javascript"> 
function LoadDivs(flg) {

    var s = null;

    document.getElementById("loadDiv").style.display = flg == true ? "block" : "none";      

    if (flg) {

        var index = 0;

        var text = ["正在验证数据，请稍后！", "正在连接消息服务器，请稍后！", "正在加载数据，请稍后！"];

        s = setInterval(function () {

            document.getElementById("loadText").innerText = text[index] || "正在验证数据，请稍后！";
            index++;
            if (index > text.length - 1) {

                index = 0;

            }

        }, 2000);
    } else {
        if (s != null && s != undefined) {
            clearInterval(s);
        }
    }
}
function sendToUser(){ //在这里进行ajax 文件上传 用户的信息 
	var $file1 = $("input[name='fileName1']").val();//用户文件内容(文件)
	// 判断文件是否为空 
	if ($file1 == "") {
		alert("请选择上传的目标文件! ")
		return false;
	}
	//判断文件类型,我这里根据业务需求判断的是Excel文件
	var fileName1 = $file1.substring($file1.lastIndexOf(".") + 1).toLowerCase();
	if(fileName1 != "pdf" ){
      	alert("请选择pdf文件!");				
		return false;
	}
	//判断文件大小
	var size1 = $("input[name='fileName1']")[0].files[0].size;
	if (size1>104857600) {
		alert("上传文件不能大于100M!");
		return false;				
	}
	LoadDivs(true);
	boo1 = true;
var type = "file";
var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
formData.append(type,$("#fileName1")[0].files[0]);
$.ajax({
	type : "post",
	url : "${pageContext.request.contextPath}/SavePDF",
	data : formData,
	processData : false,
	contentType : false,
	success : function(data){
		if (data=="error") {
			LoadDivs(false);
			alert("文件提交失败!");
			
		}else{
			LoadDivs(false);
			var form = document.getElementById('forms');
			document.getElementById('bookid').value=data;
			form.submit();
		
	}}
});
}
</script>

</html>

