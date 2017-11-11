<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="${pageContext.request.contextPath}/css/cropper.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/cropper.js"></script>
<script src="${pageContext.request.contextPath}/js/audioPlugs.js"></script>
<script
	src="${pageContext.request.contextPath}/js/menclickAndsubject.js"></script>
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

						<li><a>${userName}</a></li>
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
				<div style="display: block" class="container sDiv subjectTotalDiv">
					<div class="paperTitleDiv buttomLineDiv row pbl">
						<div class="form-group  has-feedback">
							<input type="text" value="" placeholder="试卷标题"
								class="form-control paperTitleInput" /> <span
								class="form-control-feedback fui-new"></span>
						</div>


					</div>


					<div class="overviewSubjectDiv row pbl">
						<!-- 这个div里面放置总卡片 ，初始情况没有-->
					</div>
					<div class="addSubjectDiv row pbl buttomLineDiv"
						style="text-align: center;">
						<!-- 有个大大的加号,居中 -->
						<a title="添加题目" id="subjectAddButton" class="subIconLink"
							data-toggle="tooltip" href="#"><span
							class="fui-plus-circle iconSubject addIcon"></span></a>
					</div>
					<div class="submitPaperButton  row pbl">
						<!-- 有个好看的提交按钮 -->
						<div class="col-md-4" style="text-align: center;">
							<a title="帮助" id="subjectHelpButton" class="subIconLink"
								data-toggle="tooltip" href="#"> <span
								class="fui-bubble iconSubject" style="color: #cccccc"></span>
							</a>
						</div>
						<div class="col-md-4" style="text-align: center"></div>
						<div class="col-md-4" style="text-align: center">
							<a title="提交" id="subjectSubmitButton" class="subIconLink"
								data-toggle="tooltip" href="#"> <span
								class="fui-check-circle iconSubject"></span>
							</a>
						</div>
					</div>
				</div>
				<div style="display: none" class="container sDiv subjectContentDiv">
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
									id="lineRadio" class="subjectRadio nowRadio" subjectType=0
									required checked> 连线
								</label> <label class="radio  radio-inline" for="chooseRadio"> <input
									name="optionsRadios2" type="radio" data-toggle="radio" value=""
									id="chooseRadio" class="subjectRadio" subjectType=1 required>
									选择
								</label> <label class="radio  radio-inline" for="fillRadio"> <input
									name="optionsRadios2" type="radio" data-toggle="radio" value=""
									id="fillRadio" class="subjectRadio" subjectType=2 required>
									填空
								</label>
							</div>
						</div>
					</div>
					<div class="subjectDetailDiv row pbl">
						<!-- 这里有三个面板，出连线题，选择题，填空题，三个形式 -->
						<div style="display: block" class="lineRadio-subjectDiv sContDiv">
							<div class="row pbl">
								<!-- 几个并排的连线垂直div，width -->
								<c:forEach begin="0" end="3" varStatus="status">
									<div class="oneLineRadio col-md-12" index=${status.index}>
										<div class="row">
											<div class="picPainter getter" completed="false">
												<img id="linePic${status.index}" class="linePic"
													src="${pageContext.request.contextPath}/img/temp.png" />
											</div>
										</div>
										<div class="row">

											<a data-toggle="tooltip" title="上传图片" id=""
												class="picButton eleIcon"> <span
												class="fui-upload eleIcon"></span>
											</a> <input class="fileInputNoView picInput" type="file"
												accept="image/png,image/gif,image/jpg,image/bmp" />


										</div>
										<div class="row">

											<div class="mp3Getter getter" completed="false">
												<a title="录制音频" id="" class="audioButton eleIcon"
													data-toggle="tooltip"> <span class="fui-mic eleIcon"></span>
												</a>
												<div class="modal fade audioRecordModal" tabindex="-1"
													role="dialog" aria-hidden="true">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-body">
																<!--第一行放置audio标签-->
																<div class="row audioRow"></div>
																<!-- 第二行放置按钮，开始/停止 确定三个按钮，2列 -->
																<div class="row pbl">
																	<div class="col-md-4">
																		<a id="" class="audioStartButton eleIcon"> <span
																			class="fui-volume"></span>
																		</a> <a style="display: none" id=""
																			class="audioStopButton eleIcon"> <span
																			class="fui-checkbox-unchecked"></span>
																		</a>

																	</div>
																	<div class="col-md-4">


																		<a id="" class="audioSureButton eleIcon"> <span
																			class="fui-check-circle"></span>
																		</a>
																	</div>

																</div>
															</div>
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal -->
												</div>
											</div>


										</div>
										<div class="row">
											<div class="wordGetter getter" completed="false">
												<div class="form-group  has-feedback inputGroup">
													<input type="text" value="" placeholder="单词"
														class="form-control wordInput" /> <span
														class="form-control-feedback fui-new"></span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="scoreGetter getter" completed="false">
												<div class="form-group inputGroup">
													<input type="text" value="" placeholder="分数"
														class="form-control numberOnlyInput scoreInput" />
												</div>

											</div>
										</div>
									</div>

								</c:forEach>


							</div>

						</div>
						<div style="display: none" class="chooseRadio-subjectDiv sContDiv">

							<c:forEach begin="0" end="3" varStatus="status">
								<div class="row">
									<div class="form-group chooseSubjectGroup">

										<label class="radio radio-inline col-sm-1"
											for="chooseInputRadio${status.index+1}"> <input
											name="optionsRadios3" type="radio" data-toggle="radio"
											value="" id="chooseInputRadio${status.index+1}"
											class="chooseRadio" index="${status.index}" required>
										</label>
										<div class="col-sm-8">
											<input type="text" class="form-control chooseInput"
												completed="false" id="chooseInput${status.index+1}"
												placeholder="填写选择题的选项">
										</div>
									</div>
								</div>
							</c:forEach>



						</div>
						<div style="display: none" class="fillRadio-subjectDiv sContDiv">
							<h1>填空</h1>
						</div>
					</div>
					<div class="subjectFootDiv row pbl topLineDiv">
						<div class="col-md-6" style="text-align: left">
							<a title="取消" levelDiv="sDiv" lastDiv="subjectTotalDiv"
								class="cancelButton subIconLink " data-toggle="tooltip" href="#">
								<span class="fui-cross-circle iconSubject cancelIcon"></span>
							</a>


						</div>
						<div class="col-md-6" style="text-align: right">
							<a title="确定" id="subjectSureButton" lastDiv="subjectTotalDiv"
								class="subIconLink  " data-toggle="tooltip"> <span
								class="fui-check-circle iconSubject sureIcon"></span>
							</a>

						</div>


					</div>
				</div>
			</div>
			<div id="queryContentDiv" style="display: none"
				class="jumbotron contentDiv queryDiv"></div>
			<div id="addContentDiv" style="display: none"
				class="jumbotron contentDiv addDiv">
				<div class="container jumbotron addContent">

					<div class=" groupRow row" completed=false>
						<div class="col-sm-11">
							<div class="form-group row has-feedback">
								<input type="text" value="" placeholder="姓名"
									class="form-control inputGer addContentInput addNameInput" />
								<span class="form-control-feedback fui-heart"></span>
							</div>
						</div>
						<div class="col-sm-1">
							<span class="msgSpan"></span>
						</div>
					</div>
					<div style="display: none" class="row tipText">姓名中不可以有空格和非法字符</div>


					<div class=" groupRow row" completed=false>
						<div class="col-sm-11">
							<div class="form-group row has-feedback">
								<input type="text" value="" placeholder="账号"
									class="form-control inputGer addContentInput addUidInput" /> <span
									class="form-control-feedback fui-user"></span>
							</div>
						</div>
						<div class="col-sm-1">
							<span class="msgSpan"></span>
						</div>
					</div>

					<div style="display: none" class="row tipText">只允许数字，字母和，下划线</div>


					<div class=" groupRow row" completed=false>
						<div class="col-sm-11">
							<div class="form-group row has-feedback">
								<input type="password" value="" placeholder="密码"
									class="form-control inputGer addContentInput addPasswordInput" />
								<span class="form-control-feedback fui-lock"></span>
							</div>
						</div>
						<div class="col-sm-1">
							<span class="msgSpan"></span>
						</div>
					</div>
					<div style="display: none" class="row tipText">密码长度大于6位小于16位，只能有数字,字母,下划线</div>


					<div class=" groupRow row " completed=false>
						<div class="col-sm-11">
							<div class="form-group row has-feedback">
								<input type="password" value="" placeholder="确认密码"
									class="form-control inputGer checkPassWordInput" /> <span
									class="form-control-feedback fui-lock"></span>
							</div>
						</div>
						<div class="col-sm-1">
							<span class="msgSpan"></span>
						</div>
					</div>
					<div style="display: none" class="row tipText">密码不一致</div>

					<div class=" groupRow row">
						<label class="radio radio-inline" for="teacherRadio"> <input
							name="optionsRadios4" type="radio" data-toggle="radio" value=""
							id="teacherRadio" class="addRadio nowAddRadio" position=1
							required checked> 老师
						</label> <label class="radio  radio-inline" for="studentRadio"> <input
							name="optionsRadios4" type="radio" data-toggle="radio" value=""
							id="studentRadio" class="addRadio" position=0 required>
							学生
						</label>
					</div>
					<div class=" groupRow row">
						<a title="提交" id="addUserButton" class="subIconLink" >
							<span class="fui-check-circle iconSubject"></span>
						</a>

					</div>
				</div>






			</div>
			<div style="display: block" class="jumbotron contentDiv tempDiv">
				<div class="" style="text-align: center">
					<h3>全国最大的在线考试中心上线啦~</h3>
					<h3>性感美女在线出题~</h3>
					<h3>1秒到账，好玩停不下来</h3>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var paper = {
		subjects : [],
		date : "2017-10-10 10:10:00",
		title : "一张试卷",
		totalScore : 0,
		subjectsNum : 0,
		pid : -1,
	};
	var nowSubject = {
		type : 0,
		title : "",
		totalScore : 10,
		elements : [],
		index : 0

	};
	var element = {
		text : "",
		word : "",
		pic : "",
		score : "",
		audio : ""
	};
	var audios = [];
	var lastIndex = 0;

	$(document).ready(function() {
		//刚刚加载进来
		//设置提示
		$('[data-toggle=tooltip]').tooltip();
		//添加点击事件
		//1.顶部菜单
		$(".menuItem").click(function() {
			topMenuClick($(this));

		});
		//2.添加按钮单击事件
		$("#subjectAddButton").click(function() {

			subjectAddButtonClick();

		});
		//3.题型面板切换事件
		$(".subjectRadio").click(function() {
			subjectRadioClick($(this));

		});
		//4.给返回按钮添加点击事件
		$(".cancelButton").click(function() {

			cancelButtonClick($(this));

		});
		//-------
		//初始化剪裁器
		$('.linePic').cropper({
			aspectRatio : NaN,
			crop : function(e) {
				// Output the result data for cropping image.
				console.log(e);
			}
		});
		//图片上传按钮点击事件
		$(".picButton").click(function() {

			picButtonClick($(this));

		});
		//图片文件选择事件
		$(".picInput").change(function() {

			picFileChange($(this));

		});
		//上传音频点击事件
		$(".audioButton").click(function() {

			audioUploadClick($(this));

		});
		//音频开始录制点击事件

		$(".audioStartButton").click(function() {
			//开始录制声音
			startWordAudioRecord($(this));
		});
		//音频结束录制点击事件
		$(".audioStopButton").click(function() {
			//结束录制声音
			stopWordAudioRecord($(this));
		});
		//音频确认录制点击事件
		$(".audioSureButton").click(function() {
			//
			sureAudioRecord($(this));
		});
		//数字输入框输入事件
		$(".numberOnlyInput").keypress(function(evt) {
			var ev = evt.which ? evt.which : window.event.keyCode;
			if (ev >= 48 && ev <= 57 || ev == 8) {
				return true;
			} else {
				return false;
			}
		}).focus(function() {
			this.style.imeMode = 'disabled';
		});
		//题目框输入事件
		$(".paperTitleInput").keypress(function(evt) {
			var t = $(this).val().trim();
			if (t != "") {
				return true;
			} else {
				return false;
			}
		});
		$("#subjectHelpButton").click(function() {
			//
			swal("", "我微信号:llf_soft,仅限姑娘联系，谢谢", "info");

		});
		//  数字/单词输入框光标离开
		$(".wordInput").blur(function() {
			wordInputCheck($(this));

		});
		$(".scoreInput").blur(function() {
			scoreInputCheck($(this));

		});
		//选择题选项
		$(".chooseInput").blur(function() {
			chooseInputCheck($(this));
		});
		$("#subjectSureButton").click(function() {

			subjectSureButtonClick($(this));

		});
		//上传试卷时间
		$("#subjectSubmitButton").click(function() {

			upLoadPaper($(this));

		});

		//选择题选项被点击
		$(".chooseRadio").click(function() {
			radioChooseClick($(this));

		});
		//添加人员输入框
		$(".addContentInput").blur(function() {
			userInputBlur($(this));

		});
		//检察密码输入框
		$(".checkPassWordInput").blur(function() {
			checkPasswordEqual($(this));
		});
		//position radio选项
		$(".addRadio").click(function() {
			positionRadioClick($(this));
		});
		$("#addUserButton").click(function() {
			sumitPeople($(this));
		});
		
	});

	function checkNumOrLitterOrsubLine(thisEle) {
		//是不是数字字母和下划线,如果是姓名
		var reg1 = /(^\s+)|(\s+$)/g;
		var reg2 = /^[\w]{6,12}$/;
		if (thisEle.hasClass("addNameInput")) {
			//执行第一个reg1
			return !reg1.test(thisEle.val());
		} else {
			return reg2.test(thisEle.val());

		}

	}
	function userInputBlur(thisEle) {
		//检察是不是合适
		if (checkNumOrLitterOrsubLine(thisEle) == false) {
			//显示出下面的div
			//显示错
			changeDivRightOrWrong(thisEle, false);
		} else {
			//收起div
			//显示对
			changeDivRightOrWrong(thisEle, true);

		}

	}
	function changeDivRightOrWrong(thisEle, type) {
		var textDivEle = thisEle.closest(".groupRow").next();//
		var spanEle = thisEle.closest(".groupRow").find(".msgSpan");
		if (type == false) {

			textDivEle.css("display", "block");
			spanEle.removeClass("fui-check");
			spanEle.addClass("fui-cross");
			spanEle.removeClass("rightIcon");
			spanEle.addClass("wrongIcon");
			thisEle.closest(".groupRow").attr("completed", false);
		} else {

			textDivEle.css("display", "none");
			spanEle.removeClass("fui-cross")
			spanEle.addClass("fui-check");
			spanEle.removeClass("wrongIcon");
			spanEle.addClass("rightIcon");
			thisEle.closest(".groupRow").attr("completed", true);
		}

	}
	function checkPasswordEqual(thisEle) {
		if (thisEle.closest(".addContent").find(".addPasswordInput").val() == thisEle
				.val()) {
			changeDivRightOrWrong(thisEle, true);

		} else {
			changeDivRightOrWrong(thisEle, false);

		}

	}
	function positionRadioClick(thisEle) {

		//nowAddRadio放在这个属性上
		$(".positionRadio").removeClass("nowAddRadio");
		thisEle.removeClass("nowAddRadio");

	}
	function sumitPeople(){
		if(completeCheck() == false){
			
			swal("错误","请填写完全","warning");
			return ;
		}
		
		
		
		swal({
			  title: '提示',
			  text: "确定现在要添加吗",
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonText: '是的',
			  cancelButtonText: '我再想想吧',
			}).then(function () {
				
				$.ajax({
					url: "${pageContext.request.contextPath}/insertUser" ,  
			        type: 'POST',  
			        dataType:"JSON",
			        contentType:"application/json",
			        async: true,  
			        data: JSON.stringify(combineToUserJson()),
					success:function(data){
						if(data.result == true || data.result == "true"){
							swal("","添加成功","success");
							clearAddArea();
						}else {
							
							swal("错误","添加失败","error");
						}
							
						
					},
					error:function(){
						
						swal("错误","网络错误,添加失败","error");
					}
					
					
				})
				
			},function(){
				
				
				
				
			})
		
	}
	function completeCheck(){
		var completed=true;
		$(".inputGer").each(function(index,ele){
			ele=$(ele).closest(".groupRow");
			if(ele.attr("completed")==false || ele.attr("completed")=="false" ){
				completed=false;
				
				
			}
			
			
		});
		return completed;
		
	}
	function combineToUserJson(){
		user={};
		user.uid=$(".addUidInput").val();
		user.uname=$(".addNameInput").val();
		user.position=$(".nowAddRadio").attr("position");
		user.password=$(".addPasswordInput").val();
		return user;
		
	}
	function clearAddArea(){
		
		$(".inputGer").val("");
		
		
	}
</script>



</html>