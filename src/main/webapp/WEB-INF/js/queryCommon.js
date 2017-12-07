/**
 * 
 */


var queryState={
		date:"",
        title:"",
        page:""
		
		
		
};
(function($){
	$.fn.datetimepicker.dates['zh-CN'] = {
			days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
			daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
			daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
			months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			today: "今天",
			suffix: [],
			meridiem: ["上午", "下午"]
	};
}(jQuery));

//添加事件了

$("#querySubmitButton").click(function(){
    submitClick($(this));


});

$("#queryDatePicker").click(function(){
    datePickClickEvent($(this));


})
$('#queryDatePicker').datetimepicker({
	format:'yyyy-mm-dd',
	minView:3,
	language:'zh-CN'
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
        	//3.清理查询条件
            clearQueryState();
        },
        error:function(){
        	swal("","网络错误，无法获得列表","error");
        	
        	
        },
        beforeSend:function(){
            $("#queryContainer").find(".paperListDivContent").empty();
            $("#queryContainer").find(".paperListDivContent").append('<span class="icon-spinner icon-spin" style="font-size: 30px;margin-left: 50%"></span>');


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
 * 清理查询条件
 *
 * */
function clearQueryState(){
    queryState={
        date:"",
        title:"",
        page:""



    };

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
	//现在要绑定翻页事件
	if($("#queryContainer").find(".pagination").length>0){
        //有翻页的组件
        $("#queryContainer").find(".pagination").find(".qPageItem").unbind('click');
        $("#queryContainer").find(".pagination").find(".qPageItem").click(function(){
             if( pageItemClick($(this))){
                 $("#querySubmitButton").click();
             }
        })


    }
}

/**
 * 翻页选项被单击事件
 *
 * */
function pageItemClick(thisEle){
    //如果是前翻页和后翻页
    if(thisEle.hasClass("qPagePre")){
        //如果现在的页数就是1，返回就行
        var aEle=thisEle.closest("ul").find("li.nowActive").eq(0).find("a").eq(0);
        if(parseInt(aEle.attr("page")) <= 1){
            return false;
        }else {
            queryState.date = aEle.attr("date");
            queryState.title=aEle.attr("title");
            queryState.page=parseInt(aEle.attr("page"))-1;

        }

    }else if(thisEle.hasClass("qPageNext")){
        //后翻页
        var aEle=thisEle.closest("ul").find("li.nowActive").eq(0).find("a").eq(0);
        if(parseInt(aEle.attr("page")) >= parseInt(aEle.attr("allPage"))){
            return false;
        }else {
            queryState.date = aEle.attr("date");
            queryState.title=aEle.attr("title");
            queryState.page=parseInt(aEle.attr("page"))+1;



        }

    }else if(thisEle.closest("li").hasClass("nowActive")){
        //本也直接返回
            return false;
    }else {
        //其他页面
        queryState.date = thisEle.attr("date");
        queryState.title=thisEle.attr("title");
        queryState.page=parseInt(thisEle.attr("page"));


    }
    //点击下查询按钮
    return true;
    
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

    	$('.tempA').remove();
    	var url=BasePath+"/checkPaperDetail?"+"pid="+thisEle.find(".paperPidDiv").text();
		var tempA=$("<a style='display:none' class='tempA' target='_blank' href='"+url+"' >asd<a/>");
		$('body').append(tempA);
		$('.tempA')[0].click();
		$('.tempA').remove();
    },function(value){

    });


}



