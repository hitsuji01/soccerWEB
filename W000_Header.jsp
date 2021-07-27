<%@ page pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="Stylesheet" href="${pageContext.request.contextPath}/Style.css" type="text/css">
	<script type="text/javascript">
		function header_button(button) {
			if(button.getAttribute('name')=='home_button'){
				document.header_form.action="W001_ShiaiItiran.jsp";
			}
			else if(button.getAttribute('name')=='hensyu_button'){
				document.header_form.to_name.value = "W005_Hensyu.jsp";
				document.header_form.action="W005_Hensyu";
			}
			else if(button.getAttribute('name')=='master_button'){
				document.header_form.to_name.value = "W009_MasterTouroku.jsp";
				document.header_form.action="W009_MasterTouroku";
			}
		}
	</script>
</head>
<body>
	<a name="top"></a>
	<div id="header">
		<h1>${param.title}画面</h1>
	</div>
	<div id="header_button">
		<form name="header_form" method="post">
		<INPUT type="hidden" name="sql_type" value="select">
		<INPUT type="hidden" name="to_name" value="">
		<INPUT type="hidden" name="sub_val">
		<TABLE border="0">
		<tr>
			<th valign="top">
				<BUTTON class="menu_button" type="submit" name="home_button" onClick="header_button(this)">HOME</BUTTON>
				<!-- <BUTTON class="menu_button" type="Button" onClick="location.href='${pageContext.request.contextPath}/W001_ShiaiItiran.jsp'">HOME</BUTTON> -->
			</th>
			<th valign="top">
				<BUTTON class="menu_button" type="submit" name="hensyu_button" onClick="header_button(this)">試合結果編集</BUTTON>
				<!-- <BUTTON class="menu_button" type="Button" onClick="location.href='${pageContext.request.contextPath}/W005_Hensyu.jsp'">試合結果編集</BUTTON> -->
			</th>
			<th valign="top">
				<BUTTON class="menu_button" type="submit" name="master_button" onClick="header_button(this)">マスタ登録</BUTTON>
			</th>
		</tr>
		</TABLE>
		</form>
		<br>
		<br>
	</div>
</body>
</html>