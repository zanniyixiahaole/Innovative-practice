<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
<style>
.layui-table-cell {
	display: table-cell;
	vertical-align: middle;
}
</style>
</head>
<body>
	<div class="demoTable">
		根据phoneNumber搜索：
		<div class="layui-inline">
			<input class="layui-input" name="phoneNumber" id="demoReload"
				autocomplete="off">
		</div>
		<button id="do_search" class="layui-btn" data-type="reload">搜索</button>
	</div>
	<table class="layui-hide" id="test" lay-filter="test"></table>
	<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
    <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
    <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
    <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
  </div>
</script>
	<!--转换时间格式-->
	<!-- 
<script type="text/javascript">
Date.prototype.dateToStr = function () {
	var time = new Date(this);
	var y = time.getFullYear();
	var M = time.getMonth() + 1;
	M = M < 10 ? ("0" + M) : M;
	var d = time.getDate();
	d = d < 10 ? ("0" + d) : d;
	var h = time.getHours();
	h = h < 10 ? ("0" + h) : h;
	var m = time.getMinutes();
	m = m < 10 ? ("0" + m) : m;
	var s = time.getSeconds();
	s = s < 10 ? ("0" + s) : s;
	var str = y + "-" + M + "-" + d + " " + h + ":" + m + ":" + s;
	return str;
	};
</script> -->

	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="toPdfDetail">查看书籍详情</a>
		<a class="layui-btn layui-btn-xs" lay-event="toPhotoDetail">查看图片详情</a>
  		<%--
  		<a class="layui-btn layui-btn-xs" lay-event="edit">修改权限</a>
  		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
 		--%>
	</script>


	<script src="layui/layui.js" charset="utf-8"></script>
	<%--<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
 <%
	JSONArray json = (JSONArray)request.getAttribute("jsArray");
