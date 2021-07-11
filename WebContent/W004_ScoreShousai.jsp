<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="Stylesheet" href="${pageContext.request.contextPath}/Style.css" type="text/css">

	<script type="text/javascript">
		function setValue(button) {
			document.form1.sub_val.value = button.value;
		}
	</script>
</head>
<body>
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="スコア詳細"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<%
			ArrayList<HashMap<String,String>> list = (ArrayList<HashMap<String,String>>)request.getAttribute("list");
			HashMap<String,String> map = new HashMap<String,String>();
			if(list != null) { map = list.get(0); }
		%>
		<div id="content">
			<BUTTON type="Button" onClick="history.back()">戻る</BUTTON>
			<h2><%=map.get("ホーム") %>　vs　<%=map.get("アウェー") %></h2>
			<div id="ScoreShousai">
			<div>■日時</div>
			<TABLE class="Kickoff" border="1" width="40%">
			<tr>
				<th width="33%">試合日</th>
				<th width="33%">キックオフ</th>
				<th width="34%">会場</th>
			</tr>
			<tr>
				<td><%=map.get("試合日") %></td>
				<td><%=map.get("キックオフ") %></td>
				<td><%=map.get("会場") %></td>
			</tr>
			</TABLE>
			<br>
			<div>■スコア詳細</div>
			<form name="form1" method="post" action="W003_TeamShousai">
			<INPUT type="hidden" name="sub_val">
			<INPUT type="hidden" name="sql_type" value="select">
			<INPUT type="hidden" name="to_name" value="W003_TeamShousai.jsp">
			<TABLE class="Shousai" border="1" width="100%">
			<tr>
				<th>ホーム</th>
				<th>ホームスコア</th>
				<th></th>
				<th>アウェースコア</th>
				<th>アウェー</th>
			</tr>
			<tr>
				<td width="30%"><BUTTON type="submit" name="team" value="<%=map.get("ホーム") %>" onClick="setValue(this)"><%=map.get("ホーム") %></BUTTON></td>
				<td width="15%"><%=map.get("ホームスコア") %></td>
				<td width="10%">vs</td>
				<td width="15%"><%=map.get("アウェースコア") %></td>
				<td width="30%"><BUTTON type="submit" name="team" value="<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("アウェー") %></BUTTON></td>
			</tr>
			</TABLE>
			</form>
			</div>
		</div>
		<!-- コンテンツ終了 -->


		<!-- フッタ開始 -->
		<jsp:include page="W000_Footer.jsp"/>
		<!-- フッタ終了 -->


	</div>
	<!-- コンテナ終了 -->

</body>
</html>