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
				<div style="display: block" class="container sDiv subjectTotalDiv">
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
											<div class="picPainter" completed="false">
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

											<div class="mp3Getter" completed="false">
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
											<div class="wordGetter" completed="false">
												<div class="form-group  has-feedback inputGroup">
													<input type="text" value="" placeholder="单词"
														class="form-control wordInput" /> <span
														class="form-control-feedback fui-new"></span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="scoreGetter" completed="false">
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
									<div class="form-group">
										<label for="chooseInput${status.index+1}"
											class="col-sm-1 control-label" style="text-align: right;">${status.index+1}.</label>
										<div class="col-sm-8">
											<input type="text" class="form-control chooseInput"
												id="chooseInput${status.index+1}" placeholder="填写选择题的选项">
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
								class="subIconLink  " data-toggle="tooltip" href="#"> <span
								class="fui-check-circle iconSubject sureIcon"></span>
							</a>

						</div>


					</div>
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
					<h3>1秒到账，好玩停不下来</h3>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var paper = {
		subjects:[],
		date:"2017-10-10 10:10:00",
		title:"一张试卷",
		totalScore:100,
		subjectsNum:0,
	};
	var nowSubject = {
		type : 0,
		title : "",
		totalScore:10,
		elements : []

	};
	var element = {
		text : "",
		word : "",
		pic : "",
		score : ""
	};
	var MediaUtils = {
		    /**
		     * 获取用户媒体设备(处理兼容的问题)
		     * @param videoEnable {boolean} - 是否启用摄像头
		     * @param audioEnable {boolean} - 是否启用麦克风
		     * @param callback {Function} - 处理回调
		     */
		    getUserMedia: function (videoEnable, audioEnable, callback) {
		        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
		            || navigator.msGetUserMedia || window.getUserMedia;
		        var constraints = {video: videoEnable, audio: audioEnable};
		        if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
		            navigator.mediaDevices.getUserMedia(constraints).then(function (stream) {
		                callback(false, stream);
		            })['catch'](function(err) {
		                callback(err);
		            });
		        } else if (navigator.getUserMedia) {
		            navigator.getUserMedia(constraints, function (stream) {
		                callback(false, stream);
		            }, function (err) {
		                callback(err);
		            });
		        } else {
		            callback(new Error('Not support userMedia'));
		        }
		    },

		    /**
		     * 关闭媒体流
		     * @param stream {MediaStream} - 需要关闭的流
		     */
		    closeStream: function (stream) {
		        if (typeof stream.stop === 'function') {
		            stream.stop();
		        }
		        else {
		            let trackList = [stream.getAudioTracks(), stream.getVideoTracks()];

		            for (let i = 0; i < trackList.length; i++) {
		                let tracks = trackList[i];
		                if (tracks && tracks.length > 0) {
		                    for (let j = 0; j < tracks.length; j++) {
		                        let track = tracks[j];
		                        if (typeof track.stop === 'function') {
		                            track.stop();
		                        }
		                    }
		                }
		            }
		        }
		    }
		}; 
	// 用于存放 MediaRecorder 对象和音频Track，关闭录制和关闭媒体设备需要用到
	var recorder, mediaStream;

	// 用于存放录制后的音频文件对象和录制结束回调
	var recorderFile, stopRecordCallback;
	//录制回调
	// 用于存放是否开启了视频录制
	var videoEnabled = false;

	// 录制短语音
	function startRecord(enableVideo) {
	    videoEnabled = enableVideo;
	    MediaUtils.getUserMedia(enableVideo, true, function (err, stream) {
	        if (err) {
	            throw err;
	        } else {
	            // 通过 MediaRecorder 记录获取到的媒体流
	            recorder = new MediaRecorder(stream);
	            mediaStream = stream;
	            var chunks = [], startTime = 0;
	            recorder.ondataavailable = function(e) {
	                chunks.push(e.data);
	            };
	            recorder.onstop = function (e) {
	                recorderFile = new Blob(chunks, { 'type' : recorder.mimeType });
	                chunks = [];
	                if (null != stopRecordCallback) {
	                    stopRecordCallback();
	                }
	            };
	            recorder.start();
	        }
	    });
	}

	// 停止录制
	function stopRecord(callback) {
	    stopRecordCallback = callback;
	    // 终止录制器
	    recorder.stop();
	    // 关闭媒体流
	    MediaUtils.closeStream(mediaStream);
	}

	// 播放录制的音频
	function playRecord() {
	    var url = URL.createObjectURL(recorderFile);
	    var dom = document.createElement(videoEnabled ? 'video' : 'audio');
	    dom.autoplay = true;
	    dom.src = url;
	    if (videoEnabled) {
	        dom.width = 640;
	        dom.height = 480;
	        dom.style.zIndex = '9999999';
	        dom.style.position = 'fixed';
	        dom.style.left = '0';
	        dom.style.right = '0';
	        dom.style.top = '0';
	        dom.style.bottom = '0';
	        dom.style.margin = 'auto';
	        document.body.appendChild(dom);
	    }
	}
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
		$(".audioButton").click(function(){
			
			audioUploadClick($(this));
			
			
		});
		//音频开始录制点击事件
		
		$(".audioStartButton").click(function(){
			//开始录制声音
			startWordAudioRecord($(this));
		});
		//音频结束录制点击事件
		$(".audioStopButton").click(function(){
			//结束录制声音
			stopWordAudioRecord($(this));
		});
		//音频确认录制点击事件
		$(".audioSureButton").click(function(){
			//
			sureAudioRecord($(this));
		});
		//数字输入框输入事件
		$(".numberOnlyInput").keypress(function(evt){
			  var ev = evt.which?evt.which:window.event.keyCode;
			    if(ev>=48&&ev<=57 || ev==8){
			        return true;    
			    }else{
			        return false;
			    }
		}).focus(function() {
            this.style.imeMode='disabled';
        });;
		//数字/单词输入框光标离开
		$(".wordInput").blur(function(){
			wordInputCheck($(this));
			
		});
		$(".scoreInput").blur(function(){
			scoreInputCheck($(this));
				
			});
		//选择题选项
		$(".chooseInput").blur(function(){
			chooseInputCheck($(this));
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
	function subjectAddButtonClick() {
		//添加题目按钮被电击
		//1.所有sDiv都为none
		$(".sDiv").css("display", "none");
		//2 设置subjectContentDiv为block
		$(".subjectContentDiv").css("display", "block");
		//点一下
		$("#lineRadio").click();
		//设置一下lineRadio选中
		
		$("#lineRadio").prop("checked",true);
	}
	function subjectRadioClick(thisEle) {
		//题型单选框被点击
		//1.所有题型面板sContDiv隐藏
		$(".sContDiv").css("display", "none");
		//2.让这个radio对应的div显示出来
		$("." + thisEle.attr("id") + "-subjectDiv").css("display", "block");
		//3.让其他radio失去nowRadio属性
		$(".subjectRadio").removeClass("nowRadio");
		//4.让自己获得nowRadio属性
		thisEle.addClass("nowRadio");
	}
	function cancelButtonClick(thisEle) {
		//返回按钮触犯
		//1 从lastDiv获得上一个div 从levelDiv获得同级div
		$("." + thisEle.attr("levelDiv")).css("display", "none");
		$("." + thisEle.attr("lastDiv")).css("display", "block");

	}
	function picButtonClick(thisEle) {
		//1.打开文件上传框
		thisEle.closest(".row").find(".picInput").eq(0).click();

		//2.选择图片文件
		//3.在onchange函数里面，更改剪裁区图片	

	}
	function picFileChange(thisEle) {
		//1.更改cropper显示图片
		var oFReader = new FileReader();
		var file = thisEle.get(0).files[0];
		oFReader.readAsDataURL(file);
		oFReader.onloadend = function(oFRevent) {
			var src = oFRevent.target.result;
			thisEle.closest(".oneLineRadio").find(".linePic").eq(0).cropper(
					"replace", src);
			//2.更改complete属性为true 
			thisEle.closest(".oneLineRadio").find(".picPainter").attr(
					"completed", true);
			console.log("change!");
		}

	}
	function startWordAudioRecord(thisEle){
		//通过这个函数开始录制声音
		//1.清空原来的audio的div ,清空原来的播放器
		thisEle.closest(".modal-body").find(".audioRow").eq(0).empty();
		//2.开始录制
		startRecord(false);
		//4.设置completed false
		
		thisEle.closest(".mp3Getter").attr("completed",false);
		//3.开始按钮置false，结束按钮置true
		changeAudioButton(thisEle,true);
		
	}
	function changeAudioButton(thisEle,isPlay){
		thisEle.parent().find(".audioStartButton").eq(0).css("display",isPlay==true?"none":"block");
		thisEle.parent().find(".audioStopButton").eq(0).css("display",isPlay==true?"block":"none");
		
	}
	function stopWordAudioRecord(thisEle){
		//这里要做的事情
		//1.停止录制 	//2 添加一个播放器,src放置成刚刚录制的src
		stopRecord(function(){
			stopAudioCallBack(thisEle);
		});
	}
	function stopAudioCallBack(thisEle){
		
		//1.创建一个audio
		var audioEle=$("<video></video>");
		//2 设置属性
		
		var url = URL.createObjectURL(recorderFile);
		audioEle.attr("src",url);
		
		
		//3.在audioRow上放置
		thisEle.closest(".modal-body").find(".audioRow").eq(0).append(audioEle);
		audioEle.css("width","100%");
		audioEle.css("height","40px");
		audioEle.attr("autoplay","");
		audioEle.attr("controls","");
		//4.设置按钮
		changeAudioButton(thisEle,false);
		
	}
	function sureAudioRecord(thisEle){
		
		
		//1 判断audioDiv里面有没有audio,
		var length=thisEle.closest(".modal-body").find(".audioRow").eq(0).children().length;
		//如果有，completed置为true，没有弹出框警告
		if(length<1){
			swal("","你没有录音","warning");
			
		}else {
			
			thisEle.closest(".mp3Getter").attr("completed",true);
			thisEle.closest(".audioRecordModal").modal("hide");
		}
	}
	function audioUploadClick(thisEle){
		//点击了上传音频的按钮
		//1.打开模态框
		thisEle.parent().find(".audioRecordModal").eq(0).modal("show");
	}
	function wordInputCheck(thisEle){
		//检查是否长度小于1，如果不是，completed true
		if(thisEle.val().length>=1){
			thisEle.closest(".wordGetter").attr("completed",true);
			
		}else {
			thisEle.closest(".wordGetter").attr("completed",false);
		}
		
	}
	function chooseInputCheck(thisEle){
		//检查是否长度小于1，如果不是，completed true
		if(thisEle.val().length>=1){
			thisEle.attr("completed",true);
			
		}else {
			
			thisEle.attr("completed",false);
			
		}
		
	}
	function scoreInputCheck(thisEle){
		//检查是否为数字，如果是，complete true
		if(thisEle.val().length>=1 && isNaN(parseInt(thisEle.val()))==false){
			thisEle.closest(".scoreGetter").attr("completed",true);
			
		}
		else {
			
			thisEle.closest(".scoreGetter").attr("completed",false);
		}
		
	}
	function subjectSureButtonClick(thisEle){
		//1 将element组成一个subject
		var type=paresInt($(".nowRadio").eq(0).attr("subjectType"));
		if(combineElementsToSubject(type)){
			//2 将subject添加到当前试卷的subjectList里面去和面板里面
			addSubjectToPaperList();
			//3.清空出题区域
			cleanSubjectArea();
			//4.弹出提示，表示成功，点击确定返回上一个页面
			swal({ 
				  title: "提示", 
				  text: "出题成功!干的不错", 
				  type: "sucess",
				  showCancelButton: false, 
				  confirmButtonText: "确定", 
				  closeOnConfirm: false
				},
				function(){
				//返回上一个页面
					thisEle.closest(".subjectFootDiv").find(".cancelButton").eq(0).click();
				});
			
		}else{
			swal("","请填写完全 图片/音频/单词/分数 或者 每个选项的文本","warning");
			
		}
		
		
		
		
	}
	function combineElementsToSubject(type){
		// 0 连线 1 选择 2 填空
		//1.判断每个元素是否completed=true 如果不是return false
		if(checkCompletedByType(type)){
			return false;
		}
		//2.提取每个元素，组成一个元素列表
		
		//3.添加进nowSubject里面
		
	}
	function getElementsByType(type){
		//返回一个elements的数组
		
		
	}
	function checkCompletedByType(type){
		//根据type判断响应的区域是否已经完成
		if(type==0){
			//连线题，几个getter是否都是completed的状态
			
			
		}else if(type == 1){
			//选择题,几输入框是否是填写完全状态
			
		}else if(type==2){
			//填空题，没想好
			return false;
			
		}
		
	}
	function addSubjectToPaperList(){
		//。1.添加进paper的list里面
		// 2.添加在外面的面板上
		
	}
	function addSubjectTototalDivList(){
		//让刚刚添加的题在
		
	}
	function cleanSubjectArea(){
		//清理全部题型的div的残留，确保数据依然保存着
		
		
	}
	function cleanSpecSubjectArea(type){
		//清理一个特定的题型区域
		
		
	}
	
	
</script>



</html>