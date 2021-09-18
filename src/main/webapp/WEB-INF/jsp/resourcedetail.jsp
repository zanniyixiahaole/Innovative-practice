<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>繁体字识别平台</title>
<link rel="stylesheet" type="text/css" href="Assets/css/reset.css" />
<script type="text/javascript" src="Assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="Assets/plugins/FlexSlider/jquery.flexslider.js"></script>
<link rel="stylesheet" type="text/css"
	href="Assets/plugins/FlexSlider/flexslider.css">
<script type="text/javascript" src="Assets/js/js_z.js"></script>
<link rel="stylesheet" type="text/css" href="Assets/css/thems.css">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>

<body>
	<%@ include file="head.jsp"%>
	<!--主体盒子-->
	<table class="layui-hide" id="resource" lay-filter="resource"></table>

	<table class="layui-hide" id="reply" lay-filter="reply"></table>

	<script type="text/html" id="barDemo">
 		 <a class="layui-btn layui-btn-xs" lay-event="download">下载</a>
	</script>

	<form class="layui-form layui-form-pane"
		action="${pageContext.request.contextPath }/addreply"
		lay-filter="form1">
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">请输入留言内容</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入内容" class="layui-textarea"
					name="replyContent"></textarea>
				<input type="hidden" name="phonenumber" class="layui-input">
				<input type="hidden" name="resourceId" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button type="submit" class="layui-btn" lay-submit=""
					lay-filter="demo1">立即提交</button>
			</div>
		</div>
	</form>
	<script src="layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
layui.use('table', function(){
  var table = layui.table;
  var baseurl = "${pageContext.request.contextPath }";
  //方法级渲染
  table.render({
    elem: '#resource'
    ,url: baseurl+'/resourcedetail2'
    ,cols: [[
      {field:'resourceName', title: '资源名称',width:300}
      ,{field:'resourceDescription', title: '资源描述'}
      ,{field:'userId', title: '上传者', width:150}
      ,{field:'resourceDatestr', title: '上传时间', width:200}
      ,{field:'resourceCredit', title: '所需积分', width:100}
      ,{field:'resourceId', title: '资源ID',hide:true}
      ,{fixed: 'right', title:'下载', toolbar: '#barDemo', width:80}
    ]]
  	,parseData: function(res){ //res 即为原始返回的数据
  	    return {
  	      "code": 0, //解析接口状态
  	      "msg": "", //解析提示文本
  	      "count": 1, //解析数据长度
  	      "data": res //解析数据列表
  	    };
  	  }
  });
  
  table.render({
	    elem: '#reply'
	    ,url: baseurl+'/reply'
	    ,cols: [[
	      {field:'userId', title: '留言者',width:150}
	      ,{field:'replyContent', title: '留言内容'}
	    ]]
	  	,parseData: function(res){ //res 即为原始返回的数据
	  	    return {
	  	      "code": 0, //解析接口状态
	  	      "msg": "", //解析提示文本
	  	      "count": res[0].total, //解析数据长度
	  	      "data": res[0].list //解析数据列表
	  	    };
	  	  }
	    ,page: true
	  });
  
//监听行工具事件
  table.on('tool(resource)', function(obj){
    var data = obj.data;
    //console.log(obj)
    if(obj.event === 'download'){
    	if("${user.money}" >= data.resourceCredit){
    		alert("${user.money}");
    		window.open("resourcedownload?resourceId="+data.resourceId);
    		//window.location.href="resourcedownload?resourceId="+data.resourceId;
    		window.location.href="resource";
    	}else{
    		alert("积分不足");
    	}
    } 
  });
  
});
layui.use('form', function(){
	  var form = layui.form
	  form.val('form1', {
	      "phonenumber": "${user.phonenumber }" // "name": "value"
	      ,"resourceId": "${resourceId}"
	    });
	//监听提交
	form.on('submit(demo1)', function(data){
	  return true;
	});
});
</script>

	<%@ include file="foot.jsp"%>
</body>
</html>
