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
<%@ include file="head.jsp"%>
<body height="800px">

	<!--主体盒子-->
	<div class="demoTable">
		搜索关键字：
		<div class="layui-inline">
			<input class="layui-input" name="id" id="demoReload"
				autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload">搜索</button>
		<a href="${pageContext.request.contextPath }/resourceupload"
			class="layui-btn">上传资源</a>
	</div>

	<table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>


	<script src="layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
layui.use('table', function(){
  var table = layui.table;
  var baseurl = "${pageContext.request.contextPath }";
  //方法级渲染
  table.render({
    elem: '#LAY_table_user'
    ,url: baseurl+'/resource2'
    ,cols: [[
      {field:'resourceName', title: '资源名称',fixed:true}
      ,{field:'userId', title: '上传者', width:150}
      ,{field:'resourceDatestr', title: '上传时间', width:200}
      ,{field:'resourceCredit', title: '所需积分', width:100}
      ,{field:'resourceId', title: '资源ID',hide:true}
    ]]
  	,parseData: function(res){ //res 即为原始返回的数据
  	    return {
  	      "code": 0, //解析接口状态
  	      "msg": "", //解析提示文本
  	      "count": res[0].total, //解析数据长度
  	      "data": res[0].list //解析数据列表
  	    };
  	  }
    ,id: 'testReload'
    ,page: true
    ,height: 500
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
          keyword: demoReload.val()
        }
      }, 'data');
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  
//监听行单击事件（双击事件为：rowDouble）
  table.on('row(user)', function(obj){
    var data = obj.data;
    
    window.location.href="resourcedetail?resourceId="+data.resourceId;
    //alert(data.resourceId);
    
  });
  
});
</script>


</body>
<%@ include file="foot.jsp"%>
</html>
