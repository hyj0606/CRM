<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>"><%--根路径--%>
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<!--  PAGINATION plugin -->
<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>

<script type="text/javascript">

	$(function(){
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });

		//当市场活动主页面加载完成,查询所有数据的第一页已经所有数据的总条数;
		queryChatsByPage(1,5);

		//给全选按钮添加单击事件
		$("#checkAll").click(function (){
			//如果全选按钮是选中状态，则列表中所有checkbox都选中
			$("#tBody input[type='checkbox']").prop("checked",this.checked);
		});
		$("#tBody").on("click","input[type='checkbox']",function () {
			if ($("#tBody input[type='checkbox']").size()== $("#tBody input[type='checkbox']:checked").size()){
				$("#checkAll").prop("checked",true);
			}else {
				//如果列表中的所有checkbox至少有一个没有选中,则全选按钮也取消
				$("#checkAll").prop("checked",false);
			}
		});

		//给查询按钮添加单击事件
		$("#queryChatsBtn").click(function (){
			//查询所有符合条件数据的第一页以及所有符合条件数据的总数;
			queryChatsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
		});

		//给创建按钮添加单击事件
		$("#createChatsBtn").click(function () {
			//初始化工作
			//重置表单
			$("#createChatsForm").get(0).reset();

			//弹出创建客户活动的模态窗口
			$("#createChatsModal").modal("show");
		});
		//给创建后保存按钮创建单击事件
		$("#saveCreateChatsBtn").click(function () {
			//收集参数
			var custId = $("#create-custName").val();
			var concatType = $("#create-concatType").val();
			var userId = $("#create-username").val();
			var startTime = $("#create-startTime").val();
			var chatTime = $("#create-chatTime").val();
			var chatContent = $("#create-content").val();

			//数据的检验
			var regExp = /^(([1-9]\d*)|0)$/;
			if (!regExp.test(chatTime)){
				alert("成本只能为整数");
			}

			//发送请求
			$.ajax({
				url:'workbench/chats/saveChats.do',
				data:{
					custId:custId,
					concatType:concatType,
					userId:userId,
					startTime:startTime,
					chatTime:chatTime,
					chatContent:chatContent
				},
				type:'post',
				dataType: 'json',
				success:function(data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#createChatsModal").modal("hide");
						//刷新聊天记录,显示第一页数据,保持每页显示条数不变
						queryChatsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//模态窗口不关闭
						$("#createChatsModal").modal("show");
					}
				}
			});
		});

		//给修改添加单击事件
		$("#editChatsBtn").click(function (){

			//收集参数
			//获取列表中被选中的checkbox
			var checkedIds = $("tBody input[type='checkbox']:checked");
			if (checkedIds.size()==0){
				alert("请选择要修改的聊天记录");
				return;
			}if (checkedIds.size() > 1){
				alert("每次只能修改一天聊天记录");
				return;
			}
			var id= checkedIds.get(0).value;

			//发送请求
			$.ajax({
				url:'workbench/chats/queryChatsById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function(data){
					//把市场活动信息显示在修改的模态窗口上
					$("#edit-id").val(data.id);
					$("#edit-custName").val(data.custId);
					$("#edit-username").val(data.userId);
					$("#edit-concatType").val(data.concatType);
					$("#edit-chatTime").val(data.chatTime);
					$("#edit-content").val(data.chatContent);
					//弹出模态窗口
					$("#editChatsModal").modal("show");
				}
			});
		});

		//给修改中更新按钮添加事件
		$("#saveEditChatsBtn").click(function () {
			//收集参数
			var id = $("#edit-id").val();
			var custId = $("#edit-custName").val();
			var userId = $("#edit-username").val();
			var concatType = $("#edit-concatType").val();
			var chatTime = $.trim($("#edit-chatTime").val());
			var chatContent = $.trim($("#edit-content").val());

			//表单验证
			var regExp = /^(([1-9]\d*)|0)$/;
			if (!regExp.test(chatTime)){
				alert("成本只能为整数");
			}

			$.ajax({
				url:'workbench/chats/saveEditChats.do',
				data:{
					id:id,
					custId:custId,
					userId:userId,
					concatType:concatType,
					chatTime:chatTime,
					chatContent:chatContent
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#editChatsModal").modal("hide");
						queryChatsByPage($("#demo_page").bs_pagination('getOption','currentPage'),$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editChatsModal").modal("show");
					}
				}

			});
		});

		//给删除按钮添加点击事件
		$("#deleteChatsBtn").click(function () {
			//收集参数
			//获取列表中所有被选中的checkbox
			var checkedIds = $("tBody input[type='checkbox']:checked");
			if (checkedIds.size() == 0){
				alert("请选择要删除的市场活动");
				return;
			}
			if (window.confirm("确定删除吗?")){
				var ids = "";
				$.each(checkedIds,function(){
					ids+="id="+this.value+"&";
				});
				ids = ids.substr(0,ids.length-1);

				//发送请求
				$.ajax({
					url:'workbench/chats/deleteChats.do',
					data:ids,
					type:'post',
					dataType:'json',
					success:function (data){
						if (data.code=="1"){
							//刷新聊天记录列表,显示第一页数据,保持显示条数不变
							queryChatsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});

		//当容器加载完成之后,对容器调用工具函数
		$(".myDate").datetimepicker({
			language:'zh-CN', //语言
			format:'yyyy-mm-dd hh:ii:ss',//日期的格式
			minView:0, //可以选择的最小视图
			dateFormat:'yyyy-mm-dd',
			timeFormat:'HH:mm:ss',
			initialDate:new Date(),//初始化显示的日期
			autoclose:true,//设置选择完日期或者时间之后，日否自动关闭日历
			todayBtn:true,//设置是否显示"今天"按钮,默认是false
			clearBtn:true//设置是否显示"清空"按钮，默认是false
		});
		
	});

	//封装函数
	function queryChatsByPage(pageNo,pageSize){
		//收集参数
		var username = $("#query-username").val();
		var custName = $("#query-custName").val();
		var concatType = $("#query-concatType").val();

		$.ajax({
			url:'workbench/chats/queryChatsByPage.do',
			data:{
				username:username,
				custName:custName,
				concatType:concatType,
				pageNo:pageNo,
				pageSize:pageSize
			},
			type:'post',
			dataType:'json',
			success:function (data){
				//显示聊天记录
				//遍历chatsList,拼接所有行数据
				var htmlStr="";
				$.each(data.chatsList,function (index, obj) {
					htmlStr+="<tr class=\"active\">";
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
					htmlStr+="<td>"+obj.customer.custName+"</td>";
					if (obj.concatType==1){
						htmlStr+="<td>电话</td>";
					}
					if (obj.concatType==2){
						htmlStr+="<td>微信</td>";
					}
					if (obj.concatType==3){
						htmlStr+="<td>面聊</td>";
					}
					htmlStr+="<td>"+obj.startTime+"</td>";
					htmlStr+="<td>"+obj.chatTime+"</td>";
					htmlStr+="<td><p style='display: inline-block; overflow: hidden; text-overflow: ellipsis; width: 8em; white-space: nowrap;'>"+obj.chatContent+"</p></td>";
					htmlStr+="<td>"+obj.createTime+"</td>";
					htmlStr+="</tr>";
				});
				$("#tBody").html(htmlStr);

				//取消全选按钮
				$("#checkAll").prop("checked",false);

				//计算总页数
				var totalPages = 1;
				if (data.count%pageSize==0){
					totalPages=data.count/pageSize;
				}else {
					totalPages=parseInt(data.count/pageSize)+1;
				}

				$("#demo_page").bs_pagination({
					currentPage:pageNo,//当前页号,相当于pageNo

					rowsPerPage:pageSize,//每页显示条数,相当于pageSize
					totalRows:data.count,//总条数
					totalPages: totalPages,  //总页数,必填参数.

					visiblePageLinks:3,//最多可以显示的卡片数

					showGoToPage:true,//是否显示"跳转到"部分,默认true--显示
					showRowsPerPage:true,//是否显示"每页显示条数"部分。默认true--显示
					showRowsInfo:true,//是否显示记录的信息，默认true--显示

					//用户每次切换页号，都自动触发本函数;
					//每次返回切换页号之后的pageNo和pageSize
					onChangePage: function(event,pageObj) { // returns page_num and rows_per_page after a link has clicked
						queryChatsByPage(pageObj.currentPage,pageObj.rowsPerPage);
					}
				});
			}
		});

	}
	
</script>
</head>
<body>

	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createChatsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"->
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建聊天记录</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createChatsForm">
					
						<div class="form-group">
							<label for="create-custName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-custName">
								  <c:forEach items="${customerList}" var="customer">
									  <option value="${customer.id}">${customer.custName}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="create-concatType" class="col-sm-2 control-label">联系方式</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-concatType">
								  <option value="">未选择</option>
								  <option value="1">电话</option>
								  <option value="2">微信</option>
								  <option value="3">面聊</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="create-username" class="col-sm-2 control-label">客户经理<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-username">
									<c:forEach items="${userList}" var="user">
										<option value="${user.id}">${user.username}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="create-startTime" readonly>
							</div>
							<label for="create-chatTime" class="col-sm-2 control-label">聊天时长(分钟)</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-chatTime">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-content" class="col-sm-2 control-label">聊天记录</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-content"></textarea>
							</div>
						</div>

					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateChatsBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editChatsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改聊天记录</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" >
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-custName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-custName">
								  <c:forEach items="${customerList}" var="customer">
									  <option value="${customer.id}">${customer.custName}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="edit-concatType" class="col-sm-2 control-label">联系方式</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-concatType">
								  <option value="1">电话</option>
								  <option value="2">微信</option>
								  <option value="3">面聊</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="create-chatTime" class="col-sm-2 control-label">聊天时长(分钟)</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-chatTime">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-content" class="col-sm-2 control-label">聊天记录</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-content"></textarea>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditChatsBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户聊天记录</h3>
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
				      <div class="input-group-addon">创建者</div>
				      <input class="form-control" type="text" id="query-username">
				    </div>
				  </div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">客户名称</div>
							<input class="form-control" type="text" id="query-custName">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">类别</div>
							<select class="form-control" id="query-concatType">
								<option value="">未选择</option>
								<option value="1">电话</option>
								<option value="2">微信</option>
								<option value="3">面聊</option>
							</select>
						</div>
					</div>
				  <button type="button" class="btn btn-default" id="queryChatsBtn" >查询</button>
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createChatsBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editChatsBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteChatsBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>

			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>客户姓名</td>
							<td>联系方式</td>
							<td>开始日期</td>
							<td>聊天时长(/分钟)</td>
							<td style="text-overflow: ellipsis">聊天内容</td>
							<td>创建时间</td>
						</tr>
					</thead>
					<tbody id="tBody">

					</tbody>
				</table>
				<div id="demo_page">

				</div>
			</div>
		</div>


	</div>
</body>
</html>