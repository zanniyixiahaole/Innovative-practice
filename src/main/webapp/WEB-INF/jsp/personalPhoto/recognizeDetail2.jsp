<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>recognizeDetail2</title>
<style type="text/css">
.div {
	width: 1200px;
	height: 580px;
	float: left;
	margin: 0 auto;
	background: #f2f7f2;
}

.div .div1 {
	float: left;
	width: 600px;
	height: 580px;
}

.div .div2 {
	float: left;
	width: 600px;
	height: 580px;
}
</style>
</head>
<body bgcolor="#E6E6FA">
	<% 
			String photoSrc = (String) request.getAttribute("photoSrc");
			String dataJson = (String)request.getAttribute("dataJson");
		%>
	<div class="div">
		<div class="div1">
			<img id="sourcePhoto" src="<%=photoSrc %>" width="600" height="580" />
		</div>
		<div class="div1">
			<canvas id="c2" width="600" height="580"
				style="margin: 0 0; display: block"></canvas>
		</div>
	</div>

	<script type="text/javascript">
		window.onload = function () {
            var img = document.getElementById("sourcePhoto");
            var imgTemp = new Image();
            imgTemp.src = img.src;
            var realWidth;//真实的宽度
            var realHeight;//真实的高度
            
            imgTemp.onload=function(){
            	realWidth = this.width;
                realHeight = this.height;
            	//console.log("realWidth:"+realWidth);
            	//console.log("realHeight:"+realHeight);
            	var xli;//x比例
                var yli;//y比例
                xli = 600/realWidth;
    			yli = 580/realHeight;
    			//console.log("xli:" + xli);
                //console.log("yli:" + yli);
    			var c2 = document.getElementById("c2");
    			var context2 = c2.getContext("2d");
    			
    			//context2.fillStyle = '#FFFFFF';
    			//context2.fillRect(0,0,600,580);

    			context2.clearRect(0,0,600,580);
    			
    			context2.font = ("25px" + " Arial");
    			var json = JSON.parse('<%=dataJson%>');
    			for (var k=0;k<json.length;k++){
    				context2.fillText(json[k].word,json[k].x*xli,(json[k].y)*yli);
    			}
    			
            } 
            
			
        }
		
		</script>
</body>

</html>