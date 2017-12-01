/**
 * 
 */
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
	    //这里访问服务器，
    },function(value){

    });


}