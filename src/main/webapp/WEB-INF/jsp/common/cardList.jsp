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
						<div class="col-md-1 paperPidDiv">${paper.getPid()}</div>
						<div class="col-md-1">
							<span class="fui-calendar"></span>
						</div>
						<div class="col-md-7">
							<div class="row paperTitle">${paper.getPname()}</div>
							<div class="row paperDate">${paper.getPdate().toString()}</div>
						</div>
						<div class="col-md-2">
							<div class="row paperUserName">${paper.getUserName()}</div>
						</div>
						<div class="col-md-1">
							<div class="row paperScore">${paper.getScore()}分</div>
						</div>
					</div>
						
						   
</c:forEach>