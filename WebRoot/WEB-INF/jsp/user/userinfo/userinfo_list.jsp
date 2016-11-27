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
			<form action="userinfo/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="KEYWORD" value="" placeholder="会员信息" style="width:150px;"/>
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="UID" value="" placeholder="UID" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;"> 
					 	<select class="chzn-select" name="STATUS" id="STATUS" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
							<option value=""></option>
							<option value="">全部</option>
							<option value="正常">正常</option>
							<option value="禁用">禁用</option>
					  	</select>
					</td>
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
						<th class="center">UID</th>
						<th class="center">推荐人UID</th>
						<th class="center">登陆名</th>
						<th class="center">会员状态</th>
						<th class="center">提现状态</th>
						<th class="center">提币状态</th>
						<th class="center">证件是否提交</th>
						<th class="center">证件是否审核</th>
						<th class="center">昵称</th>
						<th class="center">真实姓名</th>
						<th class="center">会员等级</th>
						<th class="center">手机激活状态</th>
						<th class="center">证件类型</th>
						<th class="center">证件号码</th>
						<th class="center">手机</th>
						<th class="center">商家号</th>
 						<th class="center">注册时间</th>
 						<th class="center">上次登陆时间</th>
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
									<label><input type='checkbox' name='ids' value="${var.USERINFO_ID}" /><span class="lbl"></span></label>
								</td>
										<td>${var.UID}</td>
										<td>${var.RECOMMENDEDUID}</td>
										<td>${var.LOGINNAME}</td>
										<td>${var.STATUS}</td>
										<td>${var.WITHDRAWALSTATUS}</td>
										<td>${var.MENTIONMONEYSTATUS}</td>
										<td>${var.ISCARDSUBMIT}</td>
										<td>${var.ISCARDAUDIT}</td>
										<td>${var.NICKNAME}</td>
										<td>${var.REALNAME}</td>
										<td>${var.MEMBERLEVEL}</td>
										<td>${var.MOBILESTATUS}</td>
										<td>${var.CARDTYPE}</td>
										<td>${var.CARDNUMBER}</td>
										<td>${var.MOBILE}</td>
										<td>${var.MERCHANTSID}</td>
										<td>${var.CREATEDATETIME}</td>
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
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
					<c:if test="${QX.edit == 1 }">
					<a class="btn btn-small btn-success" onclick="edit('确定要禁用吗?');">禁用</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要解除禁用吗?');">解除禁用</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要重设登陆密码吗?');">重设登陆密码</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要重设交易密码吗?');">重设交易密码</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要重置GOOGLE吗?');">重置GOOGLE</a>
					<a class="btn btn-small btn-success" onclick="edit('确定设置商家号吗?');">设置商家号</a>
					</c:if>
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
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="添加用户信息";
			 diag.URL = '<%=basePath%>userinfo/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function edit(msg){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else{
				  		bootbox.dialog("请选择一条记录进行操作!", 
								[
								  {
									"label" : "关闭",
									"class" : "btn-small btn-success",
									"callback": function() {
										
										}
									}
								 ]
							);
				  		return;
				  	}
				  }
			}
			if(str==''){
				bootbox.dialog("您没有选择任何内容!", 
					[
					  {
						"label" : "关闭",
						"class" : "btn-small btn-success",
						"callback": function() {
							//Example.show("great success");
							}
						}
					 ]
				);
				
				return;
			}else{
			
				if(msg == '确定要禁用吗?'){
					
					bootbox.confirm(msg, function(result) {
						if(result) {
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>userinfo/disable.do?tm='+new Date().getTime(),
						    	data: {USERINFO_ID:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
								 	});
									if(data.list[0].msg == "no" ){
										alert(data.list[0].result);
									}else {
										alert("禁用成功");
									}
								}
							});
						}
					});
				}else if(msg == '确定要解除禁用吗?'){
					
					bootbox.confirm(msg, function(result) {
						if(result) {
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>userinfo/usable.do?tm='+new Date().getTime(),
						    	data: {USERINFO_ID:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
								 	});
									if(data.list[0].msg == "no" ){
										alert(data.list[0].result);
									}else {
										alert("解除禁用成功");
									}
								}
							});
						}
					});
					
				}else if(msg == '确定要重设登陆密码吗?'){
					bootbox.confirm(msg, function(result) {
						if(result) {
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>loginmember/resetLoginPassword.do?tm='+new Date().getTime(),
						    	data: {USERINFO_ID:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
								 	});
									if(data.list[0].msg == "no" ){
										alert(data.list[0].result);
									}else {
										alert("重设登陆密码成功");
									}
								}
							});
						}
					});	
				}else if(msg == '确定要重设交易密码吗?'){
					bootbox.confirm(msg, function(result) {
						if(result) {
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>userinfo/resetTradePassword.do?tm='+new Date().getTime(),
						    	data: {USERINFO_ID:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
								 	});
									if(data.list[0].msg == "no" ){
										alert(data.list[0].result);
									}else {
										alert("重设交易密码成功");
									}
								}
							});
						}	
					});
					
				}else if(msg == '确定要重设GOOGLE认证吗?'){
					bootbox.confirm(msg, function(result) {
						if(result) {
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>userinfo/resetGoogleCheckCode.do?tm='+new Date().getTime(),
						    	data: {USERINFO_ID:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
								 	});
									if(data.list[0].msg == "no" ){
										alert(data.list[0].result);
									}else {
										alert("重设谷歌认证成功");
									}
								}
							});
						}
					});
				}else if(msg == '确定设置商家号吗?'){
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="设置商家号";
					 diag.URL = '<%=basePath%>userinfo/goMerchantsID.do?USERINFO_ID='+str;
					 diag.Width = 570;
					 diag.Height = 165;
					 diag.CancelEvent = function(){ //关闭事件
						 if(diag.innerFrame.contentWindow.document.getElementById('merchantsID').style.display == 'none'){
							 nextPage(${page.currentPage});
						}
						diag.close();
					 };
					 diag.show();
				}
			}
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
			window.location.href='<%=basePath%>userinfo/excel.do';
		}
		</script>
		
	</body>
</html>

