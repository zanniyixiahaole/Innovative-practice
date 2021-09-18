<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人信息</title>
<link href="css/css.css" type="text/css" rel="stylesheet" />
<link href="css/main.css" type="text/css" rel="stylesheet" />
<link rel="shortcut icon" href="images/main/favicon.ico" />
<script src="Assets/bookStoreShow/jquery-1.11.3.min.js"></script>
<style>
body {
	overflow-x: hidden;
	background: #f2f0f5;
	padding: 15px 0px 10px 5px;
}

#searchmain {
	font-size: 12px;
}

#search {
	font-size: 12px;
	background: #548fc9;
	margin: 10px 10px 0 0;
	display: inline;
	width: 100%;
	color: #FFF
}

#search form span {
	height: 40px;
	line-height: 40px;
	padding: 0 0px 0 10px;
	float: left;
}

#search form input.text-word {
	height: 24px;
	line-height: 24px;
	width: 180px;
	margin: 8px 0 6px 0;
	padding: 0 0px 0 10px;
	float: left;
	border: 1px solid #FFF;
}

#search form input.text-but {
	height: 24px;
	line-height: 24px;
	width: 55px;
	background: url(images/main/list_input.jpg) no-repeat left top;
	border: none;
	cursor: pointer;
	font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
	color: #666;
	float: left;
	margin: 8px 0 0 6px;
	display: inline;
}

#search a.add {
	background: url(images/main/add.jpg) no-repeat 0px 6px;
	padding: 0 10px 0 26px;
	height: 40px;
	line-height: 40px;
	font-size: 14px;
	font-weight: bold;
	color: #FFF
}

#search a:hover.add {
	text-decoration: underline;
	color: #d2e9ff;
}

#main-tab {
	border: 1px solid #eaeaea;
	background: #FFF;
	font-size: 12px;
}

#main-tab th {
	font-size: 12px;
	background: url(images/main/list_bg.jpg) repeat-x;
	height: 32px;
	line-height: 32px;
}

#main-tab td {
	font-size: 12px;
	line-height: 40px;
}

#main-tab td a {
	font-size: 12px;
	color: #548fc9;
}

#main-tab td a:hover {
	color: #565656;
	text-decoration: underline;
}

.bordertop {
	border-top: 1px solid #ebebeb
}

.borderright {
	border-right: 1px solid #ebebeb
}

.borderbottom {
	border-bottom: 1px solid #ebebeb
}

.borderleft {
	border-left: 1px solid #ebebeb
}

.gray {
	color: #dbdbdb;
}

td.fenye {
	padding: 10px 0 0 0;
	text-align: right;
}

.bggray {
	background: #f9f9f9;
	font-size: 14px;
	font-weight: bold;
	padding: 10px 10px 10px 0;
	width: 120px;
}

.main-for {
	padding: 10px;
}

.main-for input.text-word {
	width: 310px;
	height: 36px;
	line-height: 36px;
	border: #ebebeb 1px solid;
	background: #FFF;
	font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
	padding: 0 10px;
}

.main-for select {
	width: 310px;
	height: 36px;
	line-height: 36px;
	border: #ebebeb 1px solid;
	background: #FFF;
	font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
	color: #666;
}

.main-for input.text-but {
	width: 100px;
	height: 40px;
	line-height: 30px;
	border: 1px solid #cdcdcd;
	background: #e6e6e6;
	font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
	color: #969696;
	float: left;
	margin: 0 10px 0 0;
	display: inline;
	cursor: pointer;
	font-size: 14px;
	font-weight: bold;
}

#addinfo a {
	font-size: 14px;
	font-weight: bold;
	background: url(images/main/addinfoblack.jpg) no-repeat 0 1px;
	padding: 0px 0 0px 20px;
	line-height: 45px;
}

