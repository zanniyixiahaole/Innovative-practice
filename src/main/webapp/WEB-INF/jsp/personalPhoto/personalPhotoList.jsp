<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title></title>

<!-- 将xml转为JSON对象 -->
<script src="Assets/js/xml2json.js"></script>
<script src="Assets/js/jszip.min.js"></script>
<script src="Assets/js/FileSaver.js"></script>
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<style type="text/css">
body {
	background: #AEEEEE url() no-repeat left top;
	background-size: 100%;
}

ul, li {
	list-style: none;
	/*设置标签样式为无,默认值为disc实心圆,circle为空心圆,square为实心方块*/
}

#bigPhoto {
	width: 1224px;
	text-align: center;
}

#smallPhotos {
	width: 1224px;
	margin: 10px 0;
}

#smallPhotosList {
	margin: 0 auto;
	width: 1152px;
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
	background: url(Assets/images/previous_64.png);
	height: 62px;
	width: 36px;
	display: inline-block;
	/*让span标签变成块级元素*/
	float: left;
	cursor: pointer;
}

#next {
	background: url(Assets/images/next_64.png);
	height: 62px;
	width: 36px;
	display: inline-block;
	/*让span标签变成块级元素*/
	float: left;
	cursor: pointer;
}
</style>

</head>

