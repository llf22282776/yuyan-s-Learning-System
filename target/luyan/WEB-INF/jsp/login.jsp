<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>梁宇雁的在线学习课堂</title>

<script src="${pageContext.request.contextPath}/js/jquery.js"></script>



<script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
<script src="${pageContext.request.contextPath}/js/flat-ui.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/application.js"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/sweetalert2.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/flat-ui.css"
	rel="stylesheet" />


</head>
<body>
	<div class="login"
		style="width: 940px; margin-left: 20%; margin-top: 3%;">
		<div class="login-screen">
			<div class="login-icon">
				<img
					src="${pageContext.request.contextPath}/img/icons/svg/ice.svg"
					alt="" />
				<h4>
					<strong>欢迎来到</strong> <small style="line-height: 22px;">在线学习课堂</small>
				</h4>
			</div>

			<div class="login-form">
				<div class="form-group">
					<input class="form-control login-field" value="" placeholder="账号"
						id="userNameInput" type="text"> <label
						class="login-field-icon fui-user" for="userNameInput"></label>
				</div>

				<div class="form-group" >
					<input class="form-control login-field" value="" placeholder="密码"
						id="passwordInput" type="password"> <label
						class="login-field-icon fui-lock" for="passwordInput"></label>
				</div>
	
				<div class="form-group" style="margin-bottom: -4px;">

					<button type="button" class="btn  btn-primary" id="loginButton"
						style="width: 100%;">登陆</button>

				</div>
				<a class="login-link" href="#" style="text-decoration: underline;">忘记账号密码？</a>
			</div>
		</div>
	</div>


	</div>

	<script>
		$("#loginButton").bind("click", function() {
			var passport = $('#userNameInput').val();
			var password = $('#passwordInput').val();


			$.ajax({
				url : "${pageContext.request.contextPath}/login",
				type : "POST",
				data : {
					"passport" : passport,
					"password" : password,

				},
				dataType : "JSON",
				success : function(data) {
					if (data.result == "true" || data.result == true) {
						location.href = "${pageContext.request.contextPath}/";
					} else {
						swal("error", data.des, "warning");
					}
				},
				error : function(e) {
					swal("error", e.message, "error");
				}

			});
		});
		$(".login-link").bind("click", function() {

			swal("", "账号是需要添加的，请联系微信号:llf_soft,本人帅哥", "info");

		});
		$(".login-field").bind("keydown", function(e) {

			if (e.which == 13) {
				$("#loginButton").click();

			}

		});
	</script>
</body>
</html>