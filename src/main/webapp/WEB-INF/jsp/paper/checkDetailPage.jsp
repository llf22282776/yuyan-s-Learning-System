<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>试卷详情界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/jcanvas.js"></script>

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
<link href="${pageContext.request.contextPath}/css/paper.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/verticalMenu.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/cropper.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/checkDetail.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/cropper.js"></script>
<script src="${pageContext.request.contextPath}/js/commonPaper.js"></script>
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
</head>
<body>
	<div class="rootContainer">
		<%@include file="../common/header.jsp"%>
		<div class="">

			<div style="display: block" class="jumbotron contentDiv ">
				<%@include file="../common/checkDetailPaperDiv.jsp"%>
				<%@include file="../common/checkDetailSubjectDiv.jsp"%>
			</div>
	
			
		
			<div style="display: none" class="jumbotron contentDiv subjectDiv">

			</div>
			

		</div>



		<div class="viewable chooseSubjectContent">
			<c:forEach begin="0" end="3" varStatus="status">
				<div class="row">
					<div class="form-group subjectChooseGroup">
						<label class="radio radio-inline"
							for="paperChooseInputRadio${status.index+1}"> <input
							name="chooseRadio" type="radio" data-toggle="radio" value=""
							id="paperChooseInputRadio${status.index+1}"
							class="paperChooseRadio" index="${status.index}" required /> <strong></strong>
						</label>

					</div>
				</div>
			</c:forEach>
		</div>
		<div class="viewable lineSubjectContent">
			<div class="specRow textRow">
				<c:forEach begin="0" end="3" varStatus="status">
					<!-- 这里是特殊的文字 -->
					<div class="wordSubjectDiv">站位</div>
				</c:forEach>

			</div>
			<div class="specRow painterRow">
				<canvas id="linePainter" class="linePainter"
					style="width:901px;height:220px"></canvas>

			</div>
			<div class="specRow picRow">
				<c:forEach begin="0" end="3" varStatus="status">
					<!-- 这里是特殊的文字 -->
					<img class="picSubjectDiv"
						src="${pageContext.request.contextPath}/img/temp.png" alt="" />
				</c:forEach>

			</div>
		</div>

	</div>
	<video class='subjectAudioView'></video>
	<video class='subjectAudioView'></video>
	<video class='subjectAudioView'></video>
	<video class='subjectAudioView'></video>
</body>
 <script src="${pageContext.request.contextPath}/assets/js/application.js"></script>
