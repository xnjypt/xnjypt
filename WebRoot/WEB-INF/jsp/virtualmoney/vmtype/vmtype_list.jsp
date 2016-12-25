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
			<form action="vmtype/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" style="width:300px" type="text" name="KEYWORD" value="" placeholder="名称、简称、描述" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
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
						<th class="center">名称</th>
						<th class="center">简称</th>
						<th class="center">简体类型名称</th>
						<th class="center">繁体类型名称</th>
						<th class="center">英语类型名称</th>
						<th class="center">状态</th>
						<th class="center">符号</th>
						<th class="center">ip</th>
						<th class="center">端口</th>
						<th class="center">是否可以交易</th>
						<th class="center">是否可以提现</th>
						<th class="center">是否停盘</th>
						<th class="center">开盘时间</th>
						<th class="center">停盘时间</th>
						<th class="center">创建时间</th>
						<th class="center">介绍</th>
						<th class="center">描述</th>
						<th class="center">logo</th>
						<!-- <th class="center">操作</th> -->
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
									<label><input type='checkbox' name='ids' value="${var.VMTYPE_ID}" /><span class="lbl"></span></label>
								</td>
								<%-- <td class='center' style="width: 30px;">${vs.index+1}</td> --%>
										
										<td>${var.SEQ}</td>
										<td>${var.NAME}</td>
										<td>${var.SHORTNAME}</td>
										<td>${var.JTTYPENAME}</td>
										<td>${var.FTTYPENAME}</td>
										<td>${var.ENTYPENAME}</td>
										<td>${var.STATUS}</td>
										<td>${var.SYMBOL}</td>
										<td>${var.IP}</td>
										
										<td>${var.PORT}</td>
										<td>${var.ISTRADING}</td>
										<td>${var.ISWITHDRAWAL}</td>
										<td>${var.ISUSPENDED}</td>
										<td>${var.OPENDATETIME}</td>
										<td>${var.CLOSEDATETIME}</td>
										<td>${var.CREATEDATETIME}</td>
										<td>${var.INTRODUCTION}</td>
										<td>${var.DESCRIPTION}</td>
										<td>${var.LOGO}</td>
								<%-- <td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
									
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.VMTYPE_ID}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
											</c:if>
										</ul>
										</div>
									</div>
								</td> --%>
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
					<a class="btn btn-small btn-success" onclick="edit('确定要启动吗?');">启动</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要修改吗?');">修改</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要修改手续费吗?');">修改手续费</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要测试钱包吗?');">测试钱包</a>
					<a class="btn btn-small btn-success" onclick="edit('生成钱包地址?');">生成钱包地址</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要停盘吗?');">停盘</a>
					<a class="btn btn-small btn-success" onclick="edit('确定要开盘吗?');">开盘</a>
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
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>vmtype/goAdd.do';
			 diag.Width = 570;
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
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>vmtype/goEdit.do?VMTYPE_ID='+Id;
			 diag.Width = 570;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
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
			
				if(msg == '确定要停盘吗?'){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>vmtype/stop.do?tm='+new Date().getTime(),
				    	data: {VMTYPE_ID:str},
						dataType:'json',
						cache: false,
						success: function(data){
							$.each(data.list, function(i, list){
								nextPage(${page.currentPage});
						 	});
							if(data.list[0].msg == "no" ){
								alert(data.list[0].result);
							}else {
								alert("停盘成功");
							}
						}
					});
				}else if(msg == '确定要开盘吗?'){
					
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>vmtype/start.do?tm='+new Date().getTime(),
				    	data: {VMTYPE_ID:str},
						dataType:'json',
						cache: false,
						success: function(data){
							$.each(data.list, function(i, list){
								nextPage(${page.currentPage});
						 	});
							if(data.list[0].msg == "no" ){
								alert(data.list[0].result);
							}else {
								alert("开盘成功");
							}
						}
					});
				}else if(msg == '确定要禁用吗?'){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>vmtype/disable.do?tm='+new Date().getTime(),
				    	data: {VMTYPE_ID:str},
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
				}else if(msg == '确定要审核吗?'){
					top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="审核人民币提现<font style='color:red'>(此过程不可逆,请谨慎操作)</font>";
					 diag.URL = '<%=basePath%>vmtype/goEdit.do?VMTYPE_ID='+str;
					 diag.Width = 450;
					 diag.Height = 355;
					 diag.CancelEvent = function(){ //关闭事件
						 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							 nextPage(${page.currentPage});
						}
						diag.close();
					 };
					 diag.show();
				}else if(msg == '确定要修改吗?'){
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="编辑";
					 diag.URL = '<%=basePath%>vmtype/goEdit.do?VMTYPE_ID='+str;
					 diag.Width = 570;
					 diag.Height = 355;
					 diag.CancelEvent = function(){ //关闭事件
						 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							 nextPage(${page.currentPage});
						}
						diag.close();
					 };
					 diag.show();
				}else if(msg == '确定要修改手续费吗?'){
					 top.jzts();
					 var diag2 = new top.Dialog();
					 diag2.Drag=true;
					 diag2.Title ="修改手续费信息";
					 diag2.URL = '<%=basePath%>vmtype/goChargeFee.do?VMTYPE_ID='+str;
					 diag2.Width = 570;
					 diag2.Height = 355;
					 diag2.CancelEvent = function(){ //关闭事件
						 if(diag2.innerFrame.contentWindow.document.getElementById('chargeFee').style.display == 'none'){
							 nextPage(${page.currentPage});
						}
						diag2.close();
					 };
					 diag2.show();
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
			window.location.href='<%=basePath%>vmtype/excel.do';
		}
		</script>
		
	</body>
</html>

