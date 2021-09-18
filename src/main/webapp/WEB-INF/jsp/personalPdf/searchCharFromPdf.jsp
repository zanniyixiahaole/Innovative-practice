<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>searchCharFromPdf</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*" />
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<script src="Assets/js/jszip.min.js"></script>
<script src="Assets/js/FileSaver.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
	<div class="demoTable">
		请输入要查找的文字：
		<div class="layui-inline">
			<input class="layui-input" name="word" id="demoReload" value=""
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
	<button class="layui-btn layui-btn-sm" lay-event="downloadSelected" id="btn_downloadImage">下载选中图片</button>
  </div>
</script>
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="download">下载</a>
  		<%--
  		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
 		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
 		--%>
	</script>


	<script src="layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
	var userId = <%=request.getAttribute("userId")%>;
	layui.use('table', function(){
  	
	var table = layui.table;
  
	table.render({
    elem: '#test'
    ,id: 'testReload'
    ,height: 600
    ,url:'${pageContext.request.contextPath }/searchByUserIdAndWordFromPdf'
    //,data: arr
   	,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
         var result;
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
    ,title: '搜索文字'
    ,even: true //开启隔行背景
    ,cols: [[
      {type: 'checkbox', fixed: 'left'}
      ,{field:'bookName', title:'书籍名称',width:180, fixed: 'left'}
      ,{field:'bookPage', title:'书籍总页数',width:160}
      ,{field:'recPage', title:'所在页数',width:160}
      ,{field:'recBookDateTime', title:'识别时间',width:160,templet:'<div>{{ layui.util.toDateString(d.recBookDateTime, "yyyy-MM-dd") }}</div>'}
      ,{field:'wordUrl', title:'文字路径',width:150,templet:
	  '<div><img src="/FTZ/{{userId}}/{{d.wordUrl}}" width="30px" height="30px"/></div>'}
      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:165}
    ]]
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
      case 'downloadSelected'://对选中的图片进行打包下载
    	  layer.msg("正在打包下载……", { icon: 1 });
    	  $("#btn_downloadImage").attr('disabled', "true");
    	  var data = checkStatus.data;
    	  var pathImg = new Array();
    	  for (var i = 0; i < data.length; i++) {
              pathImg[i] = "/FTZ/" + userId + "/" + data[i].wordUrl;//获取图片路径
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
              if (isNum == 0) {

              } else {
                  setTimeout(3000, isD);
              }
          }

          var j = 0;
          var zip = new JSZip();
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
                          saveAs(content, userId + "-" + $('#demoReload').val() + ".zip");
                          $('#btn_downloadImage').removeAttr("disabled");
                      });
                  }
              });
          }
      break;
      //自定义头工具栏右侧图标 - 提示
      case 'LAYTABLE_TIPS':
        layer.alert('这是工具栏右侧自定义的一个图标按钮');
      break;
    };
  });
  
  //监听行工具事件
  table.on('tool(test)', function(obj){
    var data = obj.data;
    //console.log(obj)
    if(obj.event === 'detail'){
    	//var that = this; 
		  //多窗口模式，层叠置顶
		  parent.layer.open({
			type: 2 //此处以iframe举例
			,title: '图片识别详情'
			,area: ['1215px', '700px']
			,shade: 0
			,maxmin: true
			,offset: 'auto' 
			,moveOut:true
			,content: '${pageContext.request.contextPath }/recognizeDetail2?photoSrc=/FTZ/'+data.bookUrl + "/" + data.bookName + "_" + data.recPage + ".png"
			,btn: ['全部关闭'] //只是为了演示
			,yes: function(){
				parent.layer.closeAll();
			}
			,zIndex: layer.zIndex //重点1
			,success: function(layero){
			  parent.layer.setTop(layero); //重点2
			}
		  });
    } else if(obj.event === 'download'){
		  var url = "/FTZ/" + userId +"/" + obj.data.wordUrl;                            // 获取图片地址
		  var a = document.createElement('a');          // 创建一个a节点插入的document
		  var event = new MouseEvent('click');         // 模拟鼠标click点击事件
		  a.download = 'photo';         // 设置a节点的download属性值
		  a.href = url;                                 // 将图片的src赋值给a节点的href
		  a.dispatchEvent(event);
	}
    /* if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
      layer.prompt({
        formType: 2
        ,value: data.email
      }, function(value, index){
        obj.update({
          email: value
        });
        layer.close(index);
      });
    } */
  });
  
<%--   <%
  	Long userId = (Long)request.getAttribute("userId");
  %> --%>
  
  var $ = layui.$, active = {
    reload: function(){
    	var demoReload = $('#demoReload');
      //执行重载
      table.reload('testReload', {
        page: {
          curr: 1 //重新从第 1 页开始
        }
        ,where: {
        	'word': demoReload.val(),
        	'userId': userId
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