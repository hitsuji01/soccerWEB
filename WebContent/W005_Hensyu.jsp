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
	function setTextValue() {
		var arr = document.getElementsByName('setsu');
		for(var i=0;i<arr.length;i++){
			arr[i].value = document.form1.setsu_no.value
		}
	}

	function changeTable() {
		var radio_btn = document.form1.sql_type.value

		if(radio_btn == 'insert'){
			document.getElementById("insert_table").style.display="";
			document.getElementById("list_setsu_no").style.display="";
			document.form1.sub_button.style.visibility="visible";

			document.getElementById("other_table").style.display="none";
		}
		else if(radio_btn == 'update' || radio_btn == 'delete'){
			document.getElementById("insert_table").style.display="none";
			document.getElementById("list_setsu_no").style.display="none";
			document.form1.sub_button.style.visibility="hidden";

			document.getElementById("other_table").style.display="";
		}
	}
	</script>
</head>
<body onLoad="setTextValue()">
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
		%>
		<div id="content">
			<h2>編集</h2>
			<div id="Hensyu">
			<form name="form1" method="post">
			<INPUT type="hidden" name="to_name">
			<INPUT type="hidden" name="sub_val">
			<div>
				<input type="radio" name="sql_type" value="insert" onChange="changeTable()" checked> 追加　
				<input type="radio" name="sql_type" value="update" onChange="changeTable()"> 更新　
				<input type="radio" name="sql_type" value="delete" onChange="changeTable()"> 削除　　
				<BUTTON type="submit" name="sub_button" onClick="return getTableRecords(this)"> 確認</BUTTON>
			</div>
			<p id="list_setsu_no">
				節：
				<select name="setsu_no" onChange="setTextValue()">
					<option value="1" selected>1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
					<option value="32">32</option>
					<option value="33">33</option>
					<option value="34">34</option>
					<option value="35">35</option>
					<option value="36">36</option>
					<option value="37">37</option>
					<option value="38">38</option>
				</select>
			</p>
			<TABLE border="1" width="100%" id="insert_table">
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
		<% for(int i=1; i<=10; i++){ %>
			<tr>
				<td><input type="checkbox" name="Target" value="2" style="width:100%; height: 100%;"></td>
				<td><%=i %></td>
				<td><input size="2"  type="text" name="setsu" style="width:98%; height: 100%; text-align: center;" readonly></td>
				<td><input size="10" type="text" name="day"  placeholder="YYYY-MM-DD" style="width:98%; height: 100%;"></td>
				<td><input size="5"  type="text" name="time" placeholder="HH:MM"      style="width:98%; height: 100%;"></td>
				<td>
					<select name="home" style="width:98%; height: 100%;">
					<option value="" selected></option>
			<%if(list != null){ %>
				<% for(HashMap<String,String> map : list){ %>

					<option value="<%=map.get("チーム名") %>"><%=map.get("チーム名") %></option>

				<%} %>
			<%} %>
					</select>
				</td>
				<td>
					<select name="away" style="width:98%; height: 100%;">
					<option value="" selected></option>
			<%if(list != null){ %>
				<% for(HashMap<String,String> map : list){ %>

					<option value="<%=map.get("チーム名") %>"><%=map.get("チーム名") %></option>

				<%} %>
			<%} %>
					</select>
				</td>
				<td><input size="2" type="text" name="score_home" placeholder="得点" style="width:95%; height: 100%;"></td>
				<td><input size="2" type="text" name="score_away" placeholder="得点" style="width:95%; height: 100%;"></td>
			</tr>
		<% } %>
			</TABLE>
			<br>
			<TABLE border="1" width="100%" id="other_table" style="display:none">
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="1"  onClick="return getTableRecords(this)">第１節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="20"  onClick="return getTableRecords(this)">第２０節</BUTTON>
				</td>
			</tr>

			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="2"  onClick="return getTableRecords(this)">第２節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="21"  onClick="return getTableRecords(this)">第２１節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="3"  onClick="return getTableRecords(this)">第３節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="22"  onClick="return getTableRecords(this)">第２２節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="4"  onClick="return getTableRecords(this)">第４節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="23"  onClick="return getTableRecords(this)">第２３節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="5"  onClick="return getTableRecords(this)">第５節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="24"  onClick="return getTableRecords(this)">第２４節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="6"  onClick="return getTableRecords(this)">第６節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="25"  onClick="return getTableRecords(this)">第２５節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="7"  onClick="return getTableRecords(this)">第７節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="26"  onClick="return getTableRecords(this)">第２６節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="8"  onClick="return getTableRecords(this)">第８節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="27"  onClick="return getTableRecords(this)">第２７節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="9"  onClick="return getTableRecords(this)">第９節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="28"  onClick="return getTableRecords(this)">第２８節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="10"  onClick="return getTableRecords(this)">第１０節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="29"  onClick="return getTableRecords(this)">第２９節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="11"  onClick="return getTableRecords(this)">第１１節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="30"  onClick="return getTableRecords(this)">第３０節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="12"  onClick="return getTableRecords(this)">第１２節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="31"  onClick="return getTableRecords(this)">第３１節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="13"  onClick="return getTableRecords(this)">第１３節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="32"  onClick="return getTableRecords(this)">第３２節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="14"  onClick="return getTableRecords(this)">第１４節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="33"  onClick="return getTableRecords(this)">第３３節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="15"  onClick="return getTableRecords(this)">第１５節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="34"  onClick="return getTableRecords(this)">第３４節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="16"  onClick="return getTableRecords(this)">第１６節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="35"  onClick="return getTableRecords(this)">第３５節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="17"  onClick="return getTableRecords(this)">第１７節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="36"  onClick="return getTableRecords(this)">第３６節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="18"  onClick="return getTableRecords(this)">第１８節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="37"  onClick="return getTableRecords(this)">第３７節</BUTTON>
				</td>
			</tr>
			<tr>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="19"  onClick="return getTableRecords(this)">第１９節</BUTTON>
				</td>
				<td>
					<BUTTON class="setsu_button" name="setsu_button" type="submit" value="38"  onClick="return getTableRecords(this)">第３８節</BUTTON>
				</td>
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