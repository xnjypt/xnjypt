<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	</head>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="rmboperationrecord/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" style="width:300px" type="text" name="KEYWORD" value="" placeholder="会员名称、手机、银行帐户、金额、收款人" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="PRICE" value="" placeholder="充值ID" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;"> 
					 	<select class="chzn-select"  style="width:200px" name="TRADINGTYPE" id="TRADINGTYPE" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
							<option value="">全部</option>
							<option value="充值-3">充值-已经到账</option>
							<option value="充值-4">充值-用户撤销</option>
							<option value="充值-1">充值-尚未付款</option>
							<option value="充值-2">充值-等待银行到账</option>
							<option value="环迅充值-3">环迅充值-已经到账</option>
							<option value="环迅充值-4">环迅充值-用户撤销</option>
							<option value="环迅充值-1">环迅充值-尚未付款</option>
							<option value="环迅充值-2">环迅充值-等待银行到账</option>
							<option value="提现-4">提现-用户撤销</option>
							<option value="提现-2">提现-正在处理</option>
							<option value="提现-3">提现-提现成功</option>
							<option value="提现-1">提现-等待提现</option>
					  	</select>
					</td>
					<td><input class="span10 date-picker" name="CREATEDATETIME" id="lastLoginStart" value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="日期"/></td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
					</c:if>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">登录名</th>
						<th class="center">会员昵称</th>
						<th class="center">会员真实姓名</th>
						<th class="center">收款银行</th>
						<th class="center">银行账户</th>
						<th class="center">交易类型</th>
						<th class="center">状态</th>
						<th class="center">金额</th>
						<th class="center">手续费</th>
						<th class="center">描述</th>
						<th class="center">开户行地址</th>
						<th class="center">创建时间</th>
						<th class="center">修改时间</th>
						<th class="center">审核人</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.RMBOPERATIONRECORD_ID}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td>${var.LOGINNAME}</td>
										<td>${var.USERNICKNAME}</td>
										<td>${var.USERREALNAME}</td>
										<td>${var.COLLECTIONBANK}</td>
										<td>${var.BANKACCOUNT}</td>
										<td>${var.TRADINGTYPE}</td>
										<td>${var.STATUS}</td>
										<td>${var.MONEY}</td>
										<td>${var.POUNDAGE}</td>
										<td>${var.DISCRIPTION}</td>
										<td>${var.BANKADDRESS}</td>
										<td>${var.CREATEDATETIME}</td>
										<td>${var.UPDATEDATETIME}</td>
										<td>${var.AUDITPEOPLE}</td>
							</tr>
						
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
					
				
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>rmboperationrecord/excel.do';
		}
		</script>
		
	</body>
</html>

