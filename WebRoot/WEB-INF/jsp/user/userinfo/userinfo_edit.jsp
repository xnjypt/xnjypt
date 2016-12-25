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
		if($("#mobile_font").is(":hidden")){
			//邮箱注册
			if($("#EMAIL").val()==""){
				$("#EMAIL").tips({
					side:3,
		            msg:'请输入邮箱',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMAIL").focus();
				return false;
			}
			
			if(!checkEmail($("#EMAIL").val())){
				$("#EMAIL").tips({
					side:3,
		            msg:'请输入正确邮箱',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMAIL").focus();
				return false;
			}
			
			if($("#MOBILE").val()!=""){
				if(!checkMobile($("#MOBILE").val())){
					$("#MOBILE").tips({
						side:3,
			            msg:'请输入正确手机号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#MOBILE").focus();
					return false;
				}
			}
		}else {
			//手机注册
			if($("#MOBILE").val()==""){
				$("#MOBILE").tips({
					side:3,
		            msg:'请输入手机',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MOBILE").focus();
				return false;
			}
			
			if(!checkMobile($("#MOBILE").val())){
				$("#MOBILE").tips({
					side:3,
		            msg:'请输入正确手机号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MOBILE").focus();
				return false;
			}
			
			if($("#EMAIL").val()!=""){
				if(!checkEmail($("#EMAIL").val())){
					$("#EMAIL").tips({
						side:3,
			            msg:'请输入正确邮箱',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#EMAIL").focus();
					return false;
				}
			}
		}
		
		if($("#PASSWORD").val()==""){
			$("#PASSWORD").tips({
				side:3,
	            msg:'请输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PASSWORD").focus();
			return false;
		}
		if($("#PASSWORD").val().length < 6){
			$("#PASSWORD").tips({
				side:3,
	            msg:'长度介于 6 和 20 之间的字符',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PASSWORD").focus();
			return false;
		}
		
		$.ajax({
			type: "POST",
			url: '<%=basePath%>userinfo/${msg }.do?tm='+new Date().getTime(),
	    	data: $("#Form").serialize(),
			dataType:'json',
			cache: false,
			success: function(data){
				if(data.list[0].msg == "no" ){
					alert(data.list[0].result);
				}else {
					$("#zhongxin").hide();
					top.Dialog.close();
				}
			}
		});
	}
	
	function checkMobile(mobile) {
	    filter = /^1[3|4|5|8|7][0-9]\d{8}$/;
	    if (!filter.test(mobile)) {
	        return false;
	    } else {
	        return true;
	    }
	}
	function checkEmail(email) {
	    filter = /^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    if (!filter.test(email)) {
	        return false;
	    } else {
	        return true;
	    }
	}
	
</script>
	</head>
<body>
	<form action="userinfo/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="USERINFO_ID" id="USERINFO_ID" value="${pd.USERINFO_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">登录名选择:</td>
  				<td><select name="TYPE" id="type" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
							<option value="mobile">手机</option>
							<option value="email">邮箱</option>
					  	</select></td>	
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">手机区号:</td>
				<td><select name="LOCATION" id="LOCATION" data-placeholder="请选择" style="vertical-align:top;width: 200px;">
						<option value="86">中国大陆(China)</option>
						<option value="852">中国香港(Hongkong)</option>
						<option value="853">中国澳门(Macao)</option>
						<option value="886">台湾(Taiwan)</option>
						<option value="60">马来西亚(Malaysia)</option>
						<option value="65">新加坡(Singapore)</option>
						<option value="66">泰国(Thailand)</option>
						<option value="55">巴西(Brazil)</option>
						<option value="61">澳大利亚(Australia)</option>
						<option value="1">加拿大(Canada)</option>
						<option value="1">美国(America)</option>
						<option value="44">英国(United Kingdom)</option>
						<option value="49">德国(Germany)</option>
						<option value="33">法国(France)</option>
						<option value="31">荷兰(Netherlands)</option>
						<option value="81">日本(Japan)</option>
						<option value="82">韩国(Korea)</option>
					  	</select></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">手机:</td>
				<td><input type="text" name="MOBILE" id="MOBILE" value="${pd.MOBILE}" maxlength="32" placeholder="这里输入手机" title="手机"/>
					<font id="mobile_font" style="color:red">*</font></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">邮箱:</td>
				<td><input type="text" name="EMAIL" id="EMAIL" value="${pd.EMAIL}" maxlength="32" placeholder="这里输入邮箱" title="邮箱"/>
					<font id="email_font" style="color:red">*</font></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">密码:</td>
				<td><input type="password" name="PASSWORD" id="PASSWORD" value="${pd.PASSWORD}" maxlength="32" placeholder="这里输入密码" title="密码"/></td>
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
			$('#email_font').hide();
			
			$('#type').change(function(){
				if($(this).val() == 'mobile'){
					$('#mobile_font').show();
					$('#email_font').hide();
				}else if($(this).val() == 'email'){
					$('#mobile_font').hide();
					$('#email_font').show();
				}
			});
		});
		
		</script>
</body>
</html>