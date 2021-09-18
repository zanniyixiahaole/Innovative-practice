
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
<!-- 滚动图片用到的css -->
<style type="text/css">
ul, li {
	list-style: none;
	/*设置标签样式为无,默认值为disc实心圆,circle为空心圆,square为实心方块*/
}

#bigPhoto {
	width: 1150px;
	text-align: center;
}

#smallPhotos {
	width: 1150px;
	margin: 10px 0;
}

#smallPhotosList {
	margin: 0 auto;
	width: 1078px;
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
	background: url(/FTZ/previous_64.png);
	height: 62px;
	width: 36px;
	display: inline-block;
	/*让span标签变成块级元素*/
	float: left;
	cursor: pointer;
}

#next {
	background: url(/FTZ/next_64.png);
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
	<!--幻灯片-->
	<div id="bigPhoto">

		<form method="get" action="#">
			<input type="hidden" value="" id="user" name="user" /> <input
				type="hidden" value="" id="bookurl" name="bookurl" /> <input
				type="hidden" value="" id="recpage" name="recpage" /> <input
				type="hidden" value="" id="bookname" name="bookname" />
			<div style="position: relative; width: 1080px; height: 768px;">
				<input type="image" style="height: 768px; width: 1080px"
					src="/FTZ/notFound.jpg" id="bigPhotoSrc" />
				<div
					style="position: absolute; width: 1080px; height: 50px; color: #66CD00; z-indent: 2; top: 0;">文字</div>
			</div>

		</form>

	</div>
	<div id="smallPhotos">
		<!--<span>标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。
		用于对文档中的行内元素进行组合。-->
		<span id="prve" onclick="preGroup()"></span>
		<ul id="smallPhotosList"></ul>
		<span id="next" onclick="nextGroup()"></span>
	</div>
	<!--<img  style="height:940px;width:100%" src="//FTZ//TestPDF//A//A_1.png" id="topImg"/>-->

</body>
</html>
<script>
var datas=[];
var eg = {};
eg.$ = function(id) {
	return document.getElementById(id);
};
//定义数据
eg.data = [];
eg.rootUrl = "/FTZ/";
eg.groupValue = 1;
eg.groupSize = 7; //每组的数量


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
	var ul = eg.$("smallPhotosList");
	ul.innerHTML = ''; //每次显示时清空旧的内容
	var start = (group - 1) * eg.groupSize; //计算需要的data数据开始位置
	var end = group * eg.groupSize; //计算需要的data数据开始位置
	for(var i = start;
		(i < end && i < datas.length); i++) {
		//循环数据，并根据数据生成html后插入小图列表中
		var li = document.createElement("li");
		li.innerHTML = '<img src="' + '/FTZ/'+datas[i].user+'/PDF/'+datas[i].bookurl+'/'+datas[i].bookname+'_'+datas[i].recpage+'.png' + '" class="init" id="' + i + '" width="128" height="57" ' + 
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
				var str='';
				if(datas[i].recflag==1)
				{
					str='<form method="get" action="${pageContext.request.contextPath }/uploadImgOfpdf"> <input type="hidden" value="'
						+datas[i].user+'"id="user" name="user" /><input type="hidden" value="'
			       		 +datas[i].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
			       		 +datas[i].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
			       		 +datas[i].bookname+'"id="bookname" name="bookname" />'
			       		 +' <div style="position:relative;width:450px;height:550px;left: 350px;" >'
			            	+'<input type="image"  style="width:450px;height:550px"  src="'+obj.src+'" οnclick="document.formName.submit()" id="topImg'
			            	+datas[i].user+datas[i].bookurl+datas[i].recpage+'"/>'
			            	+'<div style="position:absolute;width:450px;height:50px;color: #66CD00; z-indent:2;top:0;">'+"未识别"+'</div>'+'</div>'
			            	+'</form>';
				}else{
					str='<form method="get" action=""> <input type="hidden" value="'
						+datas[i].user+'"id="user" name="user" /><input type="hidden" value="'
			       		 +datas[i].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
			       		 +datas[i].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
			       		 +datas[i].bookname+'"id="bookname" name="bookname" />'
			       		+' <div style="position:relative;width:450px;height:550px;left: 350px;" >'
				       		+'<img src="'+obj.src+'" style="width:450px;height:550px"   />'
			            	//+'<input type="image"  style="height:528px;width:400px" src="'+obj.src+'" id="topImg'
			            	///+datas[i].user+datas[i].bookurl+datas[i].recpage+'"/>'
			            	+'<div style="position:absolute;width:450px;height:50px;color: #66CD00; z-indent:2;top:0;">'+"已识别"+'</div>'+'</div>'
			            	+'</form>';
				}
				 
				 $("#bigPhoto").append(str);
				}
		
		}
	
}

