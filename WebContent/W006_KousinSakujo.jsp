<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="Stylesheet" href="${pageContext.request.contextPath}/Style.css" type="text/css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script type="text/javascript" src="getTableRecords.js"></script>
	<script>
	function setParam() {

		// ラジオボタンの選択状態を設定
		var sql_type = '<%=request.getAttribute("sql_type") %>';

		if(sql_type == 'update'){
			document.getElementsByName("sql_type")[1].checked = true;
		}
		else if(sql_type == 'delete'){
				document.getElementsByName("sql_type")[2].checked = true;
		}

		// データ件数が0件ならメッセージを表示
		var db_date = document.form1.elements["db_size"].value
		if(db_date > 0){
			document.getElementById("no_date").style.display="none";
		}
		else{
			document.getElementById("no_date").style.display="";
		}

		// リストボックスの選択状態を設定
		var home =  document.getElementsByName("home");
		var away =  document.getElementsByName("away");

		var home_list = document.getElementsByName("home_team");
		var away_list = document.getElementsByName("away_team");

		// 項目：ホームの値を設定
		for(var i=0; i<home.length;i++){
			var home_list_op = home_list[i].getElementsByTagName('option');
			for(var j=0; j<home_list_op.length;j++){
				if(home_list_op[j].value == home[i].value){
					home_list_op[j].selected = true;
					break;
				}
			}
		}

		// 項目：アウェーの値を設定
		for(var i=0; i<away.length;i++){
			var away_list_op = away_list[i].getElementsByTagName('option');
			for(var j=0; j<away_list_op.length;j++){
				if(away_list_op[j].value == away[i].value){
					away_list_op[j].selected = true;
					break;
				}
			}
		}

		changeTable();
	}

	function changeTable() {
		var radio_btn = document.form1.sql_type.value;
		var chk_btn = document.getElementsByName("Target");

		// チェックボックスのチェックを全解除
		for(var i=0;i<chk_btn.length;i++){
			chk_btn[i].checked = false;
		}

		if(radio_btn == 'update'){
			document.getElementById("update_table").style.display="";
			document.getElementById("delete_table").style.display="none";
		}
		else if(radio_btn == 'delete'){
			document.getElementById("update_table").style.display="none";
			document.getElementById("delete_table").style.display="";
		}
	}
	</script>
