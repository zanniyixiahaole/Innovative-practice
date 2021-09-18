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
/* 顶部加50px高度的div */
#uselessDiv1 {
	height: 50px;
}
/* 在个人中心进行查看书籍时高度溢出，看不到底部分页组件，所以在底部加了200px高度的div代替溢出 */
#uselessDiv2 {
	height: 200px;
}
</style>
</head>
<body>
	<div id="uselessDiv1"></div>
	<!--content-->
	<div class="container">
		<div class="row" id="rowDiv"></div>
		<nav class="center">
			<div id="demo7"></div>
		</nav>
		<div id="uselessDiv2"></div>
		<script src="layui/layui.js" charset="utf-8"></script>
		<script>
		var eg = {};
		eg.data = ${pdfPhotoListJson};
		//console.log(eg.data);
		eg.rootUrl = "/FTZ/";
		function toDetail(i){
			var photoSrc = eg.rootUrl + eg.data[i].photoSrc;
			layui.use(['layer'], function(){
				var layer = layui.layer;
				parent.layer.open({
	  				type: 2 //此处以iframe举例
	  				,title: '图片识别详情'
	  				,area: ['1215px', '700px']
	  				,shade: 0
	  				,maxmin: true
	  				,offset: 'auto' 
  					,moveOut: true
	  				,content: '${pageContext.request.contextPath }/recognizeDetail2?photoSrc=' + photoSrc
	  				,btn: ['全部关闭'] //只是为了演示
	  				,yes: function(){
	  					parent.layer.closeAll();
	  				}
	  				,zIndex: layer.zIndex //重点1
	  				,success: function(layero){
	  					parent.layer.setTop(layero); //重点2
	  				}
	  			});
			});
		}
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
				var recognized = eg.data[i].recognized==0?"未识别":"已识别";
				div.innerHTML = '<div class="thumbnail" >'
				+	'<img style="width: 100%; height: 300px; display: block;" alt="100%x300" data-holder-rendered="true" src="' + eg.rootUrl + eg.data[i].photoSrc +'" title="' + eg.data[i].bookName + '">'
				+	'<div class="caption center">'
					+	'<p><span>页码:</span><span>' + eg.data[i].page + '</span></p>'
					+	'<p><span>'+recognized+'</span></p>'
					+	'<p><a class="btn btn-primary" role="button"'
					+ (eg.data[i].recognized==0?'disabled="true"':'onclick="toDetail('+i+')"') +'>查看详情</a></p>'
				+	'</div>'
				+	'</div>';
				rowDiv.appendChild(div); //追加元素
			}
		}
		layui.use(['laypage'], function(){
			var laypage = layui.laypage
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