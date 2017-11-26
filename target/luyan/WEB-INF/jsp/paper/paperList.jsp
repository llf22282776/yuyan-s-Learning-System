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
<link href="${pageContext.request.contextPath}/css/student.css"
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
		<%@include file="../common/header.jsp"%>
		<div class="jumbotron contentDiv">
			<div class="container  paperListDiv">

				<div class="paperListDivContent  row pbl">
				
				
				<c:forEach 
							var="paper" 
							items="${paperList}" 
							varStatus="status"
							
						>
						<div class="paperCard row">
						<div class="col-md-1 paperPidDiv">${paper.getPid()}</div>
						<div class="col-md-1">
							<span class="fui-calendar"></span>
						</div>
						<div class="col-md-10">
							<div class="row paperTitle">${paper.getPname()}</div>
							<div class="row paperDate">${paper.getPdate().toString()}</div>
						</div>
					</div>
						
						   
				</c:forEach>
				
		
					
				</div>
				<div class="refreshButton buttomLineDiv row pbl">
					<a id="refreshPaperButton" href="#" class=""><span
						class="fa fa-refresh iconSubject"></span></a>

				</div>
				<div class="paperListDivFooter row pbl">
					<a id="returnButton" href="${pageContext.request.contextPath}/" class=""><span class="fa fa-arrow-circle-left iconSubject"
						aria-hidden="true"></span> </a>

				</div>

			</div>


		</div>




	</div>

</body>
<script>
	$(document).ready(function(){
	    $("#refreshPaperButton").click(function (){
	    	location.href=location.href;
	    
	    });
	    $(".paperCard").click(function(){
	    	
	    	var ele=$(this);
	    	swal({
				  title: '提示',
				  text: "确定要开始做这套卷子吗",
				  type: 'warning',
				 
				  showCancelButton: true,
				  confirmButtonText: '是的',
				  cancelButtonText: '我再想想吧',
				}).then(function () {
					
					$.ajax({
						url: "${pageContext.request.contextPath}/getPaperMetaMsg" ,  
				        type: 'POST',  
				        async: true,  
				        dataType:"json", 
				        data: {
				        	pid:ele.find(".paperPidDiv").text(),
				        },
						success:function(data){
							if(data.result == true || data.result == "true"){
								//现在让location.href=那个特定的request
								location.href="${pageContext.request.contextPath}/paperTestPage"
								
								
								
								
							}else {
								
								swal("错误","该试卷可能已完成，无法作答，请刷新网页或联系管理员","error");
							}
								
							
						},
						error:function(){
							
							swal("错误","网络错误，无法获取试卷","error");
						}
						
						
					})
					
				},function(){
					
					
					
					
				});
	    	
	    	
	    	
	    });
		
		
	});
</script>
</html>