</head>
<body onLoad="setParam()">
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="試合結果編集"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<%
			ArrayList<HashMap<String,String>> list = (ArrayList<HashMap<String,String>>)request.getAttribute("list");
			ArrayList<HashMap<String,String>> team = (ArrayList<HashMap<String,String>>)request.getAttribute("team_name");
		%>
		<div id="content">
			<BUTTON type="Button" onClick="history.back()">戻る</BUTTON>
			<h2>更新/削除</h2>
			<div id="Hensyu">
			<form name="form1" method="post">
			<INPUT type="hidden" name="to_name" value="">
			<INPUT type="hidden" name="sub_val">
		<%if(list != null){ %>
			<INPUT type="hidden" name="db_size" value="<%=list.size() %>">
		<%}else{ %>
			<INPUT type="hidden" name="db_size" value="0">
		<%} %>
			<div>
				<input type="radio" name="sql_type" value="update" onChange="changeTable()"> 更新　
				<input type="radio" name="sql_type" value="delete" onChange="changeTable()"> 削除　　
				<BUTTON type="submit" name="sub_button" onClick="return getTableRecords(this)"> 確認</BUTTON>
			</div>
			<br>
			<TABLE border="1" width="100%" id="update_table">
			<tr>
				<th width="4%"></th>
				<th width="5%">No</th>
				<th width="5%">節</th>
				<th width="10%">試合日</th>
				<th width="10%">キックオフ</th>
				<th width="15%">ホーム</th>
				<th width="15%">アウェー</th>
				<th width="8%">スコア<br>(ホーム)</th>
				<th width="8%">スコア<br>(アウェー)</th>
			</tr>
	<%if(list != null){ %>
		<% for(int i=0;i<list.size();i++){ %>
		<%     HashMap<String,String> map = list.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=map.get("id") %>" style="width:100%; height: 100%;"></td>
				<td><%=i+1 %></td>
				<td><input size="2"  type="text" name="setsu" style="width:95%; height: 100%; text-align: center;" value="<%=map.get("節") %>" readonly></td>
				<td><input size="10" type="text" name="day"   style="width:95%; height: 100%;" value="<%=map.get("試合日") %>"     placeholder="YYYY-MM-DD" style="width:95%;"></td>
				<td><input size="5"  type="text" name="time"  style="width:95%; height: 100%;" value="<%=map.get("キックオフ") %>" placeholder="HH:MM" style="width:95%;"></td>
				<td>
					<input type="hidden" name="home" value="<%=map.get("ホーム") %>">
					<select name="home_team" style="width:98%; height: 100%;">
			<%if(team != null){ %>
				<% for(HashMap<String,String> team_name : team){ %>

					<option value="<%=team_name.get("チーム名") %>"><%=team_name.get("チーム名") %></option>

				<%} %>
			<%} %>
					</select>
				</td>
				<td>
					<input type="hidden" name="away" value="<%=map.get("アウェー") %>">
					<select name="away_team" style="width:98%; height: 100%;">
			<%if(team != null){ %>
				<% for(HashMap<String,String> team_name : team){ %>

					<option value="<%=team_name.get("チーム名") %>"><%=team_name.get("チーム名") %></option>

				<%} %>
			<%} %>
					</select>
				</td>
				<td><input size="2"  type="text" name="score_home" style="width:95%; height: 100%;" value="<%=map.get("ホームスコア") %>"   placeholder="得点" style="width:95%;"></td>
				<td><input size="2"  type="text" name="score_away" style="width:95%; height: 100%;" value="<%=map.get("アウェースコア") %>" placeholder="得点" style="width:95%;"></td>
			</tr>
		<% } %>
	<%} %>
			</TABLE>
			<TABLE border="1" width="100%" id="delete_table" style="display:none">
			<tr>
				<th width="4%"></th>
				<th width="5%">No</th>
				<th width="5%">節</th>
				<th width="10%">試合日</th>
				<th width="10%">キックオフ</th>
				<th width="15%">ホーム</th>
				<th width="15%">アウェー</th>
				<th width="8%">スコア<br>(ホーム)</th>
				<th width="8%">スコア<br>(アウェー)</th>
			</tr>
	<%if(list != null){ %>
		<% for(int i=0;i<list.size();i++){ %>
		<%     HashMap<String,String> map = list.get(i); %>
			<tr>
				<td><input type="checkbox" name="Target" value="<%=map.get("id") %>" style="width:100%; height: 100%;"></td>
				<td><%=i+1 %></td>
				<td><input type="hidden" name="setsu" value="<%=map.get("節") %>"><%=map.get("節") %></td>
				<td><input type="hidden" name="day"   value="<%=map.get("試合日") %>"><%=map.get("試合日") %></td>
				<td><input type="hidden" name="time"  value="<%=map.get("キックオフ") %>"><%=map.get("キックオフ") %></td>
				<td><input type="hidden" name="home_team" value="<%=map.get("ホーム") %>"><%=map.get("ホーム") %></td>
				<td><input type="hidden" name="away_team" value="<%=map.get("アウェー") %>"><%=map.get("アウェー") %></td>
				<td><input type="hidden" name="score_home" value="<%=map.get("ホームスコア") %>"><%=map.get("ホームスコア") %></td>
				<td><input type="hidden" name="score_away" value="<%=map.get("アウェースコア") %>"><%=map.get("アウェースコア") %></td>
			</tr>
		<% } %>
	<%} %>
			</TABLE>
			</form>
			<div id="no_date" style="display:none">
				<font color="red" size="+1"><b>試合データがありません</b></font>
			</div>
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