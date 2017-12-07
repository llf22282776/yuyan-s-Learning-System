<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:forEach 
							var="paper" 
							items="${paperList}" 
							varStatus="status"
							
						>
						<div class="paperCard row">
						<div class="col-xs-1 paperPidDiv">${paper.getPid()}</div>
						<div class="col-xs-1">
							<span class="fui-calendar"></span>
						</div>
						<div class="col-xs-7">
							<div class="row paperTitle">${paper.getPname()}</div>
							<div class="row paperDate">${paper.getPdate().toString()}</div>
						</div>
						<div class="col-xs-2">
							<div class="row paperUserName">${paper.getUserName()}</div>
						</div>
						<div class="col-xs-1">
							<div class="row paperScore">${paper.getScore()}分</div>
						</div>
					</div>
						
						   
</c:forEach>
	<c:if test="${allPage !=null && allPage >=1}">
		<ul class="pagination">
			<li class="previous"><a   class="qPageItem qPagePre fui-arrow-left"></a></li>
			<!--中间这里展示-->
			<c:forEach
					begin="0"
					end="${allPage-1}"
					varStatus="status"
			>
				<c:choose>
					<c:when test="${page == status.index+1}">
						<!--需要设置active-->
						<li class="active nowActive"><a class=" qPageItem" date="${paperState.date}" title="${paperState.title}" allPage="${allPage}" page="${status.index +1}" >${status.index +1}</a></li>
					</c:when>
					<c:otherwise>
						<li><a class="qPageItem" date="${paperState.date}" title="${paperState.title}" allPage="${allPage}" page="${status.index +1}" >${status.index +1}</a></li>

					</c:otherwise>
				</c:choose>

			</c:forEach>
			<li class="next"><a  class="qPageItem qPageNext fui-arrow-right"></a></li>
		</ul>
	</c:if>



