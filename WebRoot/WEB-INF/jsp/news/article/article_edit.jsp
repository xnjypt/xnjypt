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
		    <script type="text/javascript" charset="utf-8" src="static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="static/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="static/ueditor/lang/zh-cn/zh-cn.js"></script>
		
<script type="text/javascript">
	
	
	//保存
	function save(){

		if($("#TYPEID").val()==""){
			$("#TYPEID").tips({
				side:3,
	            msg:'请输入文章类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TYPEID").focus();
			return false;
		}
		if($("#TITLE").val()==""){
			$("#TITLE").tips({
				side:3,
	            msg:'请输入标题',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TITLE").focus();
			return false;
		}


		if($("#KEYWORD").val()==""){
			$("#KEYWORD").tips({
				side:3,
	            msg:'请输入关键字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#KEYWORD").focus();
			return false;
		}

		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
<script type="text/javascript" charset="UTF-8">
var ue = UE.getEditor('editor');
	
</script>
	</head>
<body>
	<form action="article/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="ARTICLE_ID" id="ARTICLE_ID" value="${pd.ARTICLE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">

			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">文章类型:</td>
				
				<td>
				<select name="TYPEID" id="TYPEID"  placeholder="这里输入文章类型" title="文章类型">
					<c:forEach items="${typeList}" var="item">
						<option value="${item.ARTICLETYPE_ID}">${item.TYPENAME}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">标题:</td>
				<td><input type="text" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="32" placeholder="这里输入标题" title="标题"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">关键字:</td>
				<td><input type="text" name="KEYWORD" id="KEYWORD" value="${pd.KEYWORD}" maxlength="32" placeholder="这里输入关键字" title="关键字"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">内容:</td>
				<td><script  name="CONTENT"  id="editor" type="text/plain" style="width:800px;height:400px;">${pd.CONTENT}</script></td>
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