<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="Stylesheet" href="${pageContext.request.contextPath}/Style.css" type="text/css">
</head>
<body>
 	<!-- コンテナ開始 -->
	<div id="container">

		<!-- ヘッダ開始 -->
		<%
			String msg = (String)request.getAttribute("msg");
		%>
		<jsp:include page="W000_Header.jsp">
 			<jsp:param name="title" value="完了"/>
 		</jsp:include>
		<!-- ヘッダ終了 -->


		<!-- コンテンツ開始 -->
		<div id="content">
			<h2>完了</h2>
			<p>
				<font color="black" size="+1"><b><%=msg %></b></font>
			</p>
		</div>
		<!-- コンテンツ終了 -->


		<!-- フッタ開始 -->
		<jsp:include page="W000_Footer.jsp"/>
		<!-- フッタ終了 -->


	</div>
	<!-- コンテナ終了 -->

</body>
</html>