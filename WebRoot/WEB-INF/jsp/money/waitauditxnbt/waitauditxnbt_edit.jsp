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
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	
	//保存
	function save(){
		if($("#PURSEPASSWORD").val()==""){
			$("#PURSEPASSWORD").tips({
				side:3,
	            msg:'请输入钱包密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PURSEPASSWORD").focus();
			return false;
		}
		
		var status = $("#STATUS").val();
		if(status == "正在处理"){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>waitauditxnbt/audit.do?tm='+new Date().getTime(),
		    	data: $("#Form").serialize(),
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.list[0].msg == "no" ){
						alert(data.list[0].result);
					}else {
						alert("审核成功");
						$("#zhongxin").hide();
						top.Dialog.close();
						//$("#zhongxin2").show();
					}
				}
			});
		}else {
			alert("审核失败,只有状态为:‘正在处理’的提现记录才允许审核!");
		}
		
		//$("#Form").submit();
		
		
	}
	
</script>
	</head>
<body>
	<form action="waitauditxnbt/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="WAITAUDITXNBT_ID" id="WAITAUDITXNBT_ID" value="${pd.WAITAUDITXNBT_ID}"/>
		<input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">钱包密码:</td>
				<td><input type="password" name="PURSEPASSWORD" id="PURSEPASSWORD" value="${pd.PURSEPASSWORD}" maxlength="32" placeholder="这里输入钱包密码" title="钱包密码"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">登录名:</td>
				<td><input disabled="true" type="text" name="LOGINNAME" id="LOGINNAME" value="${pd.LOGINNAME}" maxlength="32" placeholder="这里输入登录名" title="登录名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">虚拟币类型:</td>
				<td><input disabled="true" type="text" name="XNBTYPE" id="XNBTYPE" value="${pd.XNBTYPE}" maxlength="32" placeholder="这里输入虚拟币类型" title="虚拟币类型"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">提现数量:</td>
				<td><input disabled="true" type="text" name="NUM" id="NUM" value="${pd.NUM}" maxlength="32" placeholder="这里输入提现数量" title="提现数量"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">提现手续费:</td>
				<td><input disabled="true" type="text" name="POUNDAGE" id="POUNDAGE" value="${pd.POUNDAGE}" maxlength="32" placeholder="这里输入提现手续费" title="提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">提现地址:</td>
				<td><input disabled="true" type="text" name="WITHDRAWALADDRESS" id="WITHDRAWALADDRESS" value="${pd.WITHDRAWALADDRESS}" maxlength="32" placeholder="这里输入提现地址" title="提现地址"/></td>
			</tr>
		
		
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>