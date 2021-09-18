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

.p {
	font-size: 10px;
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
	<div class="demoTable">
		&nbsp;&nbsp;&nbsp;&nbsp;根据userID搜索：
		<div class="layui-inline">
			<input class="layui-input" name="userId" id="demoReload"
				autocomplete="off">
		</div>
		<button id="do_search" class="layui-btn" data-type="reload">搜索</button>
	</div>
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
		eg.data = ${bookInfoJson};
		//console.log(eg.data);
		eg.rootUrl = "/FTZ/";
		
		function change(obj){
			
			var rowDiv = document.getElementById("rowDiv");
			rowDiv.innerHTML = ''; //每次显示时清空旧的内容
			var start = (obj.curr - 1) * obj.limit; //计算需要的data数据开始位置
			var end = obj.curr * obj.limit; //计算需要的data数据开始位置
			for(var i = start;i < end && i < eg.data.length; i++) {
				//循环数据，并根据数据生成html后插入rowDiv中
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
					+	'<p><span>用户Id:</span><span>' + eg.data[i].userId + '</span></p>'
					+	'<p><span>上传时间:</span><span>' + dateTime + '</span></p>'
					+	'<p><span>页数:</span><span>' + eg.data[i].bookPage + '</span>&nbsp;&nbsp;'
					+	'<span>已识别字数:</span><span>' + eg.data[i].recognizedWordsNum + '</span></p>'
					+ 	'<div class="layui-progress layui-progress-big" lay-showPercent="yes" style="margin-bottom: 5px" lay-filter="demo_'+i+'">'
					+  		'<div class="layui-progress-bar layui-bg-blue" lay-percent="'+eg.data[i].recognizedProgress+'%"></div>'
					+ 	'</div>'
					+	'<p><a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/pdfPhotoListAdmin?bookId='+ eg.data[i].bookId +'">查看详情</a>&nbsp;&nbsp;'
					+	'<a class="btn btn-primary" role="button" href="">点击下载</a></p>'
				+	'</div>'
				+	'</div>';
				rowDiv.appendChild(div); //追加元素
			}
			layui.use('element', function(){
				  var element = layui.element;
				  element.init();
				});
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
			
			var $ = layui.$, active = {
				    reload: function(){
				      var demoReload = $('#demoReload');
				      //执行重载
				      window.location.href="${pageContext.request.contextPath }/pdfList?userId="+demoReload.val();
				    }
				  };
				  
			  $('.demoTable .layui-btn').on('click', function(){
			    var type = $(this).data('type');
			    active[type] ? active[type].call(this) : '';
			  });
		});
    </script>
	</div>
</body>
</html>