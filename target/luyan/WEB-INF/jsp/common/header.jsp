<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<li><a>宝贝梁宇雁的在线课堂</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">

						<li><a>${userName}</a></li>
						<li><a href="${pageContext.request.contextPath}/logOut"><i
								style="font-size: 25px;" class="fa fa-sign-out"
								aria-hidden="true"></i></a></li>
					</ul>
				</div>
				</nav>
			</div>
		</div>