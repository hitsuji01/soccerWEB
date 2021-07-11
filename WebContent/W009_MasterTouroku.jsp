<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="Stylesheet" href="${pageContext.request.contextPath}/Style.css" type="text/css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script type="text/javascript" src="masterTableScript.js"></script>
</head>
<body onLoad="changeTable()">
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="マスタ登録"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<%
			ArrayList<HashMap<String,String>> teamList = (ArrayList<HashMap<String,String>>)request.getAttribute("チームマスタ");
			ArrayList<HashMap<String,String>> kaijoList = (ArrayList<HashMap<String,String>>)request.getAttribute("会場マスタ");
			ArrayList<HashMap<String,String>> pointList = (ArrayList<HashMap<String,String>>)request.getAttribute("勝点マスタ");
		%>
		<div id="content">
			<BUTTON type="Button" onClick="history.back()">戻る</BUTTON>
			<h2>マスタ登録</h2>
			<div id="MasterTouroku">
			<form name="form1" method="post">
			<INPUT type="hidden" name="to_name">
			<INPUT type="hidden" name="sub_val">
			<div style="float:left;">
				<input type="radio" name="sql_type" value="insert" onChange="changeTable()" checked> 追加　
				<input type="radio" name="sql_type" value="update" onChange="changeTable()"> 更新　
				<input type="radio" name="sql_type" value="delete" onChange="changeTable()"> 削除　　
			</div>
			<div style="float:left;">
				<BUTTON type="submit" name="sub_button" onClick="return getTableRecords()"> 確認</BUTTON>
			</div>
			<br clear="all">
			<br>
			<br>
			<div style="clear:both;">
				マスタテーブル名：
				<select name="master_name" onChange="changeTable()">
					<option value="team" selected>チームマスタ</option>
					<option value="kaijo">会場マスタ</option>
					<option value="point">勝点マスタ</option>
				</select>
			</div>
			<br>

		<!-- チームマスタテーブル -->
			<TABLE border="1" width="30%" id="TeamMst_insert">
			<tr>
				<th width="10%"></th>
				<th width="20%">No</th>
				<th width="70%">チーム名 (最大20字)</th>
			</tr>
		<% for(int i=0;i<20;i++){ %>
			<tr>
				<td><input type="checkbox" name="Target" value="" style="width:100%; height: 100%; margin:0 auto;"></td>
				<td><%=i+1 %></td>
				<td><input type="text" maxlength="20" name="team_name" style="width:99%; height: 100%;" value=""></td>
			</tr>
		<%} %>
			</TABLE>

			<TABLE border="1" width="30%" id="TeamMst_update">
			<tr>
				<th width="10%"></th>
				<th width="20%">No</th>
				<th width="70%">チーム名 (最大20字)</th>
			</tr>
	<%if(teamList != null){ %>
		<% for(int i=0;i<teamList.size();i++){ %>
		<%     HashMap<String,String> teamMap = teamList.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=teamMap.get("チームID") %>" style="width:100%; height: 100%;  margin:0 auto;"></td>
				<td><%=i+1 %></td>
				<td><input type="text" maxlength="20" name="team_name" style="width:99%; height: 100%;" value="<%=teamMap.get("チーム名") %>"></td>
			</tr>
		<%} %>
	<%} %>
			</TABLE>

			<TABLE border="1" width="30%" id="TeamMst_delete">
			<tr>
				<th width="10%"></th>
				<th width="20%">No</th>
				<th width="70%">チーム名</th>
			</tr>
	<%if(teamList != null){ %>
		<% for(int i=0;i<teamList.size();i++){ %>
		<%     HashMap<String,String> teamMap = teamList.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=teamMap.get("チームID") %>" style="width:100%; height: 100%;  margin:0 auto;"></td>
				<td><%=i+1 %></td>
				<td><input type="hidden" name="team_name" value="<%=teamMap.get("チーム名") %>"><%=teamMap.get("チーム名") %></td>
			</tr>
		<%} %>
	<%} %>
			</TABLE>

		<!-- 会場マスタテーブル -->
			<TABLE border="1" width="40%" id="KaijoMst_update">
			<tr>
				<th width="8%"></th>
				<th width="14.5%">No</th>
				<th width="38.5%">ホームチーム名</th>
				<th width="39%">会場名 (最大20字)</th>
			</tr>
	<%if(kaijoList != null){ %>
		<% for(int i=0;i<kaijoList.size();i++){ %>
		<%     HashMap<String,String> kaijoMap = kaijoList.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=kaijoMap.get("チームID") %>" style="width:100%; height: 100%;  margin:0 auto;"></td>
				<td><%=i+1 %></td>
				<td><%=kaijoMap.get("チーム名") %></td>
			<%if(kaijoMap.get("会場名") == null){ %>
				<td><input type="text" maxlength="20" name="team_name" style="width:99%; height: 100%;" value=""></td>
			<%}else{ %>
				<td><input type="text" maxlength="20" name="team_name" style="width:99%; height: 100%;" value="<%=kaijoMap.get("会場名") %>"></td>
			<%} %>
			</tr>
		<%} %>
	<%} %>
			</TABLE>


		<!-- 勝点マスタテーブル -->
			<TABLE border="1" width="30%" id="PointMst_update">
			<tr>
				<th width="10%"></th>
				<th width="45%">結果</th>
				<th width="45%">勝点</th>
			</tr>
	<%if(pointList != null){ %>
		<% for(int i=0;i<pointList.size();i++){ %>
		<%     HashMap<String,String> pointMap = pointList.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=pointMap.get("勝敗")%>" style="width:100%; height: 100%;  margin:0 auto;"></td>
			<%if(pointMap.get("勝敗").equals("win")){ %>
				<td>勝ち</td>
			<%}else if(pointMap.get("勝敗").equals("lose")){ %>
				<td>負け</td>
			<%}else if(pointMap.get("勝敗").equals("draw")){ %>
				<td>引き分け</td>
			<%} %>
				<td><input type="text" maxlength="20" name="team_name" style="width:99%; height: 100%; text-align: center;" value="<%=pointMap.get("勝ち点") %>"></td>
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