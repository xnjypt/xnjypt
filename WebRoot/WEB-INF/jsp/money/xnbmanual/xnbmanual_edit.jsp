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
		if($("#LOGINNAME").val()==""){
			$("#LOGINNAME").tips({
				side:3,
	            msg:'请输入登录名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LOGINNAME").focus();
			return false;
		}
		if($("#XNBTYPE").val()==""){
			$("#XNBTYPE").tips({
				side:3,
	            msg:'请输入虚拟币类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#XNBTYPE").focus();
			return false;
		}
		var NUM = $("#NUM").val();
		if(NUM==""){
			$("#NUM").tips({
				side:3,
	            msg:'请输入数量',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NUM").focus();
			return false;
		}else if(isNaN(NUM) || NUM<=0){
			$("#NUM").tips({
				side:3,
	            msg:'请输入大于0的数量',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NUM").focus();
			return false;
		}
		if($("#SENDMESSAGE").val()==""){
			$("#SENDMESSAGE").tips({
				side:3,
	            msg:'请输入是否发送消息',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SENDMESSAGE").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="xnbmanual/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="XNBMANUAL_ID" id="XNBMANUAL_ID" value="${pd.XNBMANUAL_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">登录名:</td>
				<td><input type="text" name="LOGINNAME" id="LOGINNAME" value="${pd.LOGINNAME}" maxlength="32" placeholder="这里输入登录名" title="登录名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">虚拟币类型:</td>
				<td > 
				 	<select name="XNBTYPE" id="XNBTYPE" data-placeholder="虚拟币类型" >
				  	</select>	
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">数量:</td>
				<td><input type="number" name="NUM" id="NUM" value="${pd.NUM}" maxlength="32" placeholder="这里输入数量" title="数量"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">是否发送消息:</td>
				<td><input type="text" name="SENDMESSAGE" id="SENDMESSAGE" value="${pd.SENDMESSAGE}" maxlength="32" placeholder="这里输入是否发送消息" title="是否发送消息"/></td>
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
			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>vmtype/typeList.do',
				dataType:'json',
				cache: false,
				success: function(data){
					console.info(data.list);
					$.each(data.list, function (i, item) { 
						$("#XNBTYPE").append("<option value='"+ item.VMTYPE_ID+"'>"+ item.JTTYPENAME+"</option>"); 
					}); 
				}
			});
			
		});
		
		</script>
</body>
</html>