//function submita(){
//	datas=[];
//	document.getElementById("form").submit(); // js写法
	//$("#form").submit(); // jquery写法
//}
function init () {
	showThumb(1); //初始化显示内容
	var thumb1 = eg.$("0")
	if(thumb1 != null){
		var ul = eg.$("bigPhoto");
		ul.innerHTML = ''; //每次显示时清空旧的内容
	//	alert(msg[0].bookname);
		var str="";
		if(datas[0].recflag==1)
		{
			 str='<form method="get" action="${pageContext.request.contextPath }/uploadImgOfpdf"> <input type="hidden" value="'
				+datas[0].user+'"id="user" name="user" /><input type="hidden" value="'
		   		 +datas[0].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
		   		 +datas[0].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
		   		 +datas[0].bookname+'"id="bookname" name="bookname" />'
		   		 +' <div style="position:relative;width:450px;height:550px;left: 350px;" >'
		        	+'<input type="image" style="width:450px;height:550px"  src="'+thumb1.src+'" οnclick="document.formName.submit()" id="topImg'
		        	+datas[0].user+datas[0].bookurl+datas[0].recpage+'"/>'
		        	+'<div style="position:absolute;width:450px;height:50px;color: #66CD00; z-indent:2;top:0;">'+"未识别"+'</div>'+'</div>'
		        	+'</form>';
		}else{
		 	str='<form method="get" action=""> <input type="hidden" value="'
				+datas[0].user+'"id="user" name="user" /><input type="hidden" value="'
		   		 +datas[0].bookurl+'"id="bookurl" name="bookurl" /> <input type="hidden" value="'
		   		 +datas[0].recpage+'"id="recpage" name="recpage" /><input type="hidden" value="'
		   		 +datas[0].bookname+'"id="bookname" name="bookname" />'
		   		 +' <div style="position:relative;width:450px;height:550px;left: 350px;" >'
		   		 +'<img src="'+thumb1.src+'" style="width:450px;height:550px"  />'
		        	//+'<input type="image" style="height:528px;width:400px"  src="'+thumb1.src+'" id="topImg'
		        	//+datas[0].user+datas[0].bookurl+datas[0].recpage+'"/>'
		        	+'<div style="position:absolute;width:450px;height:50px;color: #66CD00; z-indent:2;top:0;">'+"已识别"+'</div>'+'</div>'
		        	+'</form>';
		}
		
       // alert(1);
		   $("#bigPhoto").append(str);
	}
};


$(document).ready(function () {
    var datass=[];
    var data = {};
    data["user"] = "wu";
	data["recpage"] = "wu";
	data["bookname"] = "wu";
	data["recflag"] = "wu";
	datass.push(data);
	var jsonString = JSON.stringify(datass);
	//var str='<div style="height:1000px;width:100%"><div style="height: 60px ;width: 100%;text-align:left;line-height:60px"><font size="4"   color="#000000"  ><font style="font-weight: bold"  ></font></font></div><img  style="height:940px;width:100%" src="'+'E:/FTZ/123456/PDF/李禄马-大学成绩单/李禄马-大学成绩单_1.png" id="topImg"/></div>'
    //  $("#insert").append(str);
	$.ajax({
            url: "${pageContext.request.contextPath }/sendjsonImgFromPDF",
            type: "POST",
            dataType: 'json',
            data: jsonString,
            success: function (msg) {
            	
            	for(var i=0;i<msg.length;i++)
           		{
            		//alert(2);
            		var data = {};
            	    data["user"] = msg[i].user;
            		data["bookurl"] = msg[i].bookurl;
            		data["bookname"] = msg[i].bookname;
            		data["recpage"] = msg[i].recpage;
            		data["recflag"] = msg[i].recflag;
            		datas.push(data);
            	//	alert(datas[i]);
           		}
            	
            	init();
            }
        });



});


</script>
