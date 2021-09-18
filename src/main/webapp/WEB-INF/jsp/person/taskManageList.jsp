<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">

<link rel="stylesheet" href="Assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="Assets/css/flat-ui.css" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script src="Assets/js/jquery-3.4.1.min.js"></script>


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
				if('${manageFlag}'=='0')
					div.innerHTML = '<div class="thumbnail" >'
					+	'<a href="javascript:void(0);">'
					+	'<img style="width: 100%; height: 300px; display: block;" alt="100%x300" src="' + eg.rootUrl + eg.data[i].bookUrl + '/' + eg.data[i].bookName + '_1.png' +'" data-src="holder.js/100%x300"  data-holder-rendered="true" title="' + eg.data[i].bookName + '">'
					+	'</a>'
					+	'<div class="caption center">'
						+	'<p><span>书籍名称:</span><span>' + bookNameTrans + '</span></p>'
						+	'<p><span>上传时间:</span><span>' + dateTime + '</span></p>'
						+	'<p><span>书籍积分:</span><span>' +eg.data[i].bookMoney + '</span></p>'	
						+	'<p><span>页数:</span><span>' + eg.data[i].bookPage + '</span>&nbsp;&nbsp;'
						+	'</p>'
						+	'<p><a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/TaskDetail?bookId='+ eg.data[i].bookId +'">查看详情</a>&nbsp;&nbsp;'
						+	'<a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/taskGet?bookId='+ eg.data[i].bookId +'">领取任务</a></p>'
					+	'</div>'
					+	'</div>';
				else
					div.innerHTML = '<div class="thumbnail" >'
						+	'<a href="javascript:void(0);">'
						+	'<img style="width: 100%; height: 300px; display: block;" alt="100%x300" src="' + eg.rootUrl + eg.data[i].bookUrl + '/' + eg.data[i].bookName + '_1.png' +'" data-src="holder.js/100%x300"  data-holder-rendered="true" title="' + eg.data[i].bookName + '">'
						+	'</a>'
						+	'<div class="caption center">'
							+	'<p><span>书籍名称:</span><span>' + bookNameTrans + '</span></p>'
							+	'<p><span>上传时间:</span><span>' + dateTime + '</span></p>'
							+	'<p><span>书籍积分:</span><span>' +eg.data[i].bookMoney + '</span></p>'
							+	'<p><span>是否识别:</span><span>' +(eg.data[i].flag=="1"?"是":"否")+ '</span></p>'
							+	'<p><span>页数:</span><span>' + eg.data[i].bookPage + '</span>&nbsp;&nbsp;'
							+	'</p>'
							+	'<p><a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/TaskDetail?bookId='+ eg.data[i].bookId +'">查看详情</a>&nbsp;&nbsp;'
							+	'<a class="btn btn-primary" role="button" href="${pageContext.request.contextPath }/taskGet?flag='+eg.data[i].flag+'&bookId='+ eg.data[i].bookId +'">放弃任务</a></p>'
						+	'</div>'
						+	'</div>';
				rowDiv.appendChild(div); //追加元素
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
		<script type="text/javascript">
		var msg = "${requestScope.msg }";
		if(msg!=""){
			alert(msg)
		}
	</script>
	</div>
</body>
</html>