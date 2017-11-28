<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
<script src="${pageContext.request.contextPath}/js/flat-ui.js"></script>
<script src="${pageContext.request.contextPath}/js/BootstrapMenu.min.js"></script>
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
<link href="${pageContext.request.contextPath}/css/student.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/cropper.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/cropper.js"></script>

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
</head>
<body>
	<div class="rootContainer">
		<%@include file="./common/header.jsp"%>
		<div class="">
			<div class="jumbotron contentDiv navigatorDiv">

				<div class="navigatorContentDiv row">
					<div class="navigatorItem col-md-6 row">
						<c:choose>
								<c:when test="${paperNums<=0}">
									<div style="display:none" class="badge col-md-3">${paperNums}</div>
								</c:when>
								<c:otherwise>
									<div style="display:block" class="badge col-md-3">${paperNums}</div>
								</c:otherwise>
							</c:choose>

						<div class="nButtonDiv col-md-3">
							
							<a id="" class="subIconLink" href="${pageContext.request.contextPath}/getStudentNodoingPaperPage"><img
								src="${pageContext.request.contextPath}/img/icons/svg/paper.svg" /></a>
						</div>
						<div class="coverDiv col-md-3">待做试卷</div>
					</div>
					<div class="navigatorItem col-md-6 row">

						<div class="nButtonDiv col-md-3">
							<a id="" class="subIconLink" href="${pageContext.request.contextPath}/getQueryListPage"><img
								src="${pageContext.request.contextPath}/img/icons/svg/video.svg" /></a>
						</div>
						<div class="coverDiv col-md-3">历史试卷</div>
					</div>

				</div>


			</div>




		</div>
	</div>
</body>
<script>
function timerFunction(){
	//定时函数
	
	
}
function chanageBadge(){
	//改变右上角的符号
	
}






</script>

</html>