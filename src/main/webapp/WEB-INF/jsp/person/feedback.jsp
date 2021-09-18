<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>selectChar</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
	<form class="layui-form layui-form-pane"
		action="${pageContext.request.contextPath }/addfeedback2"
		lay-filter="form1">
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">请输入反馈内容</label>
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
	layui.use('form', function(){
		  var form = layui.form
		  form.val('form1', {
		      "phonenumber": "${user.phonenumber }" // "name": "value"
		      ,"resourceId": 0
		    });
		//监听提交
		form.on('submit(demo1)', function(data){
		  return true;
		});
	});
	</script>

</body>
</html>