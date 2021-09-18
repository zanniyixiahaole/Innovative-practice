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
<style type="text/css">
ul, li {
	list-style: none;
	/*设置标签样式为无,默认值为disc实心圆,circle为空心圆,square为实心方块*/
}

#bigPhoto {
	width: 600px;
	text-align: center;
}

#smallPhotos {
	width: 600px;
	margin: 10px 0;
}

#smallPhotosList {
	margin: 0 auto;
	width: 528px;
	float: left;
	padding: 0px;
}

#smallPhotosList li {
	float: left;
	/* 左浮动*/
	margin-left: 9px;
	/*左边距10px*/
}

.init {
	border: 3px solid #FFFFFF;
	cursor: pointer;
}

.currentPhoto {
	border: 3px solid red;
	cursor: pointer;
}

#smallPhotosList img:hover {
	border: 3px solid #66CD00;
	cursor: pointer;
	/* 鼠标样式*/
}

#prve {
	background: url(http://localhost:8080/FTZ/previous_64.png);
	height: 62px;
	width: 36px;
	display: inline-block;
	/*让span标签变成块级元素*/
	float: left;
	cursor: pointer;
}

#next {
	background: url(http://localhost:8080/FTZ/next_64.png);
	height: 62px;
	width: 36px;
	display: inline-block;
	/*让span标签变成块级元素*/
	float: left;
	cursor: pointer;
}
</style>
<!-- 到这是滚动图片 -->
</head>
<body>
	<div>
		<!-- 这是内容部分 -->
		<div style="float: center; width: 90%;">
			<!--上传pdf部分-->
			<!--选择之前的pdf 部分-->
			<div style="float: center; width: 50%;">
				<form action="" method="get" id="myform">
					<select onchange="ajax_submit();" name="appname" id="selectBook">
						<!--<option value="DoNotCheck">==请选择==</option>-->
						<option disabled selected value="0">==请选择我的PDF识别任务进行识别==</option>
					</select>
				</form>

				<!-- 引入动态放映图片 -->
				<div id="bigPhoto">

					<form method="get" action="#">
						<input type="hidden" value="" id="user" name="user" /> <input
							type="hidden" value="" id="bookurl" name="bookurl" /> <input
							type="hidden" value="" id="recpage" name="recpage" /> <input
							type="hidden" value="" id="bookname" name="bookname" />
						<div
							style="position: relative; width: 400px; height: 528px; left: 100px;">
							<input type="image" style="height: 528px; width: 400px"
								src="http://localhost:8080/FTZ/notFound.jpg" id="bigPhotoSrc" />
							<div
								style="position: absolute; width: 400px; height: 50px; color: #66CD00; z-indent: 2; top: 0;">文字</div>
						</div>
					</form>

				</div>
				<div id="cupage"></div>
				<div id="smallPhotos">
					<!--<span>标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。
				用于对文档中的行内元素进行组合。-->
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
///动态放映图片
var datas=[];
function ajax_submit() {
	datas=[];
    var bookid = $("#selectBook").val();
    //alert(bookid);
    $.ajax({
        type: "post",  //数据提交方式（post/get）
        url: "${pageContext.request.contextPath }/LoadingImgFromOneOfPDF",  //提交到的url
        data: {"bookid":bookid},//提交的数据
        dataType: "json",//返回的数据类型格式
        success: function(msg){
        	for(var i=0;i<msg.length;i++)
       		{
        		var data = {};
        		data["bookurl"] = msg[i].bookurl;
        		data["bookname"] = msg[i].bookname;
        		data["recpage"] = msg[i].recpage;
        		data["recflag"] = msg[i].recflag;
        		datas.push(data);
       		}
        	
        	init();
        	
        }
    });
}



var eg = {};
eg.$ = function(id) {
	return document.getElementById(id);
};
//定义数据
eg.data = [];
eg.rootUrl = "/FTZ/";
eg.groupValue = 1;
eg.groupSize = 4; //每组的数量


function preGroup(){
	if(eg.groupValue>1){
		eg.groupValue -= 1;
		showThumb(eg.groupValue);
	}
}

function nextGroup(){
	if(eg.groupValue<datas.length/eg.groupSize){
		eg.groupValue += 1;
		showThumb(eg.groupValue);
	}
}
 

function showThumb(group) {
	
	var span= eg.$("smallPhotos");
	span.innerHTML = '';

	var start = (group - 1) * eg.groupSize; //计算需要的data数据开始位置
	var end = group * eg.groupSize; //计算需要的data数据开始位置
	if (datas.length>0)
		span.innerHTML = '<span id="prve" onclick="preGroup()"></span> <ul id="smallPhotosList"></ul> <span id="next" onclick="nextGroup()"></span>';
		var ul = eg.$("smallPhotosList");
		ul.innerHTML = ''; //每次显示时清空旧的内容
	for(var i = start;
		(i < end && i < datas.length); i++) {
		//循环数据，并根据数据生成html后插入小图列表中
		var li = document.createElement("li");
		li.innerHTML = '<img src="' +eg.rootUrl + datas[i].bookurl+'/'+datas[i].bookname+'_'+datas[i].recpage+'.png' + '" class="init" id="' + i + '" width="110" height="57" ' + 
		' onclick="change(this)"/>';
		ul.appendChild(li); //追加元素
		

	}
};