<script>
	var testPaper = {
		isStarted : false,//判断是否开始 
		paper : {},
		startTime : "",//答卷开始时间
		endTime : "",//答卷结束时间
		subjectsLength : 0, //试卷总长度
		nowSubjectIndex : 0,//现在是第几题
		paperType : 0,//-1 答题形式 0查看形式  （答完题后可以查看）
		nowUserIndex : 0,//从o开始

	};
	$(document)
			.ready(
					function() {
						
						$.ajax({
								url : '${pageContext.request.contextPath}/getDonePaperJson',
								type : 'POST',
								data:{
									pid:${pid},
								},
								dataType : "JSON",
								async : false,
								success:function(data){
								testPaper = {
										isStarted : false,//判断是否开始 
										paper : data,
										startTime : "",//答卷开始时间
										endTime : "",//答卷结束时间
										subjectsLength : 0, //试卷总长度
										nowSubjectIndex : 0,//现在是第几题
										paperType : 0,//-1 答题形式 0查看形式  （答完题后可以查看）
										nowUserIndex : 0,//从o开始

									};
								initCheck();
								},
								error:function(){
									swal("", "拉取试卷失败，请联系管理员", "error")
									.then(
											function() {
												location.href = '${pageContext.request.contextPath}/main';

											})
									
									
								}
							
						})
						
						
						
						
					

					});

	var subjectStamp = {
		startTime : "",
		endTime : "",

	};

	function initCheck(){
		
		$('.userSelecter').change(function(e) {
			selectChangeEvent($(this),e);

		});
		//组织题目
		if (testPaper.paper.result == false
				|| testPaper.paper.result == "false") {
			swal("", "拉取试卷失败，请联系管理员", "error")
					.then(
							function() {
								location.href = '${pageContext.request.contextPath}/main';

							})
		} else {

			initPaper(".subjectDiv", 0, testPaper.paper);

		}
		
		
	}
	
	function selectChangeEvent(thisEle,e) {
		//下拉框切换事件
		//切换用户
		switchUser(parseInt(e.val));

	}
	function switchUser(index) {
		//切换用户，
		testPaper.nowUserIndex = index;
		//更改testPaper.subjects,nowsubjectInde nowUserIndex
		testPaper.paper.subjects = testPaper.paper.users[testPaper.nowUserIndex].subjects;
		//更改试卷头信息
		changePaperDataDiv();
		if (testPaper.nowSubjectIndex > -1)
			testPaper.nowSubjectIndex -= 1;//减小
		else
			testPaper.nowSubjectIndex = -1;//小于等于-1就别动了
		//切换到下一个题(表面上依然是这一题)
		switchSubjectToNext();

	}

	function changePaperDataDiv() {
		//更改用户数据，切换数据的时候被调用
		//清空paperTotalDate
		cleanPaperDataDiv();
		//重新渲染数据,各种div
		paintPaperDataDiv();
		//重新绘制表格,各种
		paintPaperViewCharts();
	}
	function cleanPaperDataDiv() {
		//更改用户数据，切换数据的时候被调用
		//姓名不用变化，
		//分数和时间清空//排行榜清空
		$('.paperUserTotalView').find('.textArea').empty();
		//表格什么的重新加载一下就行，不用清空

	}
	function paintPaperDataDiv() {
		//绘制试卷面板数据

		var userMix = testPaper.paper.users[testPaper.nowUserIndex];
		//分数
		$('.paperUserTotalView').find(".nameArea").find('.scoreRow').find(
				'.textArea').text(userMix.totalScore);
		//时间
		$('.paperUserTotalView').find(".nameArea").find('.timeRow').find(
				'.col-xs-8').text(userMix.totalSecond);
		//排行
		$('.paperUserTotalView').find(".rankArea").find('.scoreRow').find(
				'.textArea').text(userMix.scoreRank);
		//时间
		$('.paperUserTotalView').find(".rankArea").find('.timeRow').find(
				'.textArea').text(userMix.timeRank);

	}
	function paintSubjectDataDiv() {
		//绘制题目面板数据
		//清空数据div
		var subjectMix = testPaper.paper.subjects[testPaper.nowSubjectIndex];
		//分数
	$('.subjectUserView').find('.headerRow').find(
	'.textArea').text(testPaper.nowSubjectIndex+1);

		$('.subjectUserView').find('.scoreRow').find(
				'.textArea').text(subjectMix.score);
		//时间
		$('.subjectUserView').find('.timeRow').find(
				'.timeText').text(subjectMix.totalSecond);
	}
	function changeSubjectDiv() {
		//switchSubject的时候触发,在修改完index之后，就是clean之后
		//重新绘制面板
		cleanSubjectDataDiv();
		paintSubjectDataDiv();
		//重新绘制表格
		paintSubjectCharts();
	}
	function cleanSubjectDataDiv() {
		$('.subjectUserView').find('.textArea').empty();

	}
	function initCharts() {
		//初始化各种表
		/*skillRaderCharts
		paperScoreCharts
		paperTimeCharts
		subjectScoreCharts
		subjetTimeCharts*/
		//skillChart = echarts.init(($('#skillRaderCharts'))[0]);
		paperScoreChart = echarts.init(($('#paperScoreCharts'))[0]);
		subjectScoreChart = echarts.init(($('#subjectScoreCharts'))[0]);
		
	}
	function paintPaperViewCharts() {
		//能力表，两个时间表,pie，一个skill表
		var opt = creatOptionByType('skill');
		<%--skillChart.setOption(opt, {--%>
			<%--notMerge : true,--%>
		<%--});--%>
		opt = creatOptionByType('paperScore');
		paperScoreChart.setOption(opt, {
			notMerge : true,
		});
		<%--opt = creatOptionByType('paperTime');--%>
		<%--paperTimeChart.setOption(opt, {--%>
			<%--notMerge : true,--%>
		<%--});--%>

	}

	function creatOptionByType(type) {
		var opt = {
			title : {
				text : ''
			},
			legend : {
				data : [ '' ]
			},

		}
		if (type == 'skill') {
			paperChartIndex=0;
			opt = {
				title : {
					text : '学生能力'
				},
				legend : {
					data : [ '']
				//用户的姓名
				},
				radar : [ {
					indicator : [ {
						text : '时间',
						max : testPaper.paper.paperMetaData.maxTime,

					},//最大的时间应该是
					{
						text : '分数',
						max : testPaper.paper.paperMetaData.maxScore,

					},

					],
					center : [ '75%', '50%' ],
					radius : 120
				} ],
				series : [ {
					name : '',
					type : 'radar',
					data : [ {
						value : [
								testPaper.paper.users[testPaper.nowUserIndex].totalSecond_num,
								testPaper.paper.users[testPaper.nowUserIndex].totalScore ],//这个人的情况时间和分数
						value_string : [
								testPaper.paper.users[testPaper.nowUserIndex].totalSecond,
								testPaper.paper.users[testPaper.nowUserIndex].totalScore
										+ "分" ],//显示用的字符串
						label : {
							normal : {
								show : true,
								formatter : function(params) {

										return params.value;
									}
							    }
							}
					} ]
				} ]
			}

			return opt;
		} else if (type == 'paperScore') {
			//饼图需要技巧，设置分数百分比
			var scoresDist = getRangeScoreOrTimes(testPaper.paper.paperMetaData.scores);
			var scoresText = [];
			var dataList = [];
			for ( var i in scoresDist) {
				scoresText.push(i + "分");
				var dataEle = {
					value : scoresDist[i].nums,
					name : i + "分",
				}
				dataList.push(dataEle);//把它的数量也取出来
			}
			opt = {
				title : {
					text : '分数分布'
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : scoresText,
					show:false
				//三个分数段的图例

				},

				series : [ {
					name : '访问来源',
					type : 'pie',

					radius : [ '50%', '70%' ],
					avoidLabelOverlap : false,
					label : {
						normal : {
							show : false,
							position : 'center'
						},
						emphasis : {
							show : true,
							textStyle : {
								fontSize : '20',
								fontWeight : 'bold'
							}
						}
					},
					labelLine : {
						normal : {
							show : false,

						}
					},
					data : dataList,
				} ]
			}

			return opt;
		} else if (type == 'paperTime') {
			return opt;

		} else if (type == 'subjectScore') {
			var scoresDist = getRangeScoreOrTimes(testPaper.paper.paperMetaData.subjectMetaDatas[testPaper.nowSubjectIndex].scores);
			var scoresText = [];
			var dataList = [];
		for ( var i in scoresDist) {
			scoresText.push(i + "分");
			var dataEle = {
			value : scoresDist[i].nums,
			name : i + "分",
			}
			dataList.push(dataEle);//把它的数量也取出来
		}
			opt = {
				title : {
					text : '分数分布'
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : scoresText,
					show:false
				//三个分数段的图例

				},

				series : [ {
					name : '访问来源',
					type : 'pie',

					radius : [ '50%', '70%' ],
					avoidLabelOverlap : false,
					label : {
						normal : {
							show : false,
							position : 'center'
						},
						emphasis : {
							show : true,
							textStyle : {
								fontSize : '20',
								fontWeight : 'bold'
							}
						}
					},
					labelLine : {
						normal : {
							show : false,

						}
					},
					data : dataList,
				} ]
			}

			return opt;
		} else if (type == 'subjectTime') {

			return opt;

		}

	}
	function toFormatTime(ms){
		var  ss = 1000;
		var mi = ss * 60;
		var hh = mi * 60;
		var dd = hh * 24;

		var day = ms / dd;
		var hour = (ms - day * dd) / hh;
		var minute = (ms - day * dd - hour * hh) / mi;
		var second = (ms - day * dd - hour * hh - minute * mi) / ss;
		var str="";
		if(day>0)str+=day+"天";
		if(hour>0)str+=hour+"小时";
		if(minute>0)str+=minute+"分";
		if(second>0)str+=second+"秒";
		return str;
	}
	function getRangeScoreOrTimes(scores) {
		//获取3分数阶段,
		var scoreDist = [];
		for (var i = 0; i < scores.length; i++) {
			//放进字典,字典的key是分数，value是数量
			if (scoreDist[scores[i]] == undefined
					|| scoreDist[scores[i]] == null) {
				//没有这个键
				scoreDist[scores[i]] = {
					nums : 1,//刚刚加入进来
				}

			} else {
				scoreDist[scores[i]].nums += 1;//增长1

			}

		}
		return scoreDist;

	}

	function paintSubjectCharts() {
		//画那两个pie
		opt = creatOptionByType('subjectScore');
		subjectScoreChart.setOption(opt, {
			notMerge : true,
		});

	}
	function preSubjectClickEvent() {
		//切换
		//第一题没饭应
		if (testPaper.nowSubjectIndex <= 0)
			return;
		else
			testPaper.nowSubjectIndex -= 2;//减小两个，因为switch的时候会增加
		//要让下一题的按钮依然有效
		var buttonEle = $(testPaper.className).find(".subjectRooter").find(
				"#papertestSubmitButton");
		buttonEle.click(function() {
			nextButtonClick($(this));

		});

		//调用switch就行
		switchSubjectToNext();

	}
	function initPaper(className, type, paper) {
		//创建全局变量(如果没有的话)
		testPaper = {
			isStarted : false,//判断是否开始
			paper : paper,//试卷保存在这个对象里面
			startTime : "",//答卷开始时间
			endTime : "",//答卷结束时间
			subjectsLength : paper.length, //试卷总长度
			nowSubjectIndex : -1,//现在是第几题
			paperType : type,//-1 答题形式 0查看形式  （答完题后可以查看）
			className : className,
			nowUserIndex : 0,//从o开始
		};
		subjectStamp = {
			startTime : "",
			endTime : "",
			wordSelectList : [ false, false, false, false ],//文字选取情况，这个值会在鼠标抬起的时候读，用于渲染形状
			selectList : [ 0, 1, 2, 3 ],//选择的情况，索引和值为一对
			choosenIndex : -1,//选择题的选项
			textList : [ "", "", "", "" ],//填空题的列表
			selectPairNum : -1,//连线时，单击上册图层选择的pairNum

		};
		lineSubjectEle = $('<div class="lineSubjectContent"><canvas id="linePainter" class="linePainter"></canvas></div>');
		chooseSubjectEle = $('<div class="chooseSubjectContent"><c:forEach begin="0" end="3" varStatus="status"><div class="row"><div class="form-group subjectChooseGroup"><label class="radio radio-inline col-sm-1" for="paperChooseInputRadio${status.index+1}"> <input name="chooseRadio" type="radio" data-toggle="radio" value="" id="paperChooseInputRadio${status.index+1}" class="paperChooseRadio" index="${status.index}" required /> </label> <div class="col-sm-8"> <h4></h4> </div> </div> </div> </c:forEach></div>');
		//创建一下
		createElement(className);
			$(className).css("display","block");
		//初始化表
		initCharts();
		//切换到第一个用户
		switchUser(testPaper.nowUserIndex);

	}

	function createElement(className) {
		//清空这个类下的内容，然后创建
		$(className).empty();
		var contentEle = $('<div class="row subjectHeader"><div class="col-xs-1"></div><div class="col-xs-10"></div></div><div class="row subjectContent"></div><div class="row subjectRooter"><div class="scoreDiv"></div><div class="row stepState" id="stepState"></div><div class="row nextButtonDiv"><div class="col-xs-6"><a id="preSubjectButton" class=""><span class="iconSubject fui-arrow-left"aria-hidden="true"></span></a></div><div class="col-xs-6"><a id="papertestSubmitButton" class=""><span class="iconSubject fui-arrow-right"aria-hidden="true"></span> </a></div></div></div>');

		$(className).append(contentEle);//添加进来
		//给按钮添加事件
	}
	function switchSubjectToNext() {
		//切换subject到下一题，第一次的时候，下一题是0编号
		if (checkSubjectComplete() == false) {
			swal("提示", "请完成这道题目", "info");
		} else {
			//做完了，
			//1.保存这道题的做题结果，开始/结束时间 时间，
			saveSubject();
			//2.清除答题区域,index增加
			cleanSubjectArea();
			//3.修改数据面板
			changeSubjectDiv();
			//3.绘制答题区域
			paintSubject();
			//4.更改进度条
			changeSlider();
			//6.更改提交按钮和指向的请求
			changeSubmitButtonAndIcon();
			//7.设置当前记录变量
			initStateVar();

		}

	}

	function checkSubjectComplete() {
		//检查是否完成
		if (testPaper.paperType == 0 || testPaper.nowSubjectIndex == -1) {
			//查询模式或者刚开始不用检查
			return true;//不用检查

		} else {
			//需要检查
			var subjectType = testPaper.paper.subjects[testPaper.nowSubjectIndex].type;
			if (subjectType == 0) {
				//连线题
				var isComplete = true;
				for (var i = 0; i < subjectStamp.length; i++) {
					if (subjectStamp.allSelect[i] == false) {
						isComplete = false;
						break;
					}

				}
				return isComplete;

			} else if (subjectType == 1) {
				//选择题
				return subjectStamp.choosenIndex != -1;
			} else {
				//填空题
				return false;
			}

		}
	}
	function saveSubject() {
		//保存subject  
		subjectStamp.endTime = new Date().Format("yyyy-MM-dd hh:mm:ss");
		if (testPaper.paperType == -1) {
			//答题模式,保存,就是放到原来的paper里面去
			if (testPaper.nowSubjectIndex != -1) {
				var thisSubject = testPaper.paper.subjects[testPaper.nowSubjectIndex];//这个题的对象抽出来 
				thisSubject.selectList = subjectStamp.selectList;
				thisSubject.choosenIndex = subjectStamp.choosenIndex;
				thisSubject.textList = subjectStamp.textList; //根据type，其中一个会有用
				thisSubject.startTime = subjectStamp.startTime;
				thisSubject.endTime = subjectStamp.endTime;

			}
			//这里还要记个分

		}

	}
	function cleanSubjectArea() {
		//清理答题区域
		//1.清空
		let
		className = testPaper.className;
		//$(className).find(".subjectContent").empty();
		//更改题目编号为下一个
		testPaper.nowSubjectIndex += 1;
		//设置

		//更新最初的题目状态量
		subjectStamp = {
			startTime : "",
			endTime : "",
			wordSelectList : [ false, false, false, false ],//文字选取情况，这个值会在鼠标抬起的时候读，用于渲染形状
			selectList : [ -1, -1, -1, -1 ],//选择的情况，索引和值为一对
			choosenIndex : -1,//选择题的选项
			textList : [ "", "", "", "" ],//填空题的列表
			selectPairNum : -1,//连线时，单击上册图层选择的pairNum,
			x : -1,
			y : -1,
			lines : [],
			lines_r : [],//饭向数组
		};
	}
	function paintSubject() {
		//绘制答题区域
		//1取下一题，判断类型，进行渲染
		var nextSubject = testPaper.paper.subjects[testPaper.nowSubjectIndex];
		var className = testPaper.className;
		//设置标题
		$(className).find(".subjectHeader").find(".col-xs-10").text(
				nextSubject.title);
		$(className).find(".subjectHeader").find(".col-xs-1").text(
				(testPaper.nowSubjectIndex + 1) + ".");

		if (nextSubject.type == 0) {
			//吧连线题元素添加到里面去
			lineSubjectEle = creatLinesEleAndAppend($(className).find(
					".subjectContent"));

			//连线题

			paintCanvas(lineSubjectEle, testPaper.paperType, nextSubject);

		} else if (nextSubject.type == 1) {
			//选择题
			chooseSubjectEle = creatChoosenEleAndAppend($(className).find(
					".subjectContent"));
			paintChoose($(className).find(".subjectContent").find(
					".chooseSubjectContent"), testPaper.paperType, nextSubject);

		}

	}
	function paintCanvas(canvasEle, paperType, subject) {
		//在这个元素里面绘制图片啥的

		if (paperType == -1) {
			//绘制 图片 单词 添加点击事件 添加到相应的组里面去
			drawThePicsAndWords(canvasEle, subject);

		} else if (paperType == 0) {
			//只是用户和答案都画上去 ，没有反应事件
			drawThePicsAndWords_static(canvasEle, subject);
		}

	}
	function reinitLineSubjectDiv(canvasEle) {
		//1.文字全部去掉
		canvasEle.find(".wordSubjectDiv").text("");
		//2.情况cavase
		canvasEle.find("#linePainter").clearCanvas();
		//3 设置图片为原始的
		canvasEle.find(".picSubjectDiv").attr("src",
				"${pageContext.request.contextPath}/img/temp.png")
	}
	function drawThePicsAndWords(canvasEle, subject) {
		//假设传入的是连线题的顶级元素
		//0 设置音频，没有问题
		setAudio(subject);
		//1.清除画板(进来的时候就已经清空了)
		//绘制文字
		canvasEle.find(".wordSubjectDiv").each(function(index, ele) {
			var ele = $(ele);
			ele.text(subject.words[index]);
			ele.attr("pairNum", index);
			ele.attr("pairTo", -1);
		});
		//2 绘制图片
		canvasEle.find(".picSubjectDiv").each(function(index, ele) {
			var ele = $(ele);
			ele.attr("src", subject.pics[subject.indexList[index]]);//顺序为0的编号是多少
			ele.attr("pairNum", subject.indexList[index]);
			ele.attr("pairFrom", -1);
		});

		//3 去掉事件，
		canvasEle.find(".wordSubjectDiv").unbind('click');
		canvasEle.find(".picSubjectDiv").unbind('click');
		//3.添加点击事件
		canvasEle.find(".wordSubjectDiv").click(function() {
			textAreClick($(this));
		});
		canvasEle.find(".picSubjectDiv").click(function() {
			picAreaClick($(this));
		});

	}
	function textAreClick(thisEle) {
		//点击事件
		//1.全部设置为普通
		thisEle.closest(".lineSubjectContent").find(".wordSubjectDiv").css(
				"color", "#34495e");
		thisEle.closest(".lineSubjectContent").find(".wordSubjectDiv").css(
				"fontSize", "25px");
		//2.加上动画类
		thisEle.animate({
			color : "#2ecc71",
			fontSize : "30px",
		});
		//3.修改selectPairNum
		subjectStamp.selectPairNum = parseInt(thisEle.attr("pairNum"));
	}
	function picAreaClick(thisEle) {
		//1.播放
		$(".subjectAudioView[index='" + thisEle.attr("pairNum") + "']")
				.trigger('play');
		if (subjectStamp.selectPairNum != -1) {
			//要画图了
			//如果起点为sN,终点为该piarnum存在，需要删除掉
			var line1 = isInlLinesList(subjectStamp.selectPairNum + "");
			var line2 = isInLines_Rlist(thisEle.attr("pairNum"));
			var list = [ line1, line2 ];
			deleteLine(list);
			drawAline(thisEle, subjectStamp.selectPairNum, parseInt(thisEle
					.attr("pairNum")),
					testPaper.paper.subjects[testPaper.nowSubjectIndex]);

			reinitStamp(thisEle);//重新设置下，selectPairNum,字体颜色,设置wordsSelectList
		}
	}
	function reinitStamp(thisEle) {
		//文字重新设置
		thisEle.closest(".lineSubjectContent").find(".wordSubjectDiv").css(
				"color", "#34495e");
		thisEle.closest(".lineSubjectContent").find(".wordSubjectDiv").css(
				"fontSize", "25px");
		//
		subjectStamp.wordSelectList[subjectStamp.selectPairNum] = true;
		subjectStamp.selectList[subjectStamp.selectPairNum] = parseInt(thisEle
				.attr("pairNum"));
		subjectStamp.selectPairNum = -1;//选了

	}
	function isInlLinesList(key) {
		//返回一个null 或者一个对象{start:,end:,}
		if (subjectStamp.lines[key] == undefined
				|| subjectStamp.lines[key] == null)
			return null;
		else
			return subjectStamp.lines[key];

	}
	function isInLines_Rlist(key) {
		if (subjectStamp.lines_r[key] == undefined
				|| subjectStamp.lines_r[key] == null)
			return null;
		else
			return subjectStamp.lines_r[key];
	}
	function drawAline(thisEle, start, end, subject) {
		//把start和end添加进字典里面，清空，遍历字典划线
		var line = {
			start : start,
			end : end,
			index : subject.indexList.indexOf(end),
			type : 0,
		};
		subjectStamp.lines[start + ""] = line;
		line = {
			start : start,
			end : end,
			index : subject.indexList.indexOf(end),
			type : 1,
		};
		subjectStamp.lines_r[end + ""] = line;
		console.log(subjectStamp);
		var cavnsEle = thisEle.closest(".lineSubjectContent").find(
				"#linePainter");

		cavnsEle.clearCanvas();
		console.log("------");
		for ( var i in subjectStamp.lines) {
			var lineEle = subjectStamp.lines[i];

			console.log("i:" + i + " " + (110 + 210 * (lineEle.start)) / 3
					+ " " + (110 + 210 * (lineEle.index)) / 3);
			var disTance = (110 + 210 * (lineEle.index)) / 3
					- (110 + 210 * (lineEle.start)) / 3;
			cavnsEle.drawLine({
				strokeStyle : '#000',
				strokeWidth : 1,
				x1 : (110 + 210 * (lineEle.start)) / 3,
				y1 : 0,
				x2 : (110 + 210 * (lineEle.index)) / 3 + disTance / 3,
				y2 : 220,

			});
		}

	}
	function drawlines(thisEle, list, subject) {
		//清空，遍历List划线
		var cavnsEle = thisEle.find("#linePainter");
		cavnsEle.clearCanvas();
		for ( var i=0;i<list.length; i++) {
			var lineEle = list[i];
			var line_right = {
				start : i,
				end : i,
				index : subject.indexList.indexOf(i),//正确选择的顺序

			};
			if (lineEle.end == line_right.end) {//用户选择一致
				//画一条黑线
				var disTance = (110 + 210 * (lineEle.index)) / 3
						- (110 + 210 * (lineEle.start)) / 3;
				cavnsEle.drawLine({
					strokeStyle : '#000',
					strokeWidth : 1,
					x1 : (110 + 210 * (lineEle.start)) / 3,
					y1 : 0,
					x2 : (110 + 210 * (lineEle.index)) / 3 + disTance / 3,
					y2 : 220,

				});
			} else {
				//不一致，画两条线，一绿一红
				//画一条灰色是用户选的 红色 错的
				var disTance = (110 + 210 * (lineEle.index)) / 3
						- (110 + 210 * (lineEle.start)) / 3;
				cavnsEle.drawLine({
					strokeStyle : '#e74c3c',
					strokeWidth : 1,
					x1 : (110 + 210 * (lineEle.start)) / 3,
					y1 : 0,
					x2 : (110 + 210 * (lineEle.index)) / 3 + disTance / 3,
					y2 : 220,

				});
				disTance = (110 + 210 * (line_right.index)) / 3
						- (110 + 210 * (line_right.start)) / 3;
				cavnsEle.drawLine({
					strokeStyle : '#2ecc71',
					strokeWidth : 1,
					x1 : (110 + 210 * (line_right.start)) / 3,
					y1 : 0,
					x2 : (110 + 210 * (line_right.index)) / 3 + disTance / 3,//正确的线
					y2 : 220,

				});

			}

		}

	}
	function deleteLine(list) {
		for (var i = 0; i < list.length; i++) {
			var listEle = list[i];
			if (listEle == null)
				continue;
			delete subjectStamp.lines[listEle.start + ""];
			delete subjectStamp.lines_r[listEle.end + ""];
			subjectStamp.wordSelectList[listEle.start] = false;
		}

	}
	function drawThePicsAndWords_static(canvasEle, subject) {
		//人都做完了，绘制玩基本的，就要绘制线条,正确答案
		//0 设置音频，没有问题
		setAudio(subject);
		//1.清除画板(进来的时候就已经清空了)
		//绘制文字
		canvasEle.find(".wordSubjectDiv").each(function(index, ele) {
			var ele = $(ele);
			ele.text(subject.words[index]);
			ele.attr("pairNum",index);
			ele.attr("pairTo", -1);
		});
		//2 绘制图片
		canvasEle.find(".picSubjectDiv").each(function(index, ele) {
			var ele = $(ele);
			ele.attr("src", subject.pics[subject.indexList[index]]);//顺序为0的编号是多少
			ele.attr("pairNum", subject.indexList[index]);
			ele.attr("pairFrom", -1);
		});

		//3 去掉事件，
		canvasEle.find(".wordSubjectDiv").unbind('click');
		canvasEle.find(".picSubjectDiv").unbind('click');
		//4.划线
		drawlines(canvasEle, combineLines(subject), subject);
	}
	function combineLines(subject) {
		//组件lines,start,end
		var lines_user = [];
		for (var i = 0; i < subject.indexList.length; i++) {
			//遍历
			var line = {
				start : i,
				end : subject.selectList[i],//选的
				index : subject.indexList.indexOf(subject.selectList[i]), //选的这个编号的顺序是几
			};
			lines_user.push(line);
		}
		return lines_user;
	}
	function paintChoose(radiosEle, paperType, subject) {
		//在这个元素里面绘制选择题，添加radio啥的
		if (paperType == -1) {
			//用户做，只画基本的，还要添加反应事件,bind前先unbind
			baseChooseSetting(radiosEle, subject);
			addEvent(radiosEle, paperType);//添加

		} else if (paperType == 0) {
			//用户和答案都画上去 
			bothChooseSettion(radiosEle, subject)
		} else {
			//只画答案

		}

	}
	function baseChooseSetting(radiosEle, subject) {
		//1.设置所有为false
		radiosEle.find(".paperChooseRadio").prop("checked", false);
		radiosEle.find(".paperChooseRadio").removeAttr("disabled");
		radiosEle.find(".paperChooseRadio").closest(".row").find("strong").css(
				"color", "inherit");
		//2.设置文本

		radiosEle.find(".paperChooseRadio").each(function(index, ele) {
			ele = $(ele).closest(".row");
			ele.find("strong").text(subject.texts[index]);

		})
		//3.去掉所有的nowChoosen 类,name设置一致
		radiosEle.find(".paperChooseRadio").removeClass("nowChoosen");
		radiosEle.find(".paperChooseRadio").attr("name", "chooseRadio");
		//4.设置事件
		radiosEle.find(".paperChooseRadio").unbind("click");

	}
	function bothChooseSettion(radiosEle, subject) {
		//都设置上去
		//1.设置所有为false
		radiosEle.find(".paperChooseRadio").prop("checked", false);
		radiosEle.find(".paperChooseRadio").removeAttr("disabled");
		radiosEle.find(".paperChooseRadio").closest(".row").find("strong").css(
				"color", "inherit");

		//2.设置文本

		radiosEle.find(".paperChooseRadio").each(function(index, ele) {
			ele = $(ele).closest(".row");
			ele.find("strong").text(subject.texts[index]);

		});
		//先去掉

		if (subject.choosenIndex != subject.answerIndex) {
			//设置正确的那个为选中状态，颜色为默认值
			radiosEle.find(
					".paperChooseRadio[index='" + subject.answerIndex + "']")
					.attr("name", "chooseRadio_answer");
			radiosEle.find(
					".paperChooseRadio[index='" + subject.answerIndex + "']")
					.prop("checked", true);
			//
			radiosEle.find(
					".paperChooseRadio[index='" + subject.answerIndex + "']")
					.closest(".row").find("strong").css("color", "#2ecc71");
			//设置用户选的那个为选中，颜色
			radiosEle.find(
					".paperChooseRadio[index='" + subject.choosenIndex + "']")
					.attr("name", "chooseRadio");
			radiosEle.find(
					".paperChooseRadio[index='" + subject.choosenIndex + "']")
					.prop("checked", true);
			radiosEle.find(
					".paperChooseRadio[index='" + subject.choosenIndex + "']")
					.closest(".row").find("strong").css("color", "#e74c3c");
		} else {
			//文本颜色为绿色
			radiosEle.find(
					".paperChooseRadio[index='" + subject.choosenIndex + "']")
					.attr("name", "chooseRadio");
			radiosEle.find(
					".paperChooseRadio[index='" + subject.choosenIndex + "']")
					.prop("checked", true);
			radiosEle.find(
					".paperChooseRadio[index='" + subject.answerIndex + "']")
					.closest(".row").find("strong").css("color", "#2ecc71");

		}
		//所有都不可选取
		radiosEle.find(".paperChooseRadio").attr("disabled", true);
		//3.去掉所有的nowChoosen 类,name设置一致
		radiosEle.find(".paperChooseRadio").removeClass("nowChoosen");
		//去掉所有事件,不再添加
		radiosEle.find(".paperChooseRadio").unbind("click");

	}
	function addEvent(radiosEle) {
		//添加选中事件
		radiosEle.find(".paperChooseRadio").bind("click", function() {
			paperChooseRadioClick($(this));

		});

	}

	function creatLinesEleAndAppend(rootEle) {

		//切换节点的位置，更改可见属性
		$(".viewable").css("display", "none");
		var ele = $(".viewable.chooseSubjectContent");
		reinitLineSubjectDiv($(".viewable.lineSubjectContent"));//清空一下下
		rootEle.append($(".viewable.lineSubjectContent"));
		$('body').append(ele);
		$(".viewable.lineSubjectContent").css("display", "block");
		return $(".viewable.lineSubjectContent");
	}
	function creatChoosenEleAndAppend(rootEle) {

		$(".viewable").css("display", "none");
		var ele = $(".viewable.lineSubjectContent");
		rootEle.append($(".viewable.chooseSubjectContent"));
		$('body').append(ele);
		$(".viewable.chooseSubjectContent").css("display", "block");
		return $(".viewable.chooseSubjectContent");
	}
	function paperChooseRadioClick(radioEle) {

		radioEle.closest(".chooseSubjectContent").find(".paperChooseRadio")
				.removeClass("nowChoosen");
		radioEle.addClass("nowChoosen");
		subjectStamp.choosenIndex = parseInt(radioEle.attr("index"));
	}
	function changeSlider() {
		//删除进度条

		//重新设置进度条
		if (testPaper.paper.subjects.length <= 1) {
			$(testPaper.className).find(".subjectRooter").find("#stepState").empty();
			$(testPaper.className).find(".subjectRooter").find("#stepState")
					.slider({
						min : 1,
						max : 2,
						value : 2,//当前第几题最开始是 0 
						orientation : "horizontal",
						range : "min",
						slide : function(event, ui) {
							return false;

						}
					}).addSliderSegments(
							$(testPaper.className).find(".subjectRooter").find(
									"#stepState").slider('option').max);
		} else {
			$(testPaper.className).find(".subjectRooter").find("#stepState").empty();
			$(testPaper.className).find(".subjectRooter").find("#stepState")
					.slider({
						min : 1,
						max : testPaper.paper.subjects.length,
						value : testPaper.nowSubjectIndex + 1,//当前第几题最开始是 0 
						orientation : "horizontal",
						range : "min",
						slide : function(event, ui) {
							return false;

						}
					}).addSliderSegments(
							$(testPaper.className).find(".subjectRooter").find(
									"#stepState").slider('option').max);

		}

	}
	function changeSubmitButtonAndIcon() {
		//改变button的请求指向和
		var buttonEle = $(testPaper.className).find(".subjectRooter").find(
				"#papertestSubmitButton");
		var buttonEle1 = $(testPaper.className).find(".subjectRooter").find(
				"#preSubjectButton");
		buttonEle1.unbind('click');
		buttonEle1.click(function() {
			preSubjectClickEvent();

		});
		var spanEle = $(testPaper.className).find(".subjectRooter").find(
				"#papertestSubmitButton").find("span");
		buttonEle.unbind('click');
		//1.判断nowSubject 是不是最后一个，是的话，就设置click事件为submitClick
		if (testPaper.nowSubjectIndex == testPaper.paper.subjects.length - 1) {
			//变成了最后一道题了
			if (testPaper.paperType == -1) {
				//做题模式下，变成提交的按钮
				//1.span 的类换一下
				spanEle.removeClass("fui-arrow-right");
				if (spanEle.hasClass("fui-check-circle") == false)
					spanEle.addClass("fui-check-circle");
				//2.提交事件换一下
				buttonEle.click(function() {
					submitClick($(this));

				});

			} else if (testPaper.paperType == 0) {
				//查看模式,最后一个题的时候,去掉事件
				//事件已经去掉了,所以触发不了了

			}

		} else {
			//不是最后一题，那都是下一个
			spanEle.removeClass("fui-check-circle");
			if (spanEle.hasClass("fui-arrow-righ") == false)
				spanEle.addClass("fui-arrow-righ");
			buttonEle.click(function() {
				nextButtonClick($(this));

			});
		}

	}
	function initStateVar() {
		//设置环境变量
		//题目切换完后，设置下subjectStamp
		subjectStamp = {
			startTime : new Date().Format("yyyy-MM-dd hh:mm:ss"),
			endTime : "",
			wordSelectList : [ false, false, false, false ],//文字选取情况，这个值会在鼠标抬起的时候读，用于渲染形状
			selectList : [ -1, -1, -1, -1 ],//选择的情况，索引和值为一对
			choosenIndex : -1,//选择题的选项
			textList : [ "", "", "", "" ],//填空题的列表
			selectPairNum : -1,//连线时，单击上册图层选择的pairNum,
			x : -1,
			y : -1,
			lines : [],
			lines_r : [],//饭向数组
		};

		//开始时间设置一下
	}

	function nextButtonClick(thisEle) {
		//下一题事件，最初就是这个事件挂在button上
		switchSubjectToNext();

	}

	function submitClick(thisEle) {
		//提交事件，如果试卷类型是0 或1 ，不提交，点击返回
		if (checkSubjectComplete() == false) {
			swal("", "请先完成题目", "error")

		} else {
			//保存题目
			saveSubject();
			swal({
				title : '提示',
				text : "确定交卷吗",
				type : 'info',
				showCancelButton : true,
				confirmButtonText : '是的',
				cancelButtonText : '取消',
			})
					.then(
							function() {
								swal({
									title : '',
									showCloseButton : false,
									showCancelButton : false,
									showConfirmButton : false,
									allowOutsideClick : false,
									allowEscapeKey : false,
									allowEnterKey : false,
									text : "请稍后，正在交卷中..."
								});
								$
										.ajax({
											url : "${pageContext.request.contextPath}/submitPaper",
											type : 'POST',
											dataType : "JSON",
											contentType : "application/json",
											async : false,
											data : JSON
													.stringify(testPaper.paper),
											success : function(data) {

												if (data.result == true
														|| data.result == "true") {

													swal(
															{
																title : '',
																text : "交卷成功,现在查看答题结果吗",
																type : "success",
																showCancelButton : true,
																confirmButtonText : '是的',
																cancelButtonText : '不了',
															})
															.then(
																	function() {

																		location.href = '${pageContext.request.contextPath}/checkPaperDetail?'
																				+ 'pid='
																				+ testPaper.pid;

																	},
																	function() {
																		location.href = '${pageContext.request.contextPath}/getStudentNodoingPaperPage'
																	});
												} else {

													swal("错误", "添加失败，请稍后再试",
															"error");
												}

											},
											error : function() {

												swal("错误", "网络错误,提交失败，请误",
														"error");
											}

										})

							}, function() {

							})

		}

	}
	function setAudio(subject) {
		//在网页中创建audio
		if ($(".subjectAudioView").length <= 0) {
			//创建
			var audioText = "<video class='subjectAudioView' ></video>";//不可见的video标签
			for (var i = 0; i < 4; i++) {
				var audioEle = $(audioText);
				$('body').append(audioEle);//放到body上,点击图片的时候，trggier它的play事件就行
				audioEle.attr("controls", "");
				audioEle.css("display", "block");
			}
		}
		setAudioSrc(subject);

	}
	function setAudioSrc(subject) {
		//设置链接和index,连接在哪里？？？在subject里面
		$(".subjectAudioView").each(
				function(index, ele) {
					//遍历，怎么做
					var ele = $(ele);
					ele.empty();
					var sourcEle = $("<source />");
					ele.append(sourcEle);
					sourcEle.prop("type", "video/webm");
					sourcEle.prop("src", '${pageContext.request.contextPath}/'
							+ subject.audios[subject.indexList[index]]);
					ele.attr("index", subject.indexList[index]);//设置src
				});

	}
</script>
</html>