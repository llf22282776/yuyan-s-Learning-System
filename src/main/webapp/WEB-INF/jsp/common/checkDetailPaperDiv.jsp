<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="paperTotalDiv buttomLineDiv" >

	<div class="paperUserTotalView">

		<div class="nameArea area">
			<div class="row headerRow">
				<div class="col-xs-4">姓名:</div>
				<div class="col-xs-8">
							<c:choose>
								<c:when test="${user.getPosition() == 0}">
									<!-- 学生 -->
									${user.getUname()}
								</c:when>
								<c:otherwise>
									<!-- 老师 -->
									<select data-toggle="select" class="form-control userSelecter select select-default select-sm mrs">
										<c:forEach var="usr" items="${users}" varStatus="status">
											<c:choose>
												<c:when test="${status.index == 0}">
													<option value="${status.index}" selected='selected'>${usr.getUname()}</option>

												</c:when>
												<c:otherwise>


													<option value="${status.index}">${usr.getUname()}</option>
												</c:otherwise>

											</c:choose>


										</c:forEach>
									</select>
								</c:otherwise>

							</c:choose>
				</div>
			</div>
			<div class="row scoreRow">
				<div class="col-xs-4">
					<span class="fui-document scoreIcon"></span>
				</div>
				<div class="col-xs-8">
					<div class="scoreText textArea">95</div>
					分
				</div>
			</div>
			<div class="row timeRow">
				<div class="col-xs-4">
					<span class="fui-time scoreIcon"></span>
				</div>
				<div class="col-xs-8">1分30秒</div>
			</div>
		</div>
		<div class="rankArea area">
			<div class="row headerRow">
				<span class="fui-user"></span>
			</div>
			<div class="row scoreRow">
				第
				<div class="textArea">1</div>
				名
			</div>
			<div class="row timeRow">
				第
				<div class="textArea">1</div>
				名
			</div>

		</div>
		<div class="skillArea paperTotalView area">
			<div id="paperScoreCharts" class="paperCharts chartsCol"></div>
		</div>
	</div>


</div>