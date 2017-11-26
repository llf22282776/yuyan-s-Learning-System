<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/jcanvas.js"></script>

<script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
<script src="${pageContext.request.contextPath}/js/flat-ui.js"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap-treeview.min.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/application.js"></script>
<link
	href="${pageContext.request.contextPath}/css/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/sweetalert2.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/flat-ui.css"
	rel="stylesheet" />

<link href="${pageContext.request.contextPath}/css/font-awesome.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/font-awesome.min1.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/queryCommon.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<link href="${pageContext.request.contextPath}/css/cropper.css"
	rel="stylesheet">

<script src="${pageContext.request.contextPath}/js/commonPaper.js"></script>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
	<script>
	BasePath="${pageContext.request.contextPath}";

	</script>

</head>
<body>

	<div class="rootContainer">
		<%@include file="../common/header.jsp"%>
		<div class="">
			<div style="display: block" class="jumbotron contentDiv queryDiv">
				<%@include file="../common/queryCommon.jsp"%>
			</div>

		</div>

	</div>
</body>
<script src="${pageContext.request.contextPath}/js/queryCommon.js"></script>
</html>