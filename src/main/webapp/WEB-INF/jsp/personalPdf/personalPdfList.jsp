<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">

<link rel="stylesheet" href="Assets/bookStoreShow/bootstrap.min.css" />
<link rel="stylesheet" href="Assets/bookStoreShow/flat-ui.min.css" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script src="Assets/bookStoreShow/jquery-1.11.3.min.js"></script>
<script src="Assets/bookStoreShow/bootstrap.min.js"></script>
<script src="Assets/bookStoreShow/flat-ui.min.js"></script>
<!-- 将xml转为JSON对象 -->
<script src="Assets/js/xml2json.js"></script>
<script src="Assets/js/jszip.min.js"></script>
<script src="Assets/js/FileSaver.js"></script>
<title></title>
<style>
body {
	background: url("Assets/images/pdfBackground.JPG");
	background-size: 100%;
}

.row {
	margin-top: 20px;;
}

.center {
	text-align: center;
}

.pagination {
	background: #cccccc;
}

.btn {
	margin-bottom: 3px;
}
/* 在个人中心进行查看书籍时高度溢出，看不到底部分页组件，所以在底部加了200px高度的div代替溢出 */
#uselessDiv {
	height: 200px;
}
</style>
</head>
<body>

	<!--content-->
	<div class="container">
		<div class="row" id="rowDiv"></div>
		<nav class="center">
			<div id="demo7"></div>
		</nav>
		<div id="uselessDiv"></div>
		<script src="layui/layui.js" charset="utf-8"></script>
		<script>
		var userId = <%= request.getAttribute("userId")%>; 
		var eg = {};
		eg.data = ${bookInfoJson};
		//console.log(eg.data);
		eg.rootUrl = "/FTZ/" ;
		function change(obj){
			var rowDiv = document.getElementById("rowDiv");
			rowDiv.innerHTML = ''; //每次显示时清空旧的内容
			var start = (obj.curr - 1) * obj.limit; //计算需要的data数据开始位置
			var end = obj.curr * obj.limit; //计算需要的data数据开始位置
			for(var i = start;i < end && i < eg.data.length; i++) {
				//循环数据，并根据数据生成html后插入小图列表中
				var div = document.createElement("div");
				div.className = "col-sm-4 col-md-3";
				Date.prototype.format = function(formatStr){   
			        var str = formatStr;  
			        str=str.replace(/yyyy|YYYY/,this.getFullYear());  
			        str=str.replace(/MM/,(this.getMonth()+1)>9?(this.getMonth()+1).toString():'0' + (this.getMonth()+1));   
			        str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());   
			       return str;   
				}
				var dateTime = new Date(eg.data[i].dateTime).format("yyyy-MM-dd");
				var bookNameTrans = eg.data[i].bookName.length>10?eg.data[i].bookName.substr(0,10)+"..":eg.data[i].bookName;
				div.innerHTML = '<div class="thumbnail" >'
				+	'<img style="width: 100%; height: 300px; display: block;" alt="100%x300" src="' + eg.rootUrl + eg.data[i].bookUrl + '/' + eg.data[i].bookName + '_1.png' +'" data-holder-rendered="true" title="' + eg.data[i].bookName + '">'
				+	'<div class="caption center">'
					+	'<p><span>书籍名称:</span><span>' + bookNameTrans + '</span></p>'
					+	'<p><span>上传时间:</span><span>' + dateTime + '</span></p>'
					+	'<p><span>页数:</span><span>' + eg.data[i].bookPage + '</span>&nbsp;&nbsp;'
					+	'<span>已识别字数:</span><span>' + eg.data[i].recognizedWordsNum + '</span></p>'
					+ 	'<div class="layui-progress layui-progress-big" lay-showPercent="yes" style="margin-bottom: 5px" lay-filter="demo_'+i+'">'
					+  		'<div class="layui-progress-bar layui-bg-blue" lay-percent="'+eg.data[i].recognizedProgress+'%"></div>'
					+ 	'</div>'
					+	'<p><a class="btn btn-primary" role="button" onclick="viewPdf('+ i +')">pdf预览</a>&nbsp;&nbsp;'
					+	'<a class="btn btn-primary" role="button" href="'+eg.rootUrl + eg.data[i].bookUrl+'.pdf" download="'+eg.data[i].bookName+'.pdf">pdf下载</a></p>'
					+	'<p><a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/pdfDetail?bookId='+ eg.data[i].bookId +'">识别详情</a>&nbsp;&nbsp;'
					+	'<a class="btn btn-primary" role="button" onclick="dataDownload('+ i +')" class="pdfDownload">数据下载</a></p>'
				+	'</div>'
				+	'</div>';
				rowDiv.appendChild(div); //追加元素
			}
			layui.use('element', function(){
				  var element = layui.element;
				  element.init();
				});
		}
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
		function viewPdf(index){
			var filepath="/FTZ/" + eg.data[index].bookUrl + ".pdf";
			window.open(filepath);
		}
		function downloadPdf(index){
			var filepath="/FTZ/" + eg.data[index].bookUrl + ".pdf";
		}
		function dataDownload(index){
			/*var fos = new XMLHttpRequest();
	        var file = fos.GetFile(filepath);
	        console.log(file.attributes);
	        console.log(file.Directory); */
			layer.msg("正在打包下载……", { icon: 1 });
	   	  	$(".pdfDownload").attr('disabled', "true");
			// 初始化一个zip打包对象
			var zip = new JSZip();
			
			var wordData = "";
			for (var i = 0; i < eg.data[index].bookPage; i++) {
				var xmlSrc = "/FTZ/" + eg.data[index].bookUrl + "/" + eg.data[index].bookName + "_" + (i+1) + ".xml";
				var xmlDoc = loadXMLDoc(xmlSrc);
				if(xmlDoc != null){
					var x2js = new X2JS();
					var jsonObj = x2js.xml2json(xmlDoc);//xml2json
					var jsonData = jsonObj.wordandpoints;
					//处理jsonData得到wordData
					wordData += "page_"+ i +":\n";
					for(var j=0;j<jsonData.point.length;j++){
						wordData+=(jsonData.point[j].word + " ");
					}
					wordData += "\n";
				}
	         }
			zip.file("word.txt", wordData +"\n");
			
	   	  	var pathImg = new Array();
	   	  	for (var i = 0; i < eg.data[index].bookPage; i++) {
	             pathImg[i] = "/FTZ/" + eg.data[index].bookUrl + "/" + eg.data[index].bookName + "_" + (i+1) + ".png";//获取图片路径
	         }
	   	  	var patimghImg = new Array();
	        var isNum = 0;//阻碍进程的标识
	        //根据图片路径将图片转为base64
	        function convertImgToBase64(url, callback, outputFormat) {
	            isNum = 1;
	            var canvas = document.createElement('CANVAS'),
	                ctx = canvas.getContext('2d'),
	                img = new Image;
	            img.crossOrigin = 'Anonymous';
	            img.onload = function () {
	                canvas.height = img.height;
	                canvas.width = img.width;
	                ctx.drawImage(img, 0, 0);
	                var dataURL = canvas.toDataURL(outputFormat || 'image/jpg');
	                callback.call(this, dataURL);
	                canvas = null;
	                isNum = 0;
	            };
	            img.src = url;
	        }
	        //将每张base64图片保存到img在进行压缩
	        for (var i = 0; i < pathImg.length; i++) {
	            test(pathImg[i]);//测试：imagePath
	            setTimeout(3000, isD);
	        }
	        function isD() {//阻塞等待进程执行结束
	            if (isNum == 0) {} else {setTimeout(3000, isD);}
	        }
	        var j = 0;
	        var img = zip.folder("images");
	        //压缩下载图片
	        function test(imagePath) {
	            convertImgToBase64(imagePath, function (base64Img) {
	                //console.log(base64Img);
	                patimghImg[j] = base64Img;
	                var imgstr = patimghImg[j].split(',')[1];
	                img.file(j + ".jpg", imgstr, { base64: true }); //获取图片文件
	                j++;
	                if (j == pathImg.length) {
	                    zip.generateAsync({ type: "blob" }).then(function (content) {
	                    // 保存到安装包
	                    saveAs(content,"data.zip");
	                    $('.pdfDownload').removeAttr("disabled");
	                    });
	                }
	            });
	        }
		}
		layui.use(['laypage', 'layer'], function(){
			var laypage = layui.laypage
				,layer = layui.layer;
			laypage.render({
				elem: 'demo7'
				,count: eg.data.length
				,limit: 4
				,limits: [4,8,12,16]
				,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
				,jump: function(obj){
				  	change(obj);
				}
			});
		});
    </script>
	</div>
</body>
</html>