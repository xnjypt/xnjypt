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
	//修改手续费页面
	var checkMoney = /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)|(0))$/;
	
	//保存
	function save(){
		
		if($("#LEVEL1C").val()==""){
			$("#LEVEL1C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL1C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL1C").val())){
			$("#LEVEL1C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL1C").focus();
			return false;
		}
		if($("#LEVEL1T").val()==""){
			$("#LEVEL1T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL1T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL1T").val())){
			$("#LEVEL1T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL1T").focus();
			return false;
		}
		
		if($("#LEVEL2C").val()==""){
			$("#LEVEL2C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL2C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL2C").val())){
			$("#LEVEL2C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL2C").focus();
			return false;
		}
		if($("#LEVEL2T").val()==""){
			$("#LEVEL2T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL2T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL2T").val())){
			$("#LEVEL2T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL2T").focus();
			return false;
		}
		
		if($("#LEVEL3C").val()==""){
			$("#LEVEL3C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL3C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL3C").val())){
			$("#LEVEL3C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL3C").focus();
			return false;
		}
		if($("#LEVEL3T").val()==""){
			$("#LEVEL3T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL3T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL3T").val())){
			$("#LEVEL3T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL3T").focus();
			return false;
		}
		
		if($("#LEVEL4C").val()==""){
			$("#LEVEL4C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL4C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL4C").val())){
			$("#LEVEL4C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL4C").focus();
			return false;
		}
		if($("#LEVEL4T").val()==""){
			$("#LEVEL4T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL4T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL4T").val())){
			$("#LEVEL4T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL4T").focus();
			return false;
		}
		
		if($("#LEVEL5C").val()==""){
			$("#LEVEL5C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL5C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL5C").val())){
			$("#LEVEL5C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL5C").focus();
			return false;
		}
		if($("#LEVEL5T").val()==""){
			$("#LEVEL5T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL5T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL5T").val())){
			$("#LEVEL5T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL5T").focus();
			return false;
		}
		
		if($("#LEVEL6C").val()==""){
			$("#LEVEL6C").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL6C").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL6C").val())){
			$("#LEVEL6C").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL6C").focus();
			return false;
		}
		if($("#LEVEL6T").val()==""){
			$("#LEVEL6T").tips({
				side:3,
	            msg:'必填字段',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL6T").focus();
			return false;
		}
		if(!checkMoney.test($("#LEVEL6T").val())){
			$("#LEVEL6T").tips({
				side:3,
	            msg:'请输入合法的数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEVEL6T").focus();
			return false;
		}
		
		
		$("#Form").submit();
		$("#chargeFee").hide();
		$("#chargeFee2").show();
	}
	
</script>
	</head>
<body>
	<form action="vmtype/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="VMTYPE_ID" id="VMTYPE_ID" value="${pd.VMTYPE_ID}"/>
		<div id="chargeFee">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 1 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL1C" id="LEVEL1C" value="${pd.LEVEL1C}" maxlength="32" placeholder="这里输入等级[ 1 ]交易手续费" title="等级[ 1 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 1 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL1T" id="LEVEL1T" value="${pd.LEVEL1T}" maxlength="32" placeholder="这里输入等级[ 1 ]提现手续费" title="等级[ 1 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 2 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL2C" id="LEVEL2C" value="${pd.LEVEL2C}" maxlength="32" placeholder="这里输入等级[ 2 ]交易手续费" title="等级[ 2 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 2 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL2T" id="LEVEL2T" value="${pd.LEVEL2T}" maxlength="32" placeholder="这里输入等级[ 2 ]提现手续费" title="等级[ 2 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 3 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL3C" id="LEVEL3C" value="${pd.LEVEL3C}" maxlength="32" placeholder="这里输入等级[ 3 ]交易手续费" title="等级[ 3 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 3 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL3T" id="LEVEL3T" value="${pd.LEVEL3T}" maxlength="32" placeholder="这里输入等级[ 3 ]提现手续费" title="等级[ 3 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 4 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL4C" id="LEVEL4C" value="${pd.LEVEL4C}" maxlength="32" placeholder="这里输入等级[ 4 ]交易手续费" title="等级[ 4 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 4 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL4T" id="LEVEL4T" value="${pd.LEVEL4T}" maxlength="32" placeholder="这里输入等级[ 4 ]提现手续费" title="等级[ 4 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 5 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL5C" id="LEVEL5C" value="${pd.LEVEL5C}" maxlength="32" placeholder="这里输入等级[ 5 ]交易手续费" title="等级[ 5 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 5 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL5T" id="LEVEL5T" value="${pd.LEVEL5T}" maxlength="32" placeholder="这里输入等级[ 5 ]提现手续费" title="等级[ 5 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 6 ]交易手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL6C" id="LEVEL6C" value="${pd.LEVEL6C}" maxlength="32" placeholder="这里输入等级[ 6 ]交易手续费" title="等级[ 6 ]交易手续费"/></td>
			</tr>
			<tr>
				<td style="width:250px;text-align: right;padding-top: 13px;">等级[ 6 ]提现手续费:</td>
				<td><input type="text" style="width:350px;" name="LEVEL6T" id="LEVEL6T" value="${pd.LEVEL6T}" maxlength="32" placeholder="这里输入等级[ 6 ]提现手续费" title="等级[ 6 ]提现手续费"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="chargeFee2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
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