#addinfo a:hover {
	background: url(images/main/addinfoblue.jpg) no-repeat 0 1px;
}
</style>
</head>
<body>
	<!--main_top-->
	<table width="99%" border="0" cellspacing="0" cellpadding="0"
		id="searchmain">
		<tr>
			<td width="99%" align="left" valign="top">您的位置：个性设置&nbsp;&nbsp;>&nbsp;&nbsp;修改信息</td>
		</tr>
		<tr>
			<td align="left" valign="top" id="addinfo"></td>
		</tr>
		<tr>
			<td align="left" valign="top">
				<form id="myform" method="post" action="ChangInfoto.do">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="main-tab" align="center">


						<tr onMouseOut="this.style.backgroundColor='#ffffff'"
							onMouseOver="this.style.backgroundColor='#edf5ff'">
							<td align="right" valign="middle"
								class="borderright borderbottom bggray">性别：</td>
							<td align="left" valign="middle"
								class="borderright borderbottom main-for">
								<!--  <input type="text"  name="sex" value="" class="text-word"> -->
								<select class="text-word" name="sex">
									<!-- <option disabled selected value="0">==请选择==</option>  -->
									<option selected>男</option>
									<option>女</option>
							</select>
							</td>
						</tr>
						<tr onMouseOut="this.style.backgroundColor='#ffffff'"
							onMouseOver="this.style.backgroundColor='#edf5ff'">
							<td align="right" valign="middle"
								class="borderright borderbottom bggray">年龄:</td>
							<td align="left" valign="middle"
								class="borderright borderbottom main-for"><input id="age"
								type="text" name="age" value="" class="text-word"></td>
						</tr>


						<tr onMouseOut="this.style.backgroundColor='#ffffff'"
							onMouseOver="this.style.backgroundColor='#edf5ff'">
							<td align="right" valign="middle"
								class="borderright borderbottom bggray">名字:</td>
							<td align="left" valign="middle"
								class="borderright borderbottom main-for"><input
								type="text" id="name" name="name" value="" class="text-word">
							</td>
						</tr>

						<tr onMouseOut="this.style.backgroundColor='#ffffff'"
							onMouseOver="this.style.backgroundColor='#edf5ff'">
							<td align="right" valign="middle"
								class="borderright borderbottom bggray">职业:</td>
							<td align="left" valign="middle"
								class="borderright borderbottom main-for"><input
								type="text" id="occupation" name="occupation" value=""
								class="text-word"></td>
						</tr>
						<tr onMouseOut="this.style.backgroundColor='#ffffff'"
							onMouseOver="this.style.backgroundColor='#edf5ff'">
							<td align="right" valign="middle"
								class="borderright borderbottom bggray">&nbsp;</td>
							<td align="left" valign="middle"
								class="borderright borderbottom main-for"><input name=""
								value="提交" class="text-but" onclick="IsAge()"> <input
								name="" type="reset" value="重置" class="text-but"></td>
						</tr>

					</table>
				</form>
			</td>
		</tr>
	</table>
</body>
<script>
function IsAge() {
	 var a=$('#age').val();
    var age = parseInt(a);
    let patternname=/^([\\u4e00-\\u9fa5]{1,20}|[a-zA-Z\\.\\s]{1,20})$/;
    /**
	 * 1.可以是中文
	   2.可以是英文，允许输入点（英文名字中的那种点）， 允许输入空格
           3.中文和英文不能同时出现
           4.长度在20个字符以内
	 * @param name
	 * @return
	 */

   var name=$('#name').val();
    var occupation=$('#occupation').val();
    let patternoc =  /[a-zA-Z0-9\u4E00-\u9FA5\uf900-\ufa2d]/;
    
    let pattern = /^(([0-9]|[1-9][1-9]|1[0-4][0-9])(\\.[0-9]+)?|150)$/;
   if (pattern.test(age))
	  {
	   if(patternname.test(name))
		   {
		   if(patternoc.test(occupation))
			   {
			   document.forms['myform'].submit();
			   }
		   else{
			   alert("职业填写不能出现数字，请重新输入");
		   }
		  	 
		   }
	   else{
		   alert("名字填写不符合格式，请重新输入");
	   }
	   
	  }
   else{alert("年龄填写不符合格式，请重新输入");}
}
</script>

</html>