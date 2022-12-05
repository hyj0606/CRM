<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>"><%--根路径--%>
	<meta charset="UTF-8">

	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">

	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<!--  PAGINATION plugin -->
	<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>

	<script type="text/javascript">

		$(function(){
			//当市场活动主页面加载完成,查询所有数据的第一页已经所有数据的总条数;
			queryCustomerByPage(1,5);

			//给查询按钮添加单击事件
			$("#queryCustomerBtn").click(function (){
				//查询所有符合条件数据的第一页以及所有符合条件数据的总数;
				queryCustomerByPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
			});

		});

		//封装函数
		function queryCustomerByPage(pageNo,pageSize){
			//收集参数
			var type = $("#query-type").val();
			var status = $("#query-status").val();
			$.ajax({
				url:'workbench/main/queryCustomerByPage.do',
				data:{
					type:type,
					status:status,
					pageNo:pageNo,
					pageSize:pageSize
				},
				type:'post',
				dataType:'json',
				success:function (data){
					//显示市场活动
					//遍历activityList,拼接所有行数据
					var htmlStr="";
					$.each(data.customerList,function (index,obj){
						htmlStr+="<tr class=\"active\">";
						htmlStr+="<td>"+obj.custName+"</td>";
						htmlStr+="<td>"+obj.user.username+"</td>";
						if (obj.custType==1){
							htmlStr+="<td>传统</td>";
						}
						if (obj.custType==2){
							htmlStr+="<td>互联网</td>";
						}
						htmlStr+="<td>"+obj.telphone+"</td>";
						htmlStr+="<td>"+obj.netAddress+"</td>";
						htmlStr+="<td>"+obj.address+"</td>";
						if (obj.custStatus==1){
							htmlStr+="<td>待沟通</td>";
						}
						if (obj.custStatus==2){
							htmlStr+="<td>新客户</td>";
						}
						if (obj.custStatus==3){
							htmlStr+="<td>老客户</td>";
						}
						if (obj.custStatus==4){
							htmlStr+="<td>无效客户</td>";
						}
						htmlStr+="</tr>";
					});
					$("#tBody").html(htmlStr);

					//计算总页数
					var totalPages = 1;
					if (data.count%pageSize==0){
						totalPages=data.count/pageSize;
					}else {
						totalPages=parseInt(data.count/pageSize)+1;
					}


					//对容器调用bs_pagination工具函数,显示翻页信息
					$("#demo_pag1").bs_pagination({
						currentPage:pageNo,//当前页号,相当于pageNo

						rowsPerPage:pageSize,//每页显示条数,相当于pageSize
						totalRows:data.count,//总条数
						totalPages: totalPages,  //总页数,必填参数.

						visiblePageLinks:5,//最多可以显示的卡片数

						showGoToPage:true,//是否显示"跳转到"部分,默认true--显示
						showRowsPerPage:true,//是否显示"每页显示条数"部分。默认true--显示
						showRowsInfo:true,//是否显示记录的信息，默认true--显示

						//用户每次切换页号，都自动触发本函数;
						//每次返回切换页号之后的pageNo和pageSize
						onChangePage: function(event,pageObj) { // returns page_num and rows_per_page after a link has clicked
							queryCustomerByPage(pageObj.currentPage,pageObj.rowsPerPage);
						}
					});
				}
			});
		}

	</script>
</head>
<body>

<div>
	<div style="position: relative; left: 10px; top: -10px;">
		<div class="page-header">
			<h3>首页</h3>
		</div>
	</div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

		<%--查询条件--%>
		<div class="btn-toolbar" role="toolbar" style="height: 80px;">
			<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">类别</div>
						<select class="form-control" id="query-type">
							<option value=""></option>
							<option value="1">传统</option>
							<option value="2">互联网</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">状态</div>
						<select class="form-control" id="query-status">
							<option value=""></option>
							<option value="1">待沟通</option>
							<option value="2">新客户</option>
							<option value="3">老客户</option>
							<option value="4">无效客户</option>
						</select>
					</div>
				</div>
				<button type="button" class="btn btn-default" id="queryCustomerBtn">查询</button>
			</form>
		</div>
		<div style="position: relative;top: 10px;">
			<table class="table table-hover">
				<thead>
				<tr style="color: #3C3C3C;">
					<td>客户名称</td>
					<td>客户经理</td>
					<td>类别</td>
					<td>电话</td>
					<td>网址</td>
					<td>公司地址</td>
					<td>状态</td>
				</tr>
				</thead>
				<tbody id="tBody">
				</tbody>
			</table>
			<div id="demo_pag1">
			</div>
		</div>

	</div>

</div>
</body>
</html>