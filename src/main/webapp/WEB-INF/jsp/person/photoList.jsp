<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.web.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Photo List</title>
<style type="text/css">
.td td {
	width: 100px;
}

.table {
	text-align: center;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%
	List<PhotoRecord> pl = (List)request.getAttribute("photoList");
%>

	<table class="table">
		<tr class="td">
			<td>record</td>
			<td>userID</td>
			<td>date_time</td>
			<td style="width: 200px">record_url</td>
		</tr>
		<%
	System.out.println(pl.size());
	for(int i = 0 ; i < pl.size();i++){
		PhotoRecord pr = pl.get(i);
%>
		<tr>
			<td><%=pr.getRecord() %></td>
			<td><%=pr.getUserId() %></td>
			<td><%=pr.getDateTime()%></td>
			<td><%=pr.getRecordUrl()%></td>
		</tr>
		<%
	}
%>
		<%-- <%if(pl!=null){%>
		<tr class="td">
			<td><%=photoRecord.getUserId()%></td>
			<td><%=photoRecord.getDate_time()%></td>
			<td><%=photoRecord.getRecordUrl()%></td>
		</tr>
	<%}else{ %>
		<tr class="td">
			<td style="color: red;">暂无相关数据</td>
		</tr>
<%} %> --%>
	</table>

</body>
</html>
