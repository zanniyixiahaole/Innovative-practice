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
	<div class="layui-container">
		<div class="layui-row">
			<div style="margin: auto; top: 0; left: 0; bottom: 0; right: 0;">
				<div class="layui-form layui-form-pane" style="min-height: 500px">
					<div class="layui-form-item">
						<label class="layui-form-label">资源名称</label>
						<div class="layui-input-block">
							<input type="text" name="name" placeholder="请输入资源名称"
								class="layui-input" id="name">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">资源积分</label>
						<div class="layui-input-block">
							<input type="text" name="credit" placeholder="请输入资源积分"
								class="layui-input" id="credit">
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">资源描述</label>
						<div class="layui-input-block">
							<textarea placeholder="请输入内容" class="layui-textarea"
								name="description" id="description"></textarea>
						</div>
					</div>
					<div class="layui-upload-drag" id="test10">
						<i class="layui-icon"></i>
						<p>点击上传，或将文件拖拽到此处</p>
						<div class="layui-progress layui-progress-big" lay-filter="demo"
							lay-showPercent="true">
							<div class="layui-progress-bar" lay-percent="0%"></div>
						</div>
					</div>
					<div>
						<button type="button" class="layui-btn" id="test9">开始上传</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
layui.use('upload', function(){
  var baseurl = "${pageContext.request.contextPath }";
  var $ = layui.jquery
  ,upload = layui.upload;
  var name,description;
  $('#name').change(function(){
	  name = $('#name').val();
  });
  $('#description').change(function(){
	  description = $('#description').val();
  });
  $('#credit').change(function(){
	  if(!isNaN($('#credit').val())){
		  credit = $('#credit').val();
		}else{
		  alert("请输入合法数字");
		  $('#credit').val("");
		}
  });
  $('#test9').click(function(){
	  uploadInst.reload({
		  data: {
			  name: name
			  ,description: description
			  ,credit: credit
			}   
		}); 
  });
  //拖拽上传
  var uploadInst = upload.render({
	    elem: '#test10'
	    ,url: baseurl+'/resourceupload2' //改成您自己的上传接口
	    ,auto: false
	    ,accept: 'file'
	    ,bindAction: '#test9'
	    ,progress: function(n, elem){
	    	var percent = n + '%' //获取进度百分比
	    	element.progress('demo', percent); //可配合 layui 进度条元素使用
	    }	    
	    ,done: function(res){
	      layer.msg('上传成功');
	      window.location.href="resource";
	    }
	  });
  
});
</script>


</body>
<%@ include file="foot.jsp"%>
</html>
