/**
 * 清空 dblist里面的内容然后坠上数据
 */
function clearDBpaperListAndAppend(data){
	$("#dbpaperContainer").find(".paperListDivContent").empty();
    $("#dbpaperContainer").find(".paperListDivContent").append(data);
}


/**
 * 点击模态框弹出按钮
 * 
 * */
function modalButtonClickEevent(thisEle){
	//1.弹出模态框
    $("#drawBackModal").modal('show');
	//2.清空模态框列表的内容，
    $("#dbpaperContainer").find(".paperListDivContent").empty();
    $("#dbpaperContainer").find(".paperListDivContent").append('<span class="icon-spinner icon-spin" style="font-size: 30px;margin-left: 50%"></span>');
    // 3访问服务器
    requestSeverToGetPaperList();
}

/**
 * 点击刷新按钮
 * */
function dbPaperRefreshButtonClick(){
    $("#dbpaperContainer").find(".paperListDivContent").empty();
    $("#dbpaperContainer").find(".paperListDivContent").append('<span class="icon-spinner icon-spin" style="font-size: 30px;margin-left: 50%"></span>');
    // 3访问服务器
    requestSeverToGetPaperList();
}
/**
 * 给各个类挂载事件
 * 
 * */
function bindDbPaperCardEvent(){

    $("#dbpaperContainer").find(".paperCard").unbind('click');
    $("#dbpaperContainer").find(".paperCard").click(function(){
        //点击了下
         dbPaperCardClick($(this));


    })
	
	
}
function dbPaperCardClick(thisEle){
    swal({
        title : '提示',
        text : "确定删除该试卷吗?",
        type : 'info',
        showCancelButton : true,
        confirmButtonText : '是的',
        cancelButtonText : '取消',
    }).then(function(){
	    //这里访问服务器，
        requestToDeletePaper(parseInt( thisEle.find(".paperPidDiv").text()));
    },function(value){

    });


}
/**
 * 访问服务器获得dbpaperList
 *
 * */
function requestSeverToGetPaperList() {
    $.ajax({
        url : BasePath+"/getPaperNoUserDoneList",
        type : 'GET',
        dataType : "html",
        contentType : "application/json",
        async : false,
        success:function(data){
            //1.情况列表并且渲染数据
            clearDBpaperListAndAppend(data);
            //2.给card挂事件
            bindDbPaperCardEvent();

        },
        error:function(){
            swal("","网络错误，无法获得列表","error");
            $("#dbpaperContainer").find(".paperListDivContent").empty();

        },
        beforeSend:function(){
            $("#dbpaperContainer").find(".paperListDivContent").empty();
            $("#dbpaperContainer").find(".paperListDivContent").append('<span class="icon-spinner icon-spin" style="font-size: 30px;margin-left: 50%"></span>');


        }


    });
}
/**
 * 访问服务器去删除试卷
 *
 * */
function requestToDeletePaper(pid) {
    $.ajax({
        url : BasePath+"/deletePaper",
        type : 'POST',
        dataType : "json",
        data:{
            pid:pid,

        },
        async : false,
        success:function(data){
            if(data.result == "true " || data.result == true){
                swal("",data.des,"success");
                $("#getDbButton").click();//点击一下刷新按钮

            }else{
                swal("",data.des,"error");
            }

        },
        error:function(){
            swal("","网络错误，无法删除","error");


        }
    });
}