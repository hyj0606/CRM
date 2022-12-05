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

		//当商机信息主页面加载完毕,查询所有数据的第一页以及所有数据的总条数
		queryBusinessByPage(1,5);

		//给查询按钮添加单击事件
		$("#queryBusinessBtn").click(function (){
			//查询所有符合条件数据的第一页以及所有符合条件数据的总数;
			queryBusinessByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
		});

		//给创建按钮添加单击事件
		$("#createBusinessBtu").click(function (){
			//重置表单
			$("#createBusinessForm").get(0).reset();
			//弹出窗口
			$("#createBusinessModal").modal("show")
		});
		//给创建中保存按钮添加单击事件
		$("#saveCreateBusinessBtn").click(function (){

			//收集参数
			var custId = $("#create-custName").val();
			var busiType = $("#create-busiType").val();
			var busiStatus = $("#create-busiStatus").val();
			var busiPrice = $("#create-busiPrice").val();
			var busiPossibility = $("#create-busiPossibility").val();
			var busiEndTime = $("#create-busiEndTime").val();
			var descInfo = $("#create-descInfo").val();

			//发送请求
			$.ajax({
				url:'workbench/business/saveBusiness.do',
				data:{
					custId:custId,
					busiType:busiType,
					busiStatus:busiStatus,
					busiPrice:busiPrice,
					busiPossibility:busiPossibility,
					busiEndTime:busiEndTime,
					descInfo:descInfo
				},
				type:'post',
				dataType: 'json',
				success:function (data){
					if (data.code=="1"){
						//关闭窗口
						$("#createBusinessModal").modal("hide");
						//刷新商机列表,显示第一页数据
						queryBusinessByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//窗口不关闭
						$("#createBusinessModal").modal("show");
					}
				}
			});
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

		//给修改按钮添加单击事件
		$("#editBusinessBtn").click(function (){
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
				url:'workbench/business/queryBusinessById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function (data){
					$("#edit-id").val(data.id);
					$("#edit-custName").val(data.custId);
					$("#edit-busiType").val(data.busiType);
					$("#edit-busiStatus").val(data.busiStatus);
					$("#edit-busiPrice").val(data.busiPrice);
					$("#edit-busiPossibility").val(data.busiPossibility);
					$("#edit-busiEndTime").val(data.busiEndTime);
					$("#edit-descInfo").val(data.descInfo);
					//弹出窗口
					$("#editBusinessModal").modal("show");
				}
			});
		});
		//给修改中更新按钮添加单击事件
		$("#saveEditBusinessBtn").click(function (){
			var id = $("#edit-id").val();
			var custId = $("#edit-custName").val();
			var busiType = $("#edit-busiType").val();
			var busiStatus = $("#edit-busiStatus").val();
			var busiPrice = $("#edit-busiPrice").val();
			var busiPossibility = $("#edit-busiPossibility").val();
			var busiEndTime = $("#edit-busiEndTime").val();
			var descInfo = $("#edit-descInfo").val();

			$.ajax({
				url:'workbench/business/saveEditBusiness.do',
				data:{
					id:id,
					custId:custId,
					busiType:busiType,
					busiStatus:busiStatus,
					busiPrice:busiPrice,
					busiPossibility:busiPossibility,
					busiEndTime:busiEndTime,
					descInfo:descInfo
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						$("#editBusinessModal").modal("hide")
						queryBusinessByPage($("#demo_page").bs_pagination('getOption','currentPage'),$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editBusinessModal").modal("show");
					}
				}
			});

		});

		//给删除按钮添加单击事件
		$("#deleteBusinessBtn").click(function (){

			//收集参数
			var checkedIds = $("tBody input[type='checkbox']:checked");
			if (checkedIds.size() == 0){
				alert("请选择要删除的市场活动");
				return;
			}
			if (window.confirm("确定删除吗?")) {
				var ids = "";
				$.each(checkedIds, function () {
					ids += "id=" + this.value + "&";
				});
				ids = ids.substr(0, ids.length - 1);

				//发送请求
				$.ajax({
					url:'workbench/business/deleteBusiness.do',
					data:ids,
					type:'post',
					dataType:'json',
					success:function (data){
						if (data.code=="1"){
							//刷新聊天记录列表,显示第一页数据,保持显示条数不变
							queryBusinessByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});




	});

	function queryBusinessByPage(pageNo,pageSize){

		//收集参数
		var custName = $("#query-custName").val();
		var busiType = $("#query-busiType").val();
		var busiStatus = $("#query-busiStatus").val();

		$.ajax({
			url:'workbench/business/queryBusinessByPage.do',
			data:{
				custName:custName,
				busiType:busiType,
				busiStatus:busiStatus,
				pageNo:pageNo,
				pageSize:pageSize
			},
			type:'post',
			dataType:'json',
			success:function (data){
				//显示商机信息
				var htmlStr="";
				$.each(data.businessList,function (index,obj){

					htmlStr+="<tr class=\"active\">";
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
					htmlStr+="<td>"+obj.customer.custName+"</td>";
					if (obj.busiType==1){
						htmlStr+="<td>产品销售</td>";
					}
					if (obj.busiType==2){
						htmlStr+="<td>业务合作</td>";
					}
					if (obj.busiStatus==1){
						htmlStr+="<td>待定</td>";
					}
					if (obj.busiStatus==2){
						htmlStr+="<td>已开始</td>";
					}
					if (obj.busiStatus==3){
						htmlStr+="<td>无效</td>";
					}
					htmlStr+="<td>"+obj.busiPrice+"</td>";
					if (obj.busiPossibility==1){
						htmlStr+="<td>100%</td>";
					}
					if (obj.busiPossibility==2){
						htmlStr+="<td>80%</td>";
					}
					if (obj.busiPossibility==3){
						htmlStr+="<td>50%</td>";
					}
					htmlStr+="<td>"+obj.busiEndTime+"</td>";
					htmlStr+="<td>"+obj.user.username+"</td>";
					htmlStr+="<td>"+obj.descInfo+"</td>";
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

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createBusinessModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createBusinessForm">
						<div class="form-group">
							<label for="create-custName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-custName">
								  <c:forEach items="${customerList}"  var="customer">
									  <option value="${customer.id}">${customer.custName}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="create-busiType" class="col-sm-2 control-label">商机类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-busiType">
									<option value="">未选择</option>
									<option value="1">产品销售</option>
									<option value="2">业务合作</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-busiStatus" class="col-sm-2 control-label">商机状态</label>
                            <div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-busiStatus">
									<option value="">未选择</option>
									<option value="1">待定</option>
									<option value="2">已开始</option>
									<option value="3">无效</option>
								</select>
							</div>
							<label for="create-busiPrice" class="col-sm-2 control-label">报价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-busiPrice">
							</div>
						</div>

						<div class="form-group">
							<label for="create-busiPossibility" class="col-sm-2 control-label">可能性</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-busiPossibility">
									<option value="">未选择</option>
									<option value="1">100%</option>
									<option value="2">80%</option>
									<option value="3">50%</option>
								</select>
							</div>
							<label for="create-busiPrice" class="col-sm-2 control-label">商机结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="create-busiEndTime" readonly>
							</div>
						</div>

						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-descInfo" class="col-sm-2 control-label">商机备注</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-descInfo"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateBusinessBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editBusinessModal" role="dialog">
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
							<label for="edit-custName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-custName">
									<c:forEach items="${customerList}"  var="customer">
										<option value="${customer.id}">${customer.custName}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-busiType" class="col-sm-2 control-label">商机类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-busiType">
									<option value="">未选择</option>
									<option value="1">产品销售</option>
									<option value="2">业务合作</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-busiStatus" class="col-sm-2 control-label">商机状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-busiStatus">
									<option value="">未选择</option>
									<option value="1">待定</option>
									<option value="2">已开始</option>
									<option value="3">无效</option>
								</select>
							</div>
							<label for="edit-busiPrice" class="col-sm-2 control-label">报价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-busiPrice">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-busiPossibility" class="col-sm-2 control-label">可能性</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-busiPossibility">
									<option value="">未选择</option>
									<option value="1">100%</option>
									<option value="2">80%</option>
									<option value="3">50%</option>
								</select>
							</div>
							<label for="edit-busiPrice" class="col-sm-2 control-label">商机结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="edit-busiEndTime" readonly>
							</div>
						</div>

						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-descInfo" class="col-sm-2 control-label">商机备注</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-descInfo"></textarea>
								</div>
							</div>
						</div>

					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditBusinessBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>商机信息</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
						<input type="text" class="form-control" id="query-custName">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">商机类型</div>
						<select class="form-control" id="query-busiType">
							<option value="">未选择</option>
							<option value="1">产品销售</option>
							<option value="2">业务合作</option>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">商机状态</div>
						<select class="form-control" id="query-busiStatus">
							<option value="">未选择</option>
							<option value="1">待定</option>
							<option value="2">已开始</option>
							<option value="3">无效</option>
						</select>
				    </div>
				  </div>
				  <button type="button" class="btn btn-default" id="queryBusinessBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createBusinessBtu"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBusinessBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBusinessBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>客户名称</td>
							<td>商机类型</td>
							<td>商机状态</td>
							<td>报价</td>
							<td>可能性</td>
							<td>商机结束日期</td>
							<td>创建者</td>
							<td>商机备注</td>
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