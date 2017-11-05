<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>老师管理界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
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
<link
	href="${pageContext.request.contextPath}/css/bootstrap-treeview.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/font-awesome.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/css/font-awesome.min1.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/teacher.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/verticalMenu.css"
	rel="stylesheet" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
</head>
<body>
	<div class="rootContainer">
		<div class=""
			style="margin: 0 auto; min-width: 1000px; background-color: #f0f0f0;">
			<div class="navbarDiv">
				<nav class="navbar navbar-inverse navbar-embossed" role="navigation">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<a class="navbar-brand" href="#" style="padding: 6px 13px;"><img
						style="width: 40px; height: 40px;"
						src="${pageContext.request.contextPath}/img/icons/svg/blackboard.svg"
						alt="" /></a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="navbar-collapse-5">
					<ul class="nav navbar-nav">
						<li id="publishPaper" class="menuItem"
							contentId="publishContentDiv"><a href="#">出题</a></li>
						<li id="query" class="menuItem" contentId="queryContentDiv"><a
							href="#">查询</a></li>
						<li id="addPeople" class="menuItem" contentId="addContentDiv"><a
							href="#">添加</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">
						<li><a href="${pageContext.request.contextPath}/logOut"><i
								style="font-size: 25px;" class="fa fa-sign-out"
								aria-hidden="true"></i></a></li>
					</ul>
				</div>
				</nav>

			</div>


		</div>
		<div class="mainContainer">

			<div id="publishContentDiv" style="display: none"
				class="jumbotron contentDiv subjectsDiv">
				<div class="container subjectTotalDiv"></div>
				<div class="container subjectContentDiv">
					<div class="subjectHeaderDiv row pbl">

						<div class="row">
							<div class="form-group has-feedback">
								<input id="subjectName" type="text" value="" placeholder="题目"
									class="form-control" /> <span
									class="form-control-feedback fui-new"></span>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label class="radio radio-inline" for="lineRadio"> <input
									name="optionsRadios2" type="radio" data-toggle="radio" value=""
									id="lineRadio" required checked> 选择
								</label> <label class="radio  radio-inline" for="chooseRadio"> <input
									name="optionsRadios2" type="radio" data-toggle="radio" value=""
									id="chooseRadio" required> 连线
								</label> <label class="radio  radio-inline" for="fillRadio"> <input
									name="optionsRadios2" type="radio" data-toggle="radio" value=""
									id="fillRadio" required> 填空
								</label>
							</div>
						</div>
					</div>
					<div class="subjectDetailDiv row pbl"></div>
					<div class="subjectFootDiv row pbl"></div>
				</div>
			</div>
			<div id="queryContentDiv" style="display: none"
				class="jumbotron contentDiv queryDiv"></div>
			<div id="addContentDiv" style="display: none"
				class="jumbotron contentDiv addDiv"></div>
			<div style="display: block" class="jumbotron contentDiv tempDiv">
				<div class="" style="text-align: center">
					<h3>全国最大的在线考试中心上线啦~</h3>
					<h3>性感美女在线出题~</h3>
					<h3>好玩停不下来</h3>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var paper = {
		nowSubjectNum : 1,

	};
	$(document).ready(function() {
		//刚刚加载进来
		//添加点击事件
		//1.顶部菜单
		$(".menuItem").click(function() {
			topMenuClick($(this));

		});

	});

	function topMenuClick(thisEle) {
		//顶部菜单发生点击事件
		//1.去掉所有的active效果
		$(".menuItem").removeClass("active");
		//2.给这个元素添加active的class
		thisEle.addClass("active");
		//3.切换content
		changeContentDiv(thisEle.attr("contentId"));
	}
	function changeContentDiv(contentId) {
		//1.隐藏所有contentDiv
		$(".contentDiv").css("display", "none");

		//2.显示这个id的DIV
		$("#" + contentId).css("display", "block");

	}
</script>
.


</html>