function change(obj){
	var ul = eg.$("bigPhoto");
	ul.innerHTML = ''; //每次显示时清空旧的内容
	for(var i=0;i<datas.length;i++)
		{
			if(i==obj.id)
				{
				var cupage = eg.$("cupage");
				cupage.innerHTML='当前第'+datas[i].recpage+'页/一共'+datas.length+'页'
				var str='';
				if(datas[i].recflag==0)
				{
					str='<form method="get" id="formSubmit" action="${pageContext.request.contextPath }/uploadImgOfpdf"> <input type="hidden" value="'
			       		 +datas[i].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
			       		 +datas[i].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
			       		 +datas[i].bookname+'"id="bookname" name="bookname" />'
			       		 +' <div style="position:relative;width:400px;height:528px;left: 100px;" >'
			            	 +'<img src="'+obj.src+'" style="height:528px;width:400px"  />'
			            	+'<div id ="idSubmit" style="cursor:pointer;position:absolute;width:400px;height:528px;color: #66CD00; z-indent:2;top:0;line-height: 528px;text-align: center;font-size:30px" onClick="document.forms[\'formSubmit\'].submit();" >'+"未识别(点击识别)"+'</div>'+'</div>'			            	
			            	+'</form>';
				}else{
					str='<form method="get" action=""> <input type="hidden" value="'
			       		 +datas[i].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
			       		 +datas[i].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
			       		 +datas[i].bookname+'"id="bookname" name="bookname" />'
			       		 +' <div style="position:relative;width:400px;height:528px;left: 100px;" >'
				       		+'<img src="'+obj.src+'" style="height:528px;width:400px"  />'
			            	+'<div style="position:absolute;width:400px;height:528px;color: #66CD00; z-indent:2;top:0;line-height: 528px;text-align: center;font-size:50px" >'+"已识别(无法点击)"+'</div>'+'</div>'		            	
			            	+'</form>';
				}
				 
				 $("#bigPhoto").append(str);
				}
		
		}
	
}
$(function(){
    $("#idSubmit").click(function(){
       $("#formSubmit").submit();
    });
});


function init () {
	showThumb(1); //初始化显示内容
	var thumb1 = eg.$("0")
	if(thumb1 != null){
		var ul = eg.$("bigPhoto");
		var cupage = eg.$("cupage");
		cupage.innerHTML='当前第1页/一共'+datas.length+'页'
		ul.innerHTML = ''; //每次显示时清空旧的内容
	//	alert(msg[0].bookname);
		var str="";
		if(datas[0].recflag==0)
		{
			 str='<form method="get"  id="formSubmit" action="${pageContext.request.contextPath }/uploadImgOfpdf"> <input type="hidden" value="'
		   		 +datas[0].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
		   		 +datas[0].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
		   		 +datas[0].bookname+'"id="bookname" name="bookname" />'
		   		 +' <div style="position:relative;width:400px;height:528px;left: 100px;" >'
		        	//+'<input type="image" style="height:528px;width:400px"  src="'+thumb1.src+'" οnclick="document.formName.submit()"  id="topImg'
		        	 +'<img src="'+thumb1.src+'" style="height:528px;width:400px"  />'
		        	//+datas[0].user+datas[0].bookurl+datas[0].recpage+'"/>'
		        	+'<div  id ="idSubmit" style="cursor:pointer; position:absolute;width:400px;height:528px;color: #66CD00; z-indent:2;top:0;line-height: 528px;text-align: center;font-size:30px" onClick="document.forms[\'formSubmit\'].submit();" >'+"未识别(点击识别)"+'</div>'+'</div>'
		        	
		        	+'</form>';
		}else{
		 	str='<form method="get" action=""> <input type="hidden" value="'
		   		 +datas[0].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
		   		 +datas[0].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
		   		 +datas[0].bookname+'"id="bookname" name="bookname" />'
		   		 +' <div style="position:relative;width:400px;height:528px;left: 100px;" >'
		   		 +'<img src="'+thumb1.src+'" style="height:528px;width:400px"  />'
		        	//+'<input type="image" style="height:528px;width:400px"  src="'+thumb1.src+'" id="topImg'
		        	//+datas[0].user+datas[0].bookurl+datas[0].recpage+'"/>'
		        	+'<div style="position:absolute;width:400px;height:528px;color: #66CD00; z-indent:2;top:0;line-height: 528px;text-align: center;font-size:50px" >'+"已识别(无法点击)"+'</div>'+'</div>'
		        	+'</form>';
		}
		
       // alert(1);
		   $("#bigPhoto").append(str);
	}
};




$(document).ready(function () {
    var datas=[];
    var data = {};
	data["bookid"] = "wu";
	data["bookname"] = "wu";
	data["bookurl"] = "wu";
	data["bookflag"] = "wu";
	datas.push(data);
	var jsonString = JSON.stringify(datas);
	$.ajax({
            url: "${pageContext.request.contextPath }/sendjsonPDF",
            type: "POST",
            data: {"taskFlag":1},//提交的数据
            dataType: "json",//返回的数据类型格式
            success: function (msg) {
            	for(var i=0;i<msg.length;i++)
                {
	                 var strflag="";
	                 var str="";
	                 if(msg[i].bookflag==1)
	                	 {
	                		 strflag="_已识别";
	                	 }
	                 else {
	                	 strflag="_未识别";
	               		  }
				    str= "<option value='"+msg[i].bookid+"'>"+msg[i].bookname+strflag+"</option>";
				  $("#selectBook").append(str);
                }
            }
        });

});

</script>
