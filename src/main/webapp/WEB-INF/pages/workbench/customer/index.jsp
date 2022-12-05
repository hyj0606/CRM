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

		//给创建按钮添加单击事件
		$("#createCustomerBtn").click(function (){
			//初始化工作
			//重置表单
			$("#createCustomerForm").get(0).reset();

			//弹出创建客户活动的模态窗口
			$("#createCustomerModal").modal("show");
		});

		//给保存按钮添加单击事件
		$("#saveCreateCustomerBtn").click(function (){
			//收集参数
			var userId = $("#create-username").val();
			var custName = $("#create-customerName").val();
			var custType = $("#create-type").val();
			var telphone = $("#create-telphone").val();
			var netAddress = $("#create-net").val();
			var custStatus = $("#create-status").val();
			var address = $("#create-address1").val();
			var descInfo = $("#create-describe").val();

			//发送请求
			$.ajax({
				url:'workbench/customer/saveCustomer.do',
				data:{
					userId:userId,
					custName:custName,
					custType:custType,
					telphone:telphone,
					netAddress:netAddress,
					custStatus:custStatus,
					address:address,
					descInfo:descInfo
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#createCustomerModal").modal("hide");
						//刷新市场活动,显示第一页数据,保持每页显示条数不变
						queryCustomerByPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//模态从窗口不关闭
						$("#createCustomerModal").modal("show");//可以不写
					}
				}
			});


		});

		//当市场活动主页面加载完成,查询所有数据的第一页已经所有数据的总条数;
		queryCustomerByPage(1,5);

		//给查询按钮添加单击事件
		$("#queryCustomerBtn").click(function (){
			//查询所有符合条件数据的第一页以及所有符合条件数据的总数;
			queryCustomerByPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
		});

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

		//给删除按钮添加点击事件
		$("#deleteCustomerBtn").click(function () {
			//收集参数
			//获取列表中所有被选中的checkbox
			var checkedIds = $("#tBody input[type='checkbox']:checked");
			if (checkedIds.size() == 0){
				alert("请选择要删除的市场活动");
				return;
			}
			if(window.confirm("确定删除吗?")){
				var ids="";
				$.each(checkedIds,function () {//id=xxx&id=xxx&id=xxx&
					ids+="id="+this.value+"&";
				});
				ids = ids.substr(0,ids.length-1);
				//发送请求
				$.ajax({
					url:'workbench/customer/deleteCustomer.do',
					data:ids,
					type:'post',
					dataType:'json',
					success:function (data){
						if (data.code=="1"){
							//刷新市场活动列表,显示第一页数据,保持每一页显示条数不变
							queryCustomerByPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'))
						}else {
							//提示信息
							alert(data.message);
						}
					}
				});
			}
		});

		//给修改按钮添加单击事件
		$("#editCustomerBtn").click(function () {
			//收集参数
			//获取列表中被选中的checkbox
			var checkedIds = $("#tBody input[type='checkbox']:checked");
			if (checkedIds.size() == 0){
				alert("请选择要修改的客户信息");
				return;
			}
			if (checkedIds.size() > 1){
				alert("每次只能修改一条客户信息");
				return;
			}

			var id = checkedIds.get(0).value;

			//发送请求
			$.ajax({
				url:'workbench/customer/queryCustomerById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function (data) {
					//把市场活动信息显示在修改的模态窗口上
					$("#edit-id").val(data.id);
					$("#edit-username").val(data.userId);
					$("#edit-customerName").val(data.custName);
					$("#edit-type").val(data.custType);
					$("#edit-telphone").val(data.telphone);
					$("#edit-net").val(data.netAddress);
					$("#edit-status").val(data.custStatus);
					$("#edit-uid").val(data.user.username);
					$("#edit-address1").val(data.address);
					$("#edit-describe").val(data.descInfo);

					//弹出模态窗口
					$("#editCustomerModal").modal("show");
				}
			});
		});

		//给修改中更新按钮添加单击事件
		$("#saveEditCustomerBtn").click(function (){
			//收集参数
			var id = $("#edit-id").val();
			var userId = $("#edit-username").val();
			var custName = $("#edit-customerName").val();
			var custType = $("#edit-type").val();
			var telphone = $("#edit-telphone").val();
			var netAddress = $("#edit-net").val();
			var custStatus = $("#edit-status").val();
			var address = $("#edit-address1").val();
			var descInfo = $("#edit-describe").val();

			$.ajax({
				url:'workbench/customer/saveEditCustomer.do',
				data:{
					id:id,
					userId:userId,
					custName:custName,
					custType:custType,
					telphone:telphone,
					netAddress:netAddress,
					address:address,
					custStatus:custStatus,
					descInfo:descInfo
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code==1){
						//关闭
						$("#editCustomerModal").modal("hide");
						queryCustomerByPage($("#demo_pag1").bs_pagination('getOption','currentPage'),$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editCustomerModal").modal("show");
					}
				}
			});


		});

	});

	//封装函数 查询客户信息
	function queryCustomerByPage(pageNo,pageSize){
		//收集参数
		var custName = $("#query-name").val();
		var type = $("#query-type").val();
		var status = $("#query-status").val();
		$.ajax({
			url:'workbench/customer/queryCustomerByPage.do',
			data:{
				type:type,
				status:status,
				custName:custName,
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
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
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
					htmlStr+="<td><p style='display: inline-block; overflow: hidden; text-overflow: ellipsis; width: 8em; white-space: nowrap;'>"+obj.address+"</p></td>";
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

				//取消全选按钮
				$("#checkAll").prop("checked",false);

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

					visiblePageLinks:2,//最多可以显示的卡片数

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

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createCustomerForm">
						<div class="form-group">
							<label for="create-username" class="col-sm-2 control-label">客户经理<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-username">
									<c:forEach items="${userList}" var="u">
										<option value="${u.id}">${u.username}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-customerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName">
							</div>
						</div>
						<div class="form-group">
                            <label for="create-type" class="col-sm-2 control-label">类别</label>
                            <div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-type">
									<option value="1">传统</option>
									<option value="2">互联网</option>
								</select>
                            </div>
							<label for="create-telphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-telphone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-net" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-net">
							</div>
							<label for="create-status" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-status">
									<option value="1">待沟通</option>
									<option value="2">新客户</option>
									<option value="3">老客户</option>
									<option value="4">无效客户</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="create-uid" class="col-sm-2 control-label">创建者</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-uid" value="${sessionScope.sessionUser.username}" readonly/>
							</div>
						</div>
						<div style="position: relative;top: 20px;">
							<div class="form-group">
								<label for="create-address1" class="col-sm-2 control-label">详细地址</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="1" id="create-address1"></textarea>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateCustomerBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-username" class="col-sm-2 control-label">客户经理<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-username">
									<c:forEach items="${userList}" var="u">
										<option value="${u.id}">${u.username}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" >
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-type" class="col-sm-2 control-label">类别</label>
                            <div class="col-sm-10" style="width: 300px;">
								<select type="text" class="form-control" id="edit-type">
									<option value="1">传统</option>
									<option value="2">互联网</option>
								</select>
                            </div>
							<label for="edit-telphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-telphone" >
							</div>
						</div>

						<div class="form-group">
							<label for="edit-net" class="col-sm-2 control-label">公司网址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-net" >
							</div>
							<label for="edit-status" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select type="text" class="form-control" id="edit-status">
									<option value="1">待沟通</option>
									<option value="2">新客户</option>
									<option value="3">老客户</option>
									<option value="4">无效客户</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-uid" class="col-sm-2 control-label">创建者</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-uid" readonly/>
							</div>

						</div>
						<div class="form-group">
							<label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="1" id="edit-address1"></textarea>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>

					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditCustomerBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
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
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="query-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类别</div>
						<select class="form-control" id="query-type">
							<option value="">未选择</option>
							<option value="1">传统</option>
							<option value="2">互联网</option>
						</select>
				    </div>
				  </div>

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">状态</div>
							<select class="form-control" id="query-status">
								<option value="">未选择</option>
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
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createCustomerBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editCustomerBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteCustomerBtn" ><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
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