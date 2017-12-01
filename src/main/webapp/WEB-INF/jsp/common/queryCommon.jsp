
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="queryContainer">
	<div class="row queryHeaderRow">

		<div class="row">
			<div class="col-sm-3"></div>
			<div class="queryDatePickerDiv col-sm-1 ">
				<a id="queryDatePicker"><span id="" class="fui-calendar-solid"></span></a>
				<input id="queryDatePickerInput" value=""
					data-date-format="yyyy-mm-dd" />
			</div>
			<div class="col-sm-3 queryInputDiv">
				<div class="form-group has-feedback">
					<input id="queryInput" type="text" value=""
						placeholder="输入试卷标题，全部或部分" class="form-control queryInput" /> <span
						class="form-control-feedback fui-new"></span>
				</div>
			</div>

			<div class="col-sm-1">
				<a id="querySubmitButton"><span class="fui-search"></span></a>
			</div>
		</div>




	</div>

	<div class="paperListDivContent row pbl">
		<!--这里放置card卡片-->



	</div>

</div>