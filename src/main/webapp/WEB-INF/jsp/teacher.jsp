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
<link
	href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
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
<link href="${pageContext.request.contextPath}/css/queryCommon.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/cropper.js"></script>
<script src="${pageContext.request.contextPath}/js/audioPlugs.js"></script>
<script
	src="${pageContext.request.contextPath}/js/menclickAndsubject.js"></script>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
<script>
	BasePath="${pageContext.request.contextPath}";

	</script>
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
				class="jumbotron contentDiv queryDiv">
				<%@include file="./common/queryCommon.jsp"%>
			</div>
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

					<div style="display: none" class="row tipText"></div>


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
						<a title="提交" id="addUserButton" class="subIconLink"> <span
							class="fui-check-circle iconSubject"></span>
						</a>

					</div>
				</div>






			</div>
			<div style="display: block" class="jumbotron contentDiv tempDiv">
				<div class="" style="text-align: center">
					<h3>欢迎来带小可爱梁宇雁的在线课堂~</h3>
					<h3>^_^</h3>
					<h3></h3>
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
		//设置
	$(".addRadio").prop("checked",false);
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

	function sumitPeople() {
		if (completeCheck() == false) {

			swal("错误", "请填写完全", "warning");
			return;
		}

		swal({
			title : '提示',
			text : "确定现在要添加吗",
			type : 'warning',
			showCancelButton : true,
			confirmButtonText : '是的',
			cancelButtonText : '我再想想吧',
		}).then(function() {

			$.ajax({
				url : "${pageContext.request.contextPath}/insertUser",
				type : 'POST',
				dataType : "JSON",
				contentType : "application/json",
				async : true,
				data : JSON.stringify(combineToUserJson()),
				success : function(data) {
					if (data.result == true || data.result == "true") {
						swal("", "添加成功", "success");
						clearAddArea();
					} else {

						swal("错误", "添加失败", "error");
					}

				},
				error : function() {

					swal("错误", "网络错误,添加失败", "error");
				}

			})

		}, function() {

		})

	}

	function upLoadPaper(thisEle) {
		//先判断下是否合法
		if (checkPaperMsgCompleted() == -1) {
			//没有题目
			swal("干吗", "你看看有题吗？", "question");

		} else

		if (checkPaperMsgCompleted() == 0) {
			//没有标题
			swal("", "试卷标题呢", "question");
		} else {

			//1.给试卷打上时间,把标题放入数据结构里面
			paper.date = new Date().Format("yyyy-MM-dd hh:mm:ss");//时间
			paper.title = $(".paperTitleInput").val();
			var errorHappened = false;
			//4.点击上传，询问是否确定上传
			swal({
				title : '提示',
				text : "确定现在要发布这个试卷吗",
				type : 'warning',
				showCancelButton : true,
				confirmButtonText : '是的',
				cancelButtonText : '我再想想吧',
			})
					.then(
							function() {

								//先上传源信息
								$(".paperSubmitTextDiv").text("正在传输试卷源信息...");
								if (paper.pid == -1) {
									$
											.ajax({
												url : "${pageContext.request.contextPath}/paperUpload",
												type : 'POST',
												dataType : "JSON",
												contentType : "application/json",
												async : false,
												data : JSON
														.stringify(getPaperMsg()),
												success : function(data) {
													//上传成功了就成功了
													if (data.result == "true"
															|| data.result == true) {
														//取pid
														paper.pid = data.des;

														return;
													}
													swal({
														title : "错误",
														text : "试卷上传失败因为"
																+ data.des,
														type : "error"
													});
													errorHappened = true;
												},
												error : function(e) {
													swal({
														title : "错误",
														text : "试卷上传失败，网络错误",
														type : "error"

													});
													errorHappened = true;

												}

											})

								}
								if (errorHappened)
									return;
								//这里就开始显示一个带有进度条的，不可点击外侧关闭的进度框
								swal({
									title : '',
									showCloseButton : false,
									showCancelButton : false,
									showConfirmButton : false,
									allowOutsideClick : false,
									allowEscapeKey : false,
									allowEnterKey : false,
									html : "<div><div class='row pbl paperSubmitTextDiv'></div>"
											+ "<div  class='row pbl sliperDiv'></div></div>",
									onOpen : function() {
										//打开后要做的事情		
										//1.读取lastIndex
										//设置一个滑动条，总码数/初始位置
										var errorHappened = false;
										$(".sliperDiv").slider({
											min : 1,
											max : paper.subjects.length,
											value : 1,
											orientation : "horizontal",
											range : "min",
											slide : function(event, ui) {
												return false;

											}
										}).addSliderSegments(
												$(".sliperDiv")
														.slider("option").max);
										//3 for 循环，index小于lastIndex的时候，从lastIndex开始,每完成一个进度条前进，文字改变
										for (var i = 0; i < paper.subjects.length; i++) {
											//设置文本
											$(".paperSubmitTextDiv").text(
													"正在传输第 " + (i + 1) + " 道题");
											//设置滑动条
											$(".sliperDiv").slider("value",
													(i + 1));

											if (i < lastIndex)
												continue;//仅仅只是
											//不然就要上传
											//构建一个formdata的对象
											var dataForm = createSubjectFormdata(i);
											$
													.ajax({
														url : paper.subjects[i].sid == undefined
																|| paper.subjects[i].sid == null ? "${pageContext.request.contextPath}/subjectUpload"
																: "${pageContext.request.contextPath}/subjectUploadAlreadyExist",
														type : 'POST',
														data : dataForm,
														dataType : "JSON",
														async : false,
														cache : false,
														contentType : false,
														processData : false,
														success : function(data) {
															//上传成功了就成功了
															if (data.result == "true"
																	|| data.result == true)
																return;
															//失败了结束
															swal(
																	"错误",
																	"第"
																			+ i
																			+ "道题因为"
																			+ data.des
																			+ "上传失败，再次点击上传即可从断电处继续",
																	"error");

															//重新记一下
															lastIndex = i;
															errorHappened = true;

														},
														error : function(
																returndata) {
															swal(
																	"错误",
																	"第"
																			+ i
																			+ "道题上传失败，再次点击上传即可从断电处继续",
																	"error")
															//重新记一下
															lastIndex = i;
															//
															errorHappened = true;

														}
													});

											if (errorHappened)
												break;
										}

										//没完成一次循环，设置文本和进度条的位置
										//5 全部完成，重置lastIndex,显示上传成功，关闭对话框
										//情况paper区域
										if (errorHappened)
											return;
										cleanPaper();
										swal("", "发布试卷成功!", "success");

									}

								});

							}, function(dismiss) {

							});

		}

	}
	function cleanSubjectArea() {
		//清理全部题型的div的残留，确保数据依然保存着
		/*1.选择题清空
		  1.completed false
		  2.pic替换成temp
		  3.音频删除
		  4.填空框清空
		  
		 */
		$(".getter").attr("completed", false);
		$(".linePic").cropper("replace",
				"${pageContext.request.contextPath}/img/temp.png");
		$(".audioRow").empty();
		$(".wordInput").val("");
		$(".scoreInput").val("");
		/*
			选择题区域清空
		
		
		 */
		$(".chooseInput").val("");
		$(".chooseInput").attr("completed", false);
		$("#subjectName").val("");

		//数据结构清

		nowSubject = {
			type : -1,
			title : "",
			totalScore : 0,
			elements : [],
			index : 0
		};
	}
</script>
<script src="${pageContext.request.contextPath}/js/queryCommon.js"></script>


</html>