<body>
	<div id="bigPhoto">
		<img id="bigPhotoSrc" src="Assets/images/notFound.jpg" width="1080"
			height="768" border="0" data-method="setTop" />
	</div>
	<div id="smallPhotos">
		<!--<span>标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。
			用于对文档中的行内元素进行组合。-->
		<span id="prve" onclick="preGroup()"></span>
		<ul id="smallPhotosList"></ul>
		<span id="next" onclick="nextGroup()"></span>
	</div>
	<script src="layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
			var eg = {};
			eg.$ = function(id) {
				return document.getElementById(id);
			};
			//定义数据
			eg.data = [];
			eg.rootUrl = "/FTZ/";
			<%
			List<String> urls = (List)request.getAttribute("urls");
			for(String currentValue : urls){
			%>
				eg.data.push("<%=currentValue%>");
			<%
			}
			%> 			
			//eg.indexValue表示当前显示的是第几条数据
			eg.indexValue = <%=(Integer)request.getAttribute("indexValue")%>;
			eg.groupSize = 8; //每组的数量
			//eg.groupValue表示当前显示的是第几页数据
			eg.groupValue = Math.ceil(eg.indexValue / eg.groupSize);
			/* function toDetail(obj){
				window.location.href="http://localhost:8080/ssmAndDl4j/recognizeDetail2?photoSrc="+obj.src;
			} */
			function change(obj){
				document.getElementById("bigPhotoSrc").src=obj.src;
				var pics = document.getElementsByTagName("img");
				for(var i=0;i<pics.length;i++){
					pics[i].setAttribute("class","init");
				}
				obj.setAttribute("class","currentPhoto");
				eg.indexValue = parseInt(obj.id.split("_")[1]);
			}

			function preGroup(){
				if(eg.groupValue>1){
					eg.groupValue -= 1;
					eg.showThumb(eg.groupValue);
				}
				
			}
			

			function nextGroup(){
				if(eg.groupValue<eg.data.length/eg.groupSize){
					eg.groupValue += 1;
					eg.showThumb(eg.groupValue);
				}
			}


			eg.showThumb = function(group) {
				var ul = eg.$("smallPhotosList");
				ul.innerHTML = ''; //每次显示时清空旧的内容
				var start = (group - 1) * eg.groupSize; //计算需要的data数据开始位置
				var end = group * eg.groupSize; //计算需要的data数据开始位置
				for(var i = start;
					(i < end && i < eg.data.length); i++) {
					//循环数据，并根据数据生成html后插入小图列表中
					var li = document.createElement("li");
					li.innerHTML = '<img src="' + eg.rootUrl + eg.data[i] + '" class="init" id="thumb_' + (i+1) + '" width="128" height="57" ' + 
					' onclick="change(this)"/>';
					ul.appendChild(li); //追加元素
				}
			};

			 
			eg.init = function() {
				eg.showThumb(eg.groupValue); //初始化显示内容
				var thumb = eg.$("thumb_"+eg.indexValue);
				if(thumb != null){
					thumb.setAttribute("class","currentPhoto");
					eg.$("bigPhotoSrc").src = thumb.src;
				}
			};
			eg.init();
		
		</script>
	<script>
		layui.use('layer', function(){ //独立版的layer无需执行这一句
		  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
		  
		  //触发事件
		  var active = {
			setTop: function(){
				var httpRequest = new XMLHttpRequest();//第一步：建立所需的对象
				var photoSrc = this.src;
				var url = "${pageContext.request.contextPath }/selectRecognized?photoSrc=" + photoSrc;
		        httpRequest.open('GET', url, true);//第二步：打开连接  将请求参数写在url中  ps:"./Ptest.php?name=test&nameone=testone"
		        httpRequest.send();//第三步：发送请求  将请求参数写在URL中
		        /**
		         * 获取数据后的处理程序
		         */
		        httpRequest.onreadystatechange = function () {
		            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
		                var json = httpRequest.responseText;//获取到json字符串，还需解析
		                //console.log(json);
		                if(json=="1"){
			  			  	//多窗口模式，层叠置顶
			  			  	parent.layer.open({
				  				type: 2 //此处以iframe举例
				  				,title: '图片识别详情'
				  				,area: ['1215px', '700px']
				  				,shade: 0
				  				,maxmin: true
				  				,offset: 'auto' 
			  					,moveOut: true
				  				,content: '${pageContext.request.contextPath }/recognizeDetail2?photoSrc=' + photoSrc
				  				,btn: ['下载图片和文字','全部关闭'] //只是为了演示
				  				,yes: function(){//下载图片和文字
				  					//取得xml文件路径
				  					var xmlSrc = photoSrc.substring(0,photoSrc.lastIndexOf(".")) + ".xml";
				  					function loadXMLDoc(dname) {
				  					    if (window.XMLHttpRequest) {
				  					        xhttp=new XMLHttpRequest();
				  					    }
				  					    else {
				  					        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  					    }
				  					    xhttp.open("GET",dname,false);
				  					    xhttp.send();
				  					    return xhttp.responseXML;
				  					}
				  					var xmlDoc = loadXMLDoc(xmlSrc);
				  					var x2js = new X2JS();
				  					var jsonObj = x2js.xml2json(xmlDoc);//xml2json
				  					var jsonData = jsonObj.wordandpoints;
				  					//处理jsonData得到wordData
				  					var wordData = "";
				  					for(var i=0;i<jsonData.point.length;i++){
				  						wordData+=(jsonData.point[i].word + " ");
				  					}
				  					// 初始化一个zip打包对象
				  					var zip = new JSZip();
				  					// 创建一个被用来打包的名为Hello.txt的文件
				  					zip.file("word.txt", wordData +"\n");
				  					var img = photoSrc;
				  					var ext = img.substring(img.lastIndexOf(".")+1).toLowerCase();
					  				//var img = "http://127.0.0.1/base64/1.jpg";
					  				function getBase64Image(img) {
					  				  var canvas = document.createElement("canvas");
					  				  canvas.width = img.width;
					  				  canvas.height = img.height;
					  				  var ctx = canvas.getContext("2d");
					  				  ctx.drawImage(img, 0, 0, img.width, img.height);
					  				  var dataURL = canvas.toDataURL("image/"+ext);
					  				  return dataURL;
					  				}
					  				var image = new Image();
					  				image.crossOrigin = '';
					  				image.src = img;
					  				image.onload = function(){
					  				  	var base64 = getBase64Image(image);
					  				  	var imgData = base64.split(",")[1];
					  				 	//console.log(imgData);
					  					// 创建一个base64数据为imgData的图像，图像名是smile.gif
					  					zip.file("photo." + ext, imgData, {base64: true});
					  					// 把打包内容异步转成blob二进制格式
					  					zip.generateAsync({type:"blob"}).then(function(content) {
					  					    // content就是blob数据，这里以example.zip名称下载    
					  					    // 使用了FileSaver.js  
					  					    saveAs(content, "data.zip");
					  					});
					  				};
				  				}
				  				,btn2: function(){
				  					parent.layer.closeAll();
				  				}
				  				,zIndex: layer.zIndex //重点1
				  				,success: function(layero){
				  					parent.layer.setTop(layero); //重点2
				  				}
				  			});
		                } else {
		                	layer.open({
		                		title: '图片识别提示'
		                		,content:'该图片未识别下载，是否现在进行识别？'
		                		,btn:['是','否']
		                		,yes:function(){
		                			window.location.href="${pageContext.request.contextPath }/afterwardRecognized?photoSrc="
	                					+ photoSrc + "&indexValue=" + eg.indexValue + "&fromList=photoList";
		                		}
		                		,btn2:function(){
		                			
		                		}
		                		,cancel:function(){
		                			
		                		}
		                	});
		                }
		            }
		        };
			}
		  };
			
		  
		  $('#bigPhotoSrc').on('click', function(){
			var othis = $(this), method = othis.data('method');
			active[method] ? active[method].call(this, othis) : '';
		  });
		  
		});
		</script>
</body>

</html>