%> --%>
	<%--select标签templet--%>
	<script type="text/html" id="selectTemplet">
		<select name="isVIP" lay-filter="testSelect" lay-verify="required" data-value="{{d.isVIP}}"  >
			<option value="0" title="{{d.userId}}" {{#if(d.isVIP==0){}}selected{{#}}}>否</option>
			<option value="1" title="{{d.userId}}" {{#if(d.isVIP==1){}}selected{{#}}}>是</option>
		</select>
	</script>
	<script>
		layui.use(['table','form'], function(){
			var table = layui.table;
			var form = layui.form;
			table.render({
				elem: '#test'
			    ,id: 'testReload'
			    ,height: 600
			    ,url:'${pageContext.request.contextPath }/getUsers'
			    //,data: arr
			   	,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
			         var result;
			         //console.log(this);
			         //console.log(JSON.stringify(res));
			         if(this.page.curr){
			             result = res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
			         }
			         else{
			             result=res.data.slice(0,this.limit);
			         }
			         return {
			             "code": res.code, //解析接口状态
			             "msg": res.msg, //解析提示文本
			             "count": res.count, //解析数据长度
			             "data": result //解析数据列表
			         };
			     }
			    ,page: true
			    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			    ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
			      title: '提示'
			      ,layEvent: 'LAYTABLE_TIPS'
			      ,icon: 'layui-icon-tips'
			    }]
			    ,title: '用户表'
			    ,even: true //开启隔行背景
			    ,cols: [[
			       {type: 'checkbox'}
			      ,{field:'userId', title:'userId',width:90, sort: true}
			      ,{field:'phonenumber', title:'phoneNumber',width:120}
			      ,{field:'regDate', title:'regDate',width:120,templet:'<div>{{ layui.util.toDateString(d.regDate, "yyyy-MM-dd") }}</div>'}
			      ,{field:'isVIP', title:'isVIP',width:90,
			    	  templet:'#selectTemplet'
			    	}
			      ,{field:'money', title:'money',width:90}
			      ,{field:'moneyWait', title:'moneyWait',width:120}
			      ,{field:'book', title:'book',width:90}
			      ,{field:'photo', title:'photo',width:90}
			      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:250}
			    ]]
			    ,done: function (res, curr, count) {
	                $(".layui-table-body, .layui-table-box, .layui-table-cell").css('overflow', 'visible');
	                form.render();
	            },
		    });
  			//头工具栏事件
  			table.on('toolbar(test)', function(obj){
    			var checkStatus = table.checkStatus(obj.config.id);
    			switch(obj.event){
      				case 'getCheckData':
        				var data = checkStatus.data;
        				layer.alert(JSON.stringify(data));
      					break;
     	 			case 'getCheckLength':
				        var data = checkStatus.data;
				        layer.msg('选中了：'+ data.length + ' 个');
				      	break;
			    	case 'isAll':
			        	layer.msg(checkStatus.isAll ? '全选': '未全选');
			      		break;
      				//自定义头工具栏右侧图标 - 提示
      				case 'LAYTABLE_TIPS':
        				layer.alert('这是工具栏右侧自定义的一个图标按钮');
      				break;
    			};
  			});
  			//监听select选择框
  			form.on('select(testSelect)', function (data) {
  				var httpRequest = new XMLHttpRequest();//第一步：建立所需的对象
		  		var value = data.value;
		 	 	var userId = data.elem[data.elem.selectedIndex].title;
		  		var url = "${pageContext.request.contextPath }/updatePermission?userId=" + userId + "&value=" + value;
	      		httpRequest.open('GET', url, true);//第二步：打开连接  将请求参数写在url中  ps:"./Ptest.php?name=test&nameone=testone"
	      		httpRequest.send();//第三步：发送请求  将请求参数写在URL中
			      /**
			       * 获取数据后的处理程序
			       */
	      		httpRequest.onreadystatechange = function () {
	          		if (httpRequest.readyState == 4 && httpRequest.status == 200) {
	              		var json = httpRequest.responseText;//获取到json字符串，还需解析
	              		if(json=="1"){
	                  		layer.msg("更新成功");
	              		} else {
	            	  		layer.msg("更新失败");
	              		}
	         		}
	      		};
  	        });
  			//监听单元格编辑
  			table.on('edit(test)', function(obj){ //注：edit是固定事件名，test是table原始容器的属性 lay-filter="对应的值"
		  		var httpRequest = new XMLHttpRequest();//第一步：建立所需的对象
		  		var value = obj.value;
		 	 	var userId = obj.data.userId;
		 	 	var url = "${pageContext.request.contextPath }/updatePermission?userId=" + userId + "&value=" + value;
	      		httpRequest.open('GET', url, true);//第二步：打开连接  将请求参数写在url中  ps:"./Ptest.php?name=test&nameone=testone"
	      		httpRequest.send();//第三步：发送请求  将请求参数写在URL中
			      /**
			       * 获取数据后的处理程序
			       */
	      		httpRequest.onreadystatechange = function () {
	          		if (httpRequest.readyState == 4 && httpRequest.status == 200) {
	              		var json = httpRequest.responseText;//获取到json字符串，还需解析
	              		if(json=="1"){
	            	  		var value = obj.value //得到修改后的值
	                  		,data = obj.data //得到所在行所有键值
	                  		,field = obj.field; //得到字段
	                  		layer.msg('[ID: '+ data.userId +'] ' + field + ' 字段更改为：'+ value);
	              		} else {
	            	  		layer.msg(更新失败);
	              		}
	         		}
	      		};
			});
			 //监听工具条
			   	table.on('tool(test)', function(obj){
			    var data = obj.data;
			    if(obj.event === 'toPdfDetail'){
			    	window.location.href="${pageContext.request.contextPath }/personalPdfList?userId="+data.userId;
				} else if(obj.event === 'toPhotoDetail'){
					window.location.href="${pageContext.request.contextPath }/personalPhotoList?userId="+data.userId;
				} 
			  });
  			var $ = layui.$, active = {
    		reload: function(){
      			var demoReload = $('#demoReload');
      			//执行重载
      			table.reload('testReload', {
	        		page: {
	          		curr: 1 //重新从第 1 页开始
	        		}
	        		,where: {
	        			'phoneNumber': demoReload.val(),
	       			}
	      			},'data');
   	 			}
  			};
		  	$('.demoTable .layui-btn').on('click', function(){
		    	var type = $(this).data('type');
		    	active[type] ? active[type].call(this) : '';
		  	});
		});
	</script>

</body>
</html>