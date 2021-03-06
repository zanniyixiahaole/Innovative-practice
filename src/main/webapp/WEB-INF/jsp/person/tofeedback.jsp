<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reply</title>
<link href="Assets/css/css.css" type="text/css" rel="stylesheet" />
<link href="Assets/css/main.css" type="text/css" rel="stylesheet" />
<link rel="shortcut icon" href="Assets/images/main/favicon.ico" />
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
	color: #FFF;
	float: left
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
	background: url(images/main/add.jpg) no-repeat -3px 7px #548fc9;
	padding: 0 10px 0 26px;
	height: 40px;
	line-height: 40px;
	font-size: 14px;
	font-weight: bold;
	color: #FFF;
	float: right
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
	background: #f9f9f9
}
</style>
</head>
<body>
	<!--main_top-->
	<table width="99%" border="0" cellspacing="0" cellpadding="0"
		id="searchmain">
		<td align="left" valign="top">

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				id="main-tab">
				<tr>
					<th align="center" valign="middle" class="borderright">编号</th>
					<th align="center" valign="middle" class="borderright">反馈帐号</th>
					<th align="center" valign="middle" class="borderright">反馈内容</th>
					<th align="center" valign="middle" class="borderright">反馈时间</th>
					<th align="center" valign="middle">操作</th>
				</tr>
				<c:forEach items="${ pageInfo.list}" var="list">
					<tr onMouseOut="this.style.backgroundColor='#ffffff'"
						onMouseOver="this.style.backgroundColor='#edf5ff'">
						<td align="center" valign="middle"
							class="borderright borderbottom">${list.replyId }</td>
						<td align="center" valign="middle"
							class="borderright borderbottom">${list.userId }</td>
						<td align="center" valign="middle"
							class="borderright borderbottom">${list.replyContent }</td>
						<td align="center" valign="middle"
							class="borderright borderbottom">${list.replyDatestr }</td>
						<td align="center" valign="middle" class="borderbottom"><a
							href="feedbackdelete?replyId=${list.replyId }" target="mainFrame"
							onFocus="this.blur()" class="add">删除</a></td>
					</tr>
				</c:forEach>
			</table>
		</td>
		</tr>
		<tr>
			<td align="left" valign="top" class="fenye">${pageInfo.total }
				条数据 ${pageInfo.pageNum }/${pageInfo.pages } 页&nbsp;&nbsp; <a
				href="personreply?page=1&size=10" target="mainFrame"
				onFocus="this.blur()">首页</a>&nbsp;&nbsp; <a
				href="personreply?page=${pageInfo.pageNum-1 }&size=10"
				target="mainFrame" onFocus="this.blur()">上一页</a>&nbsp;&nbsp; <a
				href="personreply?page=${pageInfo.pageNum+1 }&size=10"
				target="mainFrame" onFocus="this.blur()">下一页</a>&nbsp;&nbsp; <a
				href="personreply?page=${pageInfo.pages }&size=10"
				target="mainFrame" onFocus="this.blur()">尾页</a>
			</td>
		</tr>
	</table>
</body>
</html>