/**
 * 
 */
function radioChooseClick(thisEle){
		//更改
		$(".chooseRadio").removeClass("nowChooseRadio");
		thisEle.addClass("nowChooseRadio");
		
	}
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
		//设置下第一个选择题选项被选中
		
		$(".chooseRadio").removeClass("nowChooseRadio");
		$(".chooseRadio").eq(0).addClass("nowChooseRadio");
		$(".chooseRadio").eq(0).prop("checked",true);
		
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
		//3 保存这个音频文件
		var index=thisEle.closest(".oneLineRadio").eq(0).attr("index");
		audios["index"+index]=recorderFile;//保存在这里面，好提取
		
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
		var type=parseInt($(".nowRadio").eq(0).attr("subjectType"));
		if(combineElementsToSubject(type)){
			//2 将subject添加到当前试卷的subjectList里面去和面板里面
			addSubjectToPaperList();
			//3.清空出题区域
			cleanSubjectArea();
			//4.弹出提示，表示成功，点击确定返回上一个页面
			swal({ 
				  title: "提示", 
				  text: "出题成功!干的不错", 
				  type: "success",
				  showCancelButton: false, 
				  confirmButtonText: "确定", 
				  closeOnConfirm: true
				}).then(function(){
			
				
					//返回上一个页面
						thisEle.closest(".subjectFootDiv").find(".cancelButton").eq(0).click();
					
					
				});
			
		}else{
			swal("","请填写完全","warning");
			
		}
		
		
		
		
	}
	function combineElementsToSubject(type){
		// 0 连线 1 选择 2 填空
		//1.判断每个元素是否completed=true 如果不是return false
		if(!checkCompletedByType(type)){
			return false;
		}
		//2.提取每个元素，组成一个元素列表
		var elementsGetted=getElementsByType(type);
		//3.添加进nowSubject里面
		nowSubject.elements=elementsGetted;
		nowSubject.type=type;
		nowSubject.title=$("#subjectName").val();
		//现在算下总分
		nowSubject.totalScore=0;
		if(nowSubject.type==0){
			//连线题单独算分
			for(var i=0;i<nowSubject.elements.length;i++){
				nowSubject.totalScore+=parseInt(nowSubject.elements[i].score);
			}
			
		}else if(nowSubject.type==1){
			//选择题就2分
			nowSubject.totalScore=2;
			nowSubject.index=$(".nowChooseRadio").attr("index");
			
		}
		return true;
	}
	function getElementsByType(type){
		//根据题目类型返回一个elements的数组
		var elements=[];//最后返回的数组
		if(type == 0){
			//连线题，每个选项需要提取 : 文字 图形 音频 分数，填充在element对象的相应字段里面
			$(".oneLineRadio").each(function(index,ele){
				ele=$(ele);
				var element={};
				//1.图片数据
				ele.find(".linePic").eq(0).cropper('getCroppedCanvas').toBlob(function (blob) {
					element.pic=blob;
				});
				//2 声音数据
				element.audio=audios["index"+ele.attr("index")];
				//3 单词
				element.word=ele.find(".wordInput").eq(0).val();
				//4.分数
				element.score=ele.find(".scoreInput").eq(0).val();
				//5 文本元素(没有)
				element.text="";
				elements.push(element);
				
			});
			
			
		}else if(type == 1){
			//选择题 提取四个选项,每个选项只用提取
			$(".chooseInput").each(function(index,ele){
				//遍历每一个
				ele=$(ele);
				var elememt={};
				element.text=ele.val();
				elements.push(element);
				
			});			
		}
		return elements;
	}
	function checkCompletedByType(type){
		//根据type判断响应的区域是否已经完成
		if(type==0){
			//连线题，几个getter是否都是completed的状态
			var isComplete=true;
			$(".getter").each(function(index,ele){
				ele=$(ele);
				if(ele.attr("completed")  == "false")isComplete=false;
				
			});
			return isComplete;
		}else if(type == 1){
			//选择题,几输入框是否是填写完全状态
			var isComplete=true;
			$(".chooseInput").each(function(index,ele){
				ele=$(ele);
				if(ele.attr("completed")  ==  "false")isComplete=false;
				
			});
			return isComplete;
			
			
		}else if(type==2){
			//填空题，没想好
			return false;
			
		}
		return false;
	}
	function addSubjectToPaperList(){
		//1.添加进paper的list里面
		paper.subjects.push(nowSubject);
		paper.subjectsNum++;//题目加1
		paper.totalScore+=nowSubject.totalScore;
		// 2.添加在外面的面板上
		addSubjectTototalDivList();
	}
	function addSubjectTototalDivList(){
		//让刚刚添加的题在面板上显示出来
		//一个卡片的形式
		//创建一个div
		var subjectCard= $("<div class='row subjectCard'><div class='col-md-1 subjectCardIndex'></div><div class='col-md-1 subjectCardIcon'></div><div class='col-md-9 subjectCardTitle'></div><div class='col-md-1 subjectCardDelete'></div><div>");
		$(".overviewSubjectDiv").eq(0).append(subjectCard);
		
		
		
		//题型搞上去
		//设置icon
			var iconEle=$("<span></span>");
		if(nowSubject.type == 0){
		
		
			subjectCard.find(".subjectCardIcon").eq(0).append(iconEle);
			iconEle.addClass("fui-image");
			
		}else if(nowSubject.type == 1){
		
			
			subjectCard.find(".subjectCardIcon").eq(0).append(iconEle);
			iconEle.addClass("fui-radio-checked");
			
		}
		//设置标题
		subjectCard.find(".subjectCardTitle").eq(0).text(nowSubject.title);
		//设置删除按钮
		var aEle=$("<a></a>");
		var deleteIcon=$("<span></span>");
		subjectCard.find(".subjectCardDelete").eq(0).append(aEle);
		aEle.append(deleteIcon);
		deleteIcon.addClass("fui-cross-circle");
		aEle.addClass("deleteSubjectButton");
		$(".deleteSubjectButton").unbind("click");
		//给这个添加click函数
		$(".deleteSubjectButton").bind("click",(function(){
			subjectDeleteButtonClick($(this));
		}));
		//接下来搞顺序
		$(".subjectCard").each(function(index,element){
			element=$(element);
			element.find(".subjectCardIndex").eq(0).text(index);

		});
		
		
	}
	function cleanSubjectArea(){
		//清理全部题型的div的残留，确保数据依然保存着
		/*1.选择题清空
		  1.completed false
		  2.pic替换成temp
		  3.音频删除
		  4.填空框清空
		  
		*/
		$(".getter").attr("completed",false);
		$(".linePic").cropper("replace","${pageContext.request.contextPath}/img/temp.png");
		$(".audioRow").empty();
		$(".wordInput").val("");
		$(".scoreInput").val("");
		/*
			选择题区域清空
		
		
		*/
		$(".chooseInput").val("");
		$(".chooseInput").attr("completed",false);
		$("#subjectName").val("");
		
		//数据结构清
		
		  nowSubject = {
				type : -1,
				title : "",
				totalScore:0,
				elements : [],
				index:0
			};
	}
	
	function subjectDeleteButtonClick(thisEle){
		//删除按钮点击
		//1.获得index从paper里面删除
		var index=parseInt( thisEle.closest(".subjectCard").find(".subjectCardIndex").text());
		var deleteOne=paper.subjects.splice(index,1);
		//2.总分- 数量-
		paper.subejectsNum--;
		paper.totalScore-=deleteOne[0].totalScore;
		
		//3 从面板里面删除
		thisEle.closest(".subjectCard").remove();
		;
		//4 重新排序
		$(".subjectCard").each(function(index,element){
			element=$(element);
			element.find(".subjectCardIndex").eq(0).text(index);

		});
		
	}
	function upLoadPaper(thisEle){
		//先判断下是否合法
		if(checkPaperMsgCompleted()==-1){
			//没有题目
			swal("干吗","你看看有题吗？","question");
			
			
		}else 
			
			if(checkPaperMsgCompleted() == 0){
			//没有标题
			swal("","试卷标题呢","question");
		}else {
			
			//1.给试卷打上时间,把标题放入数据结构里面
			paper.date=new Date().Format("yyyy-MM-dd hh:mm:ss");//时间
			paper.title=$(".paperTitleInput").val();
			var errorHappened=false;
			//4.点击上传，询问是否确定上传
			swal({
				  title: '提示',
				  text: "确定现在要发布这个试卷吗",
				  type: 'warning',
				  showCancelButton: true,
				  confirmButtonText: '是的',
				  cancelButtonText: '我再想想吧',
				}).then(function () {
					
					 //先上传源信息
					  $(".paperSubmitTextDiv").text("正在传输试卷源信息...");
						$.ajax({
								url: "${pageContext.request.contextPath}/paperUpload" ,  
						        type: 'POST',  
						        dataType:"JSON",
						        contentType:"application/json",
						        async: false,  
						        data: JSON.stringify(getPaperMsg()),  
								success:function(data){
									 //上传成功了就成功了
									 if(data.result =="true" || data.result ==true){
										 //取pid
										 paper.pid=data.des;
										 
										 return;
									 }
									 swal({
										 title:"错误",
										 text:"试卷上传失败因为"+data.des,
										 type:"error"
									 });
									 errorHappened=true;
								},
								error:function(e){
									 swal({
										 title:"错误",
										 text:"试卷上传失败，网络错误",
										 type:"error"
										 
									 });
									 errorHappened=true;
									
								}
								
							})
						if(errorHappened)return;	
					//这里就开始显示一个带有进度条的，不可点击外侧关闭的进度框
					 swal({
						 title: '',
						 showCloseButton: false,
						 showCancelButton: false,
						 showConfirmButton:false,
						 allowOutsideClick:false,
						 allowEscapeKey:false,
						 allowEnterKey:false,
						 html:"<div><div class='row pbl paperSubmitTextDiv'></div>"+
						 "<div  class='row pbl sliperDiv'></div></div>",
						 onOpen:function(){
							 //打开后要做的事情		
							 //1.读取lastIndex
							 //设置一个滑动条，总码数/初始位置
							   var errorHappened=false;
							  $(".sliperDiv").slider({
									    min: 1,
									    max: paper.subjects.length,
									    value: 1,
									    orientation: "horizontal",
									    range: "min",
									    slide: function( event, ui ) {
									   		  return false;
									       
									    }
									}).addSliderSegments($(".sliperDiv").slider("option").max);
							 //3 for 循环，index小于lastIndex的时候，从lastIndex开始,每完成一个进度条前进，文字改变
							 for(var i=0;i<paper.subjects.length;i++){
								 //设置文本
								 $(".paperSubmitTextDiv").text("正在传输第 "+(i+1)+" 道题");
								 //设置滑动条
								 $(".sliperDiv").slider("value",(i+1));
								 
								
								 if(i<lastIndex)continue;//仅仅只是
								 //不然就要上传
								 //构建一个formdata的对象
								 var dataForm=createSubjectFormdata(i);
								 $.ajax({
									 url: paper.subjects[i].sid==undefined||paper.subjects[i].sid==null?"${pageContext.request.contextPath}/subjectUpload":"${pageContext.request.contextPath}/subjectUploadAlreadyExist" ,  
							         type: 'POST',  
							         data: dataForm,  
							         dataType:"JSON",
							         async: false,  
							         cache: false,  
							         contentType: false,  
							         processData: false,  
									 success:function(data){
										 //上传成功了就成功了
										 if(data.result =="true" || data.result ==true)return ;
										 //失败了结束
										 swal("错误","第"+i+"道题因为"+data.des+"上传失败，再次点击上传即可从断电处继续","error");
									            	
									      //重新记一下
									     lastIndex=i;
									     errorHappened=true;
									            	
									             
									 },
									 error: function (returndata) {  
										 swal("错误","第"+i+"道题上传失败，再次点击上传即可从断电处继续","error")
											//重新记一下
						            		lastIndex=i;
						            		//
						            		errorHappened=true;
									            
							          }
								 });
								 
								 if(errorHappened)break;
							 }
							 
							 
							 //没完成一次循环，设置文本和进度条的位置
							 //5 全部完成，重置lastIndex,显示上传成功，关闭对话框
							//情况paper区域
							if(errorHappened)return;
							cleanPaper();
							swal("","发布试卷成功!","success");
							 
							 
							 
							 
						 }
						 
						 
						 
						 
					 });
					 
					 
					 
				}, function (dismiss) {
					
				});
			
			
			
			
		}
		
		
		
		
		
		
		
	}
	function checkPaperMsgCompleted(){
		//检查试卷
		if(paper.subjects.length <=0)return -1;
		else if($(".paperTitleInput").val().trim()==""){
			return 0;
			
		}else {
			return 1;
			
		}
		
		
		
	}
	function createSubjectFormdata(i){
		//有可能这个题是旧的题，如何处理在这里
		var formdata=new FormData();
		var subject=paper.subjects[i];
		
		//先把 title totalScore type取出来
		formdata.append("type",subject.type);
		formdata.append("pid",paper.pid);//每道题都必须有
		if(subject.sid!=undefined && subject.sid!=null){
			formdata.append("sid",subject.sid);
			return formdata;
		}
		formdata.append("title",subject.title);
		
		formdata.append("totalScore",subject.totalScore);
		if(subject.type==0){
			//连线题
			
			//然后遍历elements
			for(var i=0;i<subject.elements.length;i++){
				formdata.append("pic"+i,subject.elements[i].pic);
				formdata.append("audio"+i,subject.elements[i].audio);
				formdata.append("word"+i,subject.elements[i].word);
				formdata.append("score"+i,subject.elements[i].score);
			}
			
			
		}else if(subject.type==1){
			//选择题
			formdata.append("index",subject.index);
			for(var i=0;i<subject.elements.length;i++){
				formdata.append("text"+i,subject.elements[i].text);
				
			}
		}
		
		return formdata;
		
	}
	function cleanPaper(){
		//1 清理输入框
		$(".paperTitleInput").val("");
		//2 清理paper的subjectList和一些其他属性
		paper.subjects=[];
		paper.subjectsNum=0;
		paper.totalScore=0;
		paper.pid=-1;
		lastIndex=0;
		//3 清理div
		$(".overviewSubjectDiv").empty();
		
	}
	function getPaperMsg(){
		var msg={};
		msg.title=paper.title;
		msg.totalScore=paper.totalScore;
		msg.date=paper.date;
		return msg;
		
		
	}