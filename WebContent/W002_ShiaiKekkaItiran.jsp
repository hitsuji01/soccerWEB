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
			//alert(document.form1.sub_val.value);

			if(button.getAttribute('name')=='team'){
				document.form1.to_name.value = "W003_TeamShousai.jsp";
				document.form1.action="W003_TeamShousai";
			}
			else if(button.getAttribute('name')=='score'){
				document.form1.to_name.value = "W004_ScoreShousai.jsp";
				document.form1.action="W004_ScoreShousai";
			}
		}

		function setParam() {

			var db_date = document.form1.elements["db_size"].value

			if(db_date > 0){
				document.getElementById("no_date").style.display="none";
			}
			else{
				document.getElementById("no_date").style.display="";
			}
		}

	</script>

</head>
<body onLoad="setParam()">
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="試合結果一覧"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<%
			ArrayList<HashMap<String,String>> list = (ArrayList<HashMap<String,String>>)request.getAttribute("list");
		%>
		<div id="content">
			<BUTTON type="Button" onClick="location.href='./W001_ShiaiItiran.jsp'">戻る</BUTTON>
			<h2>第<%=request.getAttribute("setsu") %>節</h2>
			<div id="ShiaiKekkaItiran">
			<form name="form1" method="post">
			<INPUT type="hidden" name="sub_val">
			<INPUT type="hidden" name="sql_type" value="select">
			<INPUT type="hidden" name="to_name" value="">
		<%if(list != null){ %>
			<INPUT type="hidden" name="db_size" value="<%=list.size() %>">
		<%}else{ %>
			<INPUT type="hidden" name="db_size" value="0">
		<%} %>
			<TABLE border="1" width="100%">
			<tr>
				<th width="13%">試合日</th>
				<th width="13%">キックオフ</th>
				<th width="22%">ホーム</th>
				<th width="30%">スコア</th>
				<th width="22%">アウェー</th>
			</tr>
	<%if(list != null){ %>
		<% for(HashMap<String,String> map : list){ %>
			<tr>
				<td>
					<%=map.get("試合日") %>
				</td>
				<td>
					<%=map.get("キックオフ") %>
				</td>
				<td>
					<BUTTON type="submit" name="team" value="<%=map.get("ホーム") %>" onClick="setValue(this)"><%=map.get("ホーム") %></BUTTON>
				</td>
				<td>
					<BUTTON type="submit" name="score" value="<%=map.get("節") %>,<%=map.get("ホーム") %>,<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("ホームスコア") %>　vs　<%=map.get("アウェースコア") %></BUTTON>
				</td>
				<td>
					<BUTTON type="submit" name="team" value="<%=map.get("アウェー") %>" onClick="setValue(this)"><%=map.get("アウェー") %></BUTTON>
				</td>
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