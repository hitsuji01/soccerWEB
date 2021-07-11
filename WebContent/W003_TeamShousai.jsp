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
			//alert(button.value);

			if(button.getAttribute('name')=='setsu'){
				document.form1.to_name.value = "W002_ShiaiKekkaItiran.jsp";
				document.form1.action="W002_ShiaiKekkaItiran";
			}
			else if(button.getAttribute('name')=='team'){
				document.form1.to_name.value = "W003_TeamShousai.jsp";
				document.form1.action="W003_TeamShousai";
			}
			else if(button.getAttribute('name')=='score'){
				document.form1.to_name.value = "W004_ScoreShousai.jsp";
				document.form1.action="W004_ScoreShousai";
			}
		}
	</script>
</head>
<body>
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="チーム詳細"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<%
			ArrayList<HashMap<String,String>> list = (ArrayList<HashMap<String,String>>)request.getAttribute("list");
			ArrayList<HashMap<String,String>> seiseki = (ArrayList<HashMap<String,String>>)request.getAttribute("seiseki");
			HashMap<String,String> seiseki_map = new HashMap<String,String>();
			if(seiseki != null) { seiseki_map = seiseki.get(0); }
		%>
		<div id="content">
			<BUTTON type="Button" onClick="history.back()">戻る</BUTTON>
			<h2><%=seiseki_map.get("チーム名") %></h2>
			<div id="TeamShousai">
			<div>■順位</div>
			<TABLE class="Rank" border="1" width="100%">
			<tr>
				<th width="10%">順位</th>
				<th width="20%">チーム名</th>
				<th width="10%">勝点</th>
				<th width="10%">勝数</th>
				<th width="10%">引分数</th>
				<th width="10%">負数</th>
				<th width="10%">得点</th>
				<th width="10%">失点</th>
				<th width="10%">得失点差</th>
			</tr>
		<%if(seiseki != null){ %>
			<tr>
				<td><%=seiseki_map.get("順位") %></td>
				<td><%=seiseki_map.get("チーム名") %></td>
				<td><%=seiseki_map.get("勝点") %></td>
				<td><%=seiseki_map.get("勝数") %></td>
				<td><%=seiseki_map.get("引分数") %></td>
				<td><%=seiseki_map.get("負数") %></td>
				<td><%=seiseki_map.get("得点") %></td>
				<td><%=seiseki_map.get("失点") %></td>
				<td><%=seiseki_map.get("得失点") %></td>
			</tr>
		<%} %>
			</TABLE>
			<br>
			<div>■試合一覧</div>
			<form name="form1" method="post">
			<INPUT type="hidden" name="sub_val">
			<INPUT type="hidden" name="sql_type" value="select">
			<INPUT type="hidden" name="to_name" value="">
			<TABLE class="ShiaiItiran" border="1" width="100%">
			<tr>
				<th width="15%">節</th>
				<th width="15%">試合日</th>
				<th width="15%">キックオフ</th>
				<th width="25%">対戦相手</th>
				<th width="30%">スコア</th>
			</tr>
	<%if(list != null){ %>
		<% for(HashMap<String,String> map : list){ %>
			<tr>
				<td>
					<BUTTON type="submit" name="setsu" value="<%=map.get("節") %>" onClick="setValue(this)"><%=map.get("節") %></BUTTON>
				</td>
				<td><%=map.get("試合日") %></td>
				<td><%=map.get("キックオフ") %></td>
			<%if(list != null && seiseki != null && map.get("ホーム").equals(seiseki_map.get("チーム名"))) { %>
				<td>
					<BUTTON type="submit" name="team" value="<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("アウェー") %></BUTTON>
				</td>
				<td>
					<BUTTON type="submit" name="score" value="<%=map.get("節") %>,<%=map.get("ホーム") %>,<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("ホームスコア") %>　vs　<%=map.get("アウェースコア") %></BUTTON>
				</td>
			<%}else{ %>
				<td>
					<BUTTON type="submit" name="team" value="<%=map.get("ホーム") %>" onClick="setValue(this)"><%=map.get("ホーム") %></BUTTON>
				</td>
				<td>
					<BUTTON type="submit" name="score" value="<%=map.get("節") %>,<%=map.get("ホーム") %>,<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("アウェースコア") %>　vs　<%=map.get("ホームスコア") %></BUTTON>
				</td>
			<%} %>


			</tr>
		<%} %>
	<%} %>
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