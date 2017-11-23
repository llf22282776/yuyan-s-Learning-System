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
<script src="${pageContext.request.contextPath}/js/cropper.js"></script>
<script src="${pageContext.request.contextPath}/js/commonPaper.js"></script>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/icons/svg/student.ico" />
</head>
<body>
	<div class="rootContainer">
		<%@include file="../common/header.jsp"%>
		<div class="">
			<div style="display: block" class="jumbotron contentDiv  waitingDiv">
				<!-- 这里显示请稍后，正在拉取试卷 -->
				<div class="waitTextDiv">
					<span class="icon-spinner icon-spin"></span>请稍后，正在拉取试卷...
				</div>
			</div>
			<div style="display: none" class="jumbotron contentDiv subjectDiv">

			</div>

		</div>




	</div>

</body>
<script>
	$(document)
			.ready(
					function() {
						//拉取题目
						$
								.ajax({
									url : "${pageContext.request.contextPath}/getTestPaper",
									type : 'POST',
									dataType : "json",
									async : false,//同步的方法  
									success : function(data) {
										if (data.result == true
												|| data.result == "true") {
											//开始初始化试卷
											//1.去掉等待面板
											$(".contentDiv").css("display","none");
											$(".subjectDiv").css("display","block");
											initPaper(".subjectDiv", -1, data);

										} else {
											//返回到首页
											swal("错误", "拉取试卷失败，请联系管理员或重新选择试卷",
													"error")
													.then(
															function() {
																//回到上一个列表页面
																location.href = "${pageContext.request.contextPath}/getStudentNodoingPaperPage";

															});

										}

									},
									error : function() {

										swal("错误", "网络错误,拉取试卷失败", "error")
												.then(
														function() {
															location.href = "${pageContext.request.contextPath}/getStudentNodoingPaperPage";

														});
									}

								});

						$(".stepState").slider({
							min : 1,
							max : 10,
							value : 1,
							orientation : "horizontal",
							range : "min",
							slide : function(event, ui) {
								return false;

							}
						}).addSliderSegments(
								$(".stepState").slider("option").max);
						$(".stepState").css("background-color", "#ffffff")

					});

	var subjectStamp = {
		startTime : "",
		endTime : "",

	};
	var testPaper = {
		isStarted : false,//判断是否开始
		paper : {},//试卷保存在这个对象里面
		startTime : "",//答卷开始时间
		endTime : "",//答卷结束时间
		subjectsLength : 0, //试卷总长度
		nowSubjectIndex : 0,//现在是第几题
		paperType : -1,//-1 答题形式 0查看形式  （答完题后可以查看）
		
	};
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
			className : className
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
		//切换到第一题
		switchSubjectToNext();
	}

	function createElement(className) {
		//清空这个类下的内容，然后创建
		$(className).empty();
		var contentEle = $('<div class="row subjectHeader">标题</div><div class="row subjectContent"></div><div class="row subjectRooter"><div class="scoreDiv"></div><div class="row stepState"></div><div class="row nextButtonDiv"><a id="papertestSubmitButton" class=""><span class="iconSubject fui-arrow-right"aria-hidden="true"></span> </a></div></div>');

		$(className).append(contentEle);//添加进来
	}
	function switchSubjectToNext() {
		//切换subject到下一题，第一次的时候，下一题是0编号
		if (checkSubjectComplete() == false) {
			swal("提示", "请完成这道题目");
		} else {
			//做完了，
			//1.保存这道题的做题结果，开始/结束时间 时间，
			saveSubject();
			//2.清除答题区域
			cleanSubjectArea();
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
		if (testPaper.type == 0 || testPaper.nowSubjectIndex == -1) {
			//查询模式或者刚开始不用检查
			return true;//不用检查

		} else {
			//需要检查
			var subjectType = testPaper.paper.subjects[testPaper.nowSubjectIndex];
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
		if (testPaper.paperType == -1) {
			//答题模式,保存,就是放到原来的paper里面去
			if(testPaper.nowSubjectIndex != -1){
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
		$(className).find(".subjectContent").empty();
		//更改题目编号为下一个
		testPaper.nowSubjectIndex += 1;
		//绘制题目
		paintSubject();
		//更新最初的题目状态量
		subjectStamp = {
			startTime : "",
			endTime : "",
			wordSelectList : [ false, false, false, false ],//文字选取情况，这个值会在鼠标抬起的时候读，用于渲染形状
			selectList : [ -1, -1, -1, -1 ],//选择的情况，索引和值为一对
			choosenIndex : -1,//选择题的选项
			textList : [ "", "", "", "" ],//填空题的列表
			selectPairNum : -1,//连线时，单击上册图层选择的pairNum,
			x:-1,
			y:-1
		};
	}
	function paintSubject() {
		//绘制答题区域
		//1取下一题，判断类型，进行渲染
		var nextSubject = testPaper.paper.subjects[testPaper.nowSubjectIndex];
		var className=testPaper.className;
		//设置标题
		$(className).find(".subjectHeader").text((testPaper.nowSubjectIndex+1)+"."+nextSubject.title);
		
		if (nextSubject.type == 0) {
			//吧连线题元素添加到里面去

			$(className).find(".subjectContent").append(lineSubjectEle);

			//连线题
			paintCanvas($(className).find(".subjectContent").find(
					"#linePainter").eq(0), testPaper.paperType, nextSubject);

		} else if (nextSubject.type == 1) {
			//选择题
			$(className).find(".subjectContent").append(chooseSubjectEle);
			paintChoose($(className).find(".subjectContent").find(
					".chooseSubjectContent"), testPaper.paperType, nextSubject);

		}

	}
	function paintCanvas(canvasEle, paperType, subject) {
		//在这个元素里面绘制图片啥的

		if (paperType == -1) {
			//绘制 图片 单词 添加点击事件 添加到相应的组里面去
			drawThePicsAndWords(canvasEle, paperType);

		} else if (paperType == 0) {
			//只是用户和答案都画上去 ，没有反应事件
			drawThePicsAndWords_static(canvasEle, subject);
		}

	}

	function drawThePicsAndWords(canvasEle, subject) {
		//按照间距依次绘制文字，图片，播音图标
		//绘制初始的画板样子，
		//0 设置音频
		setAudio();
		//1.清除画板
		canvasEle.clearCanvas();//清除画布
		for (var i = 0; i < subject.pics.length; i++) {
			//绘制文字
			canvasEle.drawText({
				name : 'word' + i,
				layer : true,
				data : {
					pairNum : i,
					pairTo : -1,
					isSelect : false,
				},
				groups : [ 'words' ],
				text : subject.words[i],
				fontSize : 16,
				x : 10*(i+1)+212.5*i,
				maxWidth : 100,
				y : 10,
				fillStyle : '#34495e',
				strokeStyle : '',
				strokeWidth : 1,
				click : function(layer) {

					//1.设置words组的颜色（正常），大小正常(),粗度正常（）
					$(this).setLayerGroup('words', {
						fillStyle : '#34495e',
						scale: '1'
					}).drawLayers();
					
					//2 设置本层字体变颜色（变蓝） ,大小（变大），粗度（）
					$(this).animateLayer(layer, {
						      scale: '+=0.25',
						      fillStyle : '#34495e',
						}, 250).drawLayers();
					//3.设置selectNum为这个图层的pairNum
					subjectStamp.selectPairNum = layer.data.pairNum;
					//4.设置绘制起始点x , y
					subjectStamp.x=layer.eventX ;
					subjectStamp.y=layer.eventY ;
				}
			});
			//绘制图片??顺序如何指定-》返回了顺序
			canvasEle.drawImage({
				name : 'pic' + i,
				layer : true,
				groups : [ 'pics' ],
				data : {
					
					pairNum : subject.indexList[i],//这个编号是本身的对号
					pairFrom : -1,
				},
				source : '${pageContext.request.contextPath}/'
						+ subject.pics[subject.indexList[i]],
				x : 10*(i+1)+212.5*i,
				y : 230,
				fromCenter : false,
				rotate : 0,
				click : function(layer) {
					//传进来的参数就是这个layer本身
					//应该触发的事件,播放声音
					$(".subjectAudioView[index='"+layer.pairNum+"']").play();
					//如果点击后,判断selectNum!=-1,就要进行画图了
					if(subjectStamp.selectPairNum != -1){
						//获取x y
						var endX=layer.eventX;
						var endY=layer.eventY;
						
						//取出selectNum为起点的线，和end为这个layer的pairNum的线
						var lineLayers=$(this).getLayers(function(layer1) {
						  return (layer1.data.startNum == subjectStamp.selectPairNum || layer1.data.endNum == layer.data.pairNum);
						});
						for(var i=0;i<lineLayers.length;i++){
							//取出这两条线的startNum，设置为allSelect = false
							var lineLayer= lineLayers[i];
							subjectStamp.wordSelectList[lineLayer.data.startNum]=false;
							//删除图层
							$(this).removeLayer(lineLayer.name);
						}
						//所有的words图层回归到正常状态
						$(this).setLayerGroup('words', {
							fillStyle : '#34495e',
							scale: '1'
						}).drawLayers();
						//设置selectNum 的select为true
						subjectStamp.wordSelectList[subjectStamp.selectPairNum]=true;
						
						//划线，添加startNum,endNum,这个先添加到lines层，
						$(this).drawLine({
						  data:{
							startNum:subjectStamp.selectPairNum,
							endNum:layer1.data.pairNum,
							  
						  },
						  layer: true,
						  name:'line'+subjectStamp.selectPairNum+"_"+layer1.data.pairNum,
						  groups:['lines'],
						  strokeStyle: '#333333',
						  strokeWidth: 3,
						  x1: subjectStamp.x, 
						  y1: subjectStamp.y,
						  x2: endX, 
						  y2: endY,
						});
						
						
						//更改选择情况
						subjectStamp.selectList[subjectStamp.selectPairNum]=layer.data.pairNum;
						//给图层添加pairTo和pairFrom
						$(this).setLayer('word'+subjectStamp.selectPairNum,{
							data:{
								pairNum:subjectStamp.selectPairNum,
								pairTo:layer.data.pairNum
								
							}
						}).drawLayers();
						$(this).setLayer(layer.name,{
							data:{
								pairNum:layer.data.pairNum,
								pairFrom:subjectStamp.selectPairNum
								
							}
						}).drawLayers();
						//selectList设置下
						subjectStamp.selectList[subjectStamp.selectPairNum] = layer.data.pairNum;
						
						//selectNum = -1
						subjectStamp.selectPairNum =-1;
						//重画所有层
						$(this).drawLayers();
						
					}
					
				},

			});
			//设置
			
		}
		
	}

	function drawThePicsAndWords_static(canvasEle, subject) {
		//人都做完了，绘制玩基本的，就要绘制线条,正确答案
		setAudio();
		//1.清除画板
		canvasEle.clearCanvas();//清除画布
		for (var i = 0; i < subject.pics.length; i++) {
			//绘制文字
			canvasEle.drawText({
				name : 'word' + i,
				layer : true,
				data : {
					pairNum : i,
					pairTo : -1,
					isSelect : false,
				},
				groups : [ 'words' ],
				text : subject.words[i],
				fontSize : 16,
				x : 10*(i+1)+212.5*i,
				maxWidth : 100,
				y : 10,
				fillStyle : '#34495e',
				strokeStyle : '',
				strokeWidth : 1,
				click : function(layer) {
					//不在有反应
				}
			});
			//绘制图片
			canvasEle.drawImage({
				name : 'pic' + i,
				layer : true,
				groups : [ 'pics' ],
				data : {

					pairNum : subject.indexList[i],//这个编号是本身的对号
					pairFrom : -1,
				},
				source : '${pageContext.request.contextPath}/'
						+ subject.pics[subject.indexList[i]],
				x : 10*(i+1)+212.5*i,	
				y : 230,
				fromCenter : false,
				rotate : 0,
				click : function(layer) {
					//传进来的参数就是这个layer本身
					//应该触发的事件,播放声音
					$(".subjectAudioView[index='"+layer.pairNum+"']").play();
				},

			});
			//绘制用户划线/或者题目原生划线
			//判断用户选择的正确与否，
			var picDxUser=subject.indexList.indexOf(subject.selectList[i]);//用户选择的第几个图片
			var picDxAnswer=subject.indexList.indexOf(i);//第i个单词真实对应的图片编号
			if(picDxUser == picDxAnswer){
				//用户选择一致,画一条直线
				canvasEle.drawLine({
					name : 'line' + i,
					layer : true,
					groups : [ 'lines' ],
					strokeStyle: '#2ecc71',
					strokeWidth: 3,
					x1 : 10*(i+1)+212.5*i+100,
					y1 : 10+16,
					x2 : 10*(picDxUser+1)+212.5*picDxUser+100,//图片在的那个点
					y2 : 230,
					
					
				});
			}else {
				//用户选择不一致,画两条直线
				//这条线是用户的线，错误的，红色
				canvasEle.drawLine({
					name : 'line' + i,
					layer : true,
					groups : [ 'lines' ],
					strokeStyle: '#e74c3c',
					strokeWidth: 3,
					x1 : 10*(i+1)+212.5*i+100,
					y1 : 10+16,
					x2 : 10*(picDxAnswer+1)+212.5*picDxAnswer+100,//图片在的那个点
					y2 : 230,
				});
				//这条是正确的
				canvasEle.drawLine({
					name : 'line' + i,
					layer : true,
					groups : [ 'lines' ],
					strokeStyle: '#2ecc71',
					strokeWidth: 3,
					x1 : 10*(i+1)+212.5*i+100,
					y1 : 10+16,
					x2 : 10*(picDxAnswer+1)+212.5*picDxAnswer+100,//图片在的那个点
					y2 : 230,
				});
			}
			canvasEle.drawLayers();
		}
		
	}
	function paintChoose(radiosEle, paperType, subject) {
		//在这个元素里面绘制选择题，添加radio啥的
		if (paperType == -1) {
			//用户做，只画基本的，还要添加反应事件,bind前先unbind
			baseChooseSetting(radiosEle, subject);
			
		} else if (paperType == 0) {
			//用户和答案都画上去 
			 bothChooseSettion(radiosEle, subject)
		} else {
			//只画答案
			
		}
		addEvent();//添加

	}
	function baseChooseSetting(radiosEle, subject){
		//1.设置所有为false
		radiosEle.find(".paperChooseRadio").prop("checked",false);
		radiosEle.find(".paperChooseRadio").removeAttr("disabled");
		radiosEle.find(".paperChooseRadio").find("h4").css("color","inherit");
		//2.设置文本
		
		radiosEle.find(".paperChooseRadio").each(function(index,ele){
			ele=$(ele).closest(".row");
			ele.find("h4").text(subject.texts[index]);
			
			
		})
		//3.去掉所有的nowChoosen 类,name设置一致
		radiosEle.find(".paperChooseRadio").removeClass("nowChoosen");
		radiosEle.find(".paperChooseRadio").attr("name","chooseRadio");
		//4.设置事件
		radiosEle.find(".paperChooseRadio").unbind("click");
		addEvent(radiosEle, testPaper.paperType);
	}
	function bothChooseSettion(radiosEle, subject){
		//都设置上去
		//1.设置所有为false
		radiosEle.find(".paperChooseRadio").prop("checked",false);
		radiosEle.find(".paperChooseRadio").removeAttr("disabled");
		radiosEle.find(".paperChooseRadio").find("h4").css("color","inherit");
		
		//2.设置文本
		
		radiosEle.find(".paperChooseRadio").each(function(index,ele){
			ele=$(ele);
			ele.find("h4").text(subject.texts[index]);
			
			
		});
		//先去掉
	
		if(subject.choosenIndex!=subject.answerIndex){
			//设置正确的那个为选中状态，颜色为默认值
			radiosEle.find(".paperChooseRadio[index='"+subject.answerIndex+"']").attr("name","chooseRadio_answer");
			radiosEle.find(".paperChooseRadio[index='"+subject.answerIndex+"']").prop("checked",true);
			//
			radiosEle.find(".paperChooseRadio[index='"+subject.answerIndex+"']").closest(".row").find("h4").css("color","#2ecc71");
			//设置用户选的那个为选中，颜色
			radiosEle.find(".paperChooseRadio[index='"+subject.choosenIndex+"']").attr("name","chooseRadio");
			radiosEle.find(".paperChooseRadio[index='"+subject.choosenIndex+"']").prop("checked",true);
			radiosEle.find(".paperChooseRadio[index='"+subject.answerIndex+"']").closest(".row").find("h4").css("color","#e74c3c");
		}else {
			//文本颜色为绿色
			radiosEle.find(".paperChooseRadio[index='"+subject.choosenIndex+"']").attr("name","chooseRadio");
			radiosEle.find(".paperChooseRadio[index='"+subject.choosenIndex+"']").prop("checked",true);
			radiosEle.find(".paperChooseRadio[index='"+subject.answerIndex+"']").closest(".row").find("h4").css("color","#e74c3c");
			
		}
		//所有都不可选取
		radiosEle.find(".paperChooseRadio").attr("disabled",true);
		//3.去掉所有的nowChoosen 类,name设置一致
		radiosEle.find(".paperChooseRadio").removeClass("nowChoosen");
		//去掉所有事件
		radiosEle.find(".paperChooseRadio").unbind("click");
		
		
		
		
	}
	function addEvent(radiosEle) {
		//添加选中事件
		radiosEle.find(".paperChooseRadio").bind("click",function(){
			paperChooseRadioClick($(this));
			
			
		})
		
	}
	function paperChooseRadioClick(radioEle){
		
		radioEle.closest(".chooseSubjectContent").find(".paperChooseRadio").removeClass("nowChoosen");
		radioEle.addClass("nowChoosen");
		subjectStamp.choosenIndex =parseInt(radioEle.attr("index"));
	}
	function changeSlider() {
		//删除进度条
		$(testPaper.className).find(".subjectRooter").find(".stepState").empty();
		//重新设置进度条
		$(testPaper.className).find(".subjectRooter").find(".stepState").slider({
			    min: 1,
			    max: testPaper.paper.subjects.length,
			    value: testPaper.nowSubjectIndex+1,//当前第几题最开始是 0 
			    orientation: "horizontal",
			    range: "min",
			    slide: function( event, ui ) {
			   		  return false;
			       
			    }
			}).addSliderSegments($(testPaper.className).find(".subjectRooter").find(".stepState").slider("option").max);
	}
	function changeSubmitButtonAndIcon() {
		//改变button的请求指向和
		var buttonEle=$(testPaper.className).find(".subjectRooter").find("#papertestSubmitButton");
		var spanEle=$(testPaper.className).find(".subjectRooter").find("span");
		buttonEle.unbind('click');
		//1.判断nowSubject 是不是最后一个，是的话，就设置click事件为submitClick
		if(testPaper.nowSubjectIndex == testPaper.paper.subjects.length-1){
			//变成了最后一道题了
			if(testPaper.paperType == -1){
				//做题模式下，变成提交的按钮
				//1.span 的类换一下
				spanEle.removeClass("fui-arrow-right");
				spanEle.addClass("fui-check");
				//2.提交事件换一下
				buttonEle.click(function(){
					submitClick($(this));
					
					
				});
				
			}else if(testPaper.paperType == 0){
				//查看模式,最后一个题的时候,去掉事件
				//事件已经去掉了,所以触发不了了
				
				
			}
			
		}else {
			//不是最后一题，那都是下一个
			spanEle.removeClass("fui-check");
			if(spanEle.hasClass("fui-arrow-righ") == false)spanEle.addClass("fui-arrow-righ");
			buttonEle.click(function(){
				nextButtonClick($(this));
				
				
			});
		}
		
		
	}
	function initStateVar() {
		//设置环境变量
		//题目切换完后，设置下subjectStamp
		subjectStamp = {
			startTime : "",
			endTime : "",
			wordSelectList : [ false, false, false, false ],//文字选取情况，这个值会在鼠标抬起的时候读，用于渲染形状
			selectList : [ -1, -1, -1, -1 ],//选择的情况，索引和值为一对
			choosenIndex : -1,//选择题的选项
			textList : [ "", "", "", "" ],//填空题的列表
			selectPairNum : -1,//连线时，单击上册图层选择的pairNum,
			x:-1,
			y:-1
		};
		
		
		
		
		
		//开始时间设置一下
	}

	function nextButtonClick(thisEle) {
		//下一题事件，最初就是这个事件挂在button上

	}

	function submitClick(thisEle) {
		//提交事件，如果试卷类型是0 或1 ，不提交，点击返回

	}
	function setAudio(subject) {
		//在网页中创建audio
		if ($(".subjectAudioView").length <= 0) {
			//创建
			var audioText = "<video class='subjectAudioView' ></video>";//不可见的video标签
			for (var i = 0; i < 4; i++) {
				var audioEle = $(audioText);
				$(body).append(audioEle);//放到body上,点击图片的时候，trggier它的play事件就行

			}
		}
		setAudioSrc(subject);

	}
	function setAudioSrc(subject) {
		//设置链接和index,连接在哪里？？？在subject里面
		$(".subjectAudioView").each(function(index, ele) {
			//遍历，怎么做
			var ele = $(ele);
			ele.attr("src", subject.audios[subject.indexList[index]]);//设置src
			ele.attr("index", subject.indexList[index]);//设置src
		});

	}
</script>
</html>