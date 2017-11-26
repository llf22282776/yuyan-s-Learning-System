/**
 * 
 */


var queryState={
		date:"",
        title:""
		
		
		
}
//添加事件了
$("#querySubmitButton").click(function(){
    submitClick($(this));


});

$("#queryDatePicker").click(function(){
    datePickClickEvent($(this));


})
$('#queryDatePicker').datetimepicker({
	format:'yyyy-mm-dd',
	minView:3
});

$("#queryInput").change(function(){

    queryInputChanging($(this));

})
/**
 * 
 * 查询按钮被点击
 * 
 * */
function submitClick(thisEle){
    $.ajax({
        url : BasePath+"/getQueryResult",
        type : 'POST',
        dataType : "html",
        contentType : "application/json",
        async : true,
        data : JSON.stringify(queryState),
        success:function(data){
        	//1.情况列表并且渲染数据
            clearPaperListAreaAndAdd(data);
        	//2.给card挂事件
            bindCardEvent();
        	
        },
        error:function(){
        	swal("","网络错误，无法获得列表","error");
        	
        	
        }


    });
	
}
/**
 * 输入框输入事件
 *
 * */
function queryInputChanging(thisEle){
    queryState.title=thisEle.val();


}
/**
 * 时间选择器被单击 
 * 
 * */
function datePickClickEvent(thisEle){
    $('#queryDatePicker').datetimepicker('show').on('changeDate', function(ev){

        console.log(new Date(ev.date.valueOf()).Format("yyyy-MM-dd hh:mm:ss"));
        queryState.date = new Date(ev.date.valueOf()).Format("yyyy-MM-dd hh:mm:ss");
        $('#queryDatePicker').datetimepicker('hide');
    });
}
/**
 * 清空listArea，并渲染数据
 * 
 * 
 * */
function clearPaperListAreaAndAdd(data){
	$("#queryContainer").find(".paperListDivContent").empty();
    $("#queryContainer").find(".paperListDivContent").append(data);
}


/**
 * 鼠标移入card事件出现
 * 
 * */
function cardHoverEvent(thisEle){
	
	
	
}
/**
 * 给各个类挂载事件
 * 
 * */
function bindCardEvent(){

    $("#queryContainer").find(".paperCard").unbind('click');
    $("#queryContainer").find(".paperCard").click(function(){
        //点击了下
        queryPaperCardClick($(this));


    })
	
	
}
function queryPaperCardClick(thisEle){
    swal({
        title : '提示',
        text : "确定查看详细情况吗",
        type : 'info',
        showCancelButton : true,
        confirmButtonText : '是的',
        cancelButtonText : '取消',
    }).then(function(){
        location.href=BasePath+"/checkPaperDetail?"+"pid="+thisEle.find(".paperPidDiv").text();
    },function(value){

    });


}



