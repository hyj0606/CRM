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

		querySaleByPage(1,5);

		//给查询按钮添加单击事件
		$("#querySaleBtn").click(function (){
			querySaleByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
		});

		//给创建按钮添加单击事件
		$("#createSaleBtn").click(function () {
			//初始化工作
			//重置表单
			$("#createSaleForm").get(0).reset();

			//弹出创建联系人活动的模态窗口
			$("#createSaleModal").modal("show");
		});
		//给创建中保存按钮添加单击事件
		$("#saveCreateSaleBtn").click(function () {

			//收集参数
			var custId = $("#create-custName").val();
			var goodsId = $("#create-goodsName").val();
			var saleUid = $("#create-user").val();
			var orderNum = $("#create-orderNum").val();
			var orderPrice = $("#create-orderPrice").val();
			var saleTime = $("#create-saleTime").val();
			var saleDiscount = $("#create-saleDiscount").val();
			var descInfo = $("#create-descInfo").val();

			//发送请求
			$.ajax({
				url:'workbench/sale/saveSale.do',
				data:{
					goodsId:goodsId,
					saleUid:saleUid,
					custId:custId,
					orderNum:orderNum,
					orderPrice:orderPrice,
					saleTime:saleTime,
					saleDiscount:saleDiscount,
					descInfo:descInfo
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#createSaleModal").modal("hide");
						//刷新市场活动,显示第一页数据,保持每页显示条数不变
						querySaleByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//模态从窗口不关闭
						$("#createSaleModal").modal("show");//可以不写
					}
				}
			});
		});

		//给全选按钮添加单击事件
		$("#checkAll").click(function () {
			//如果时全选按钮是选中状态,则列表中所有checkbox都选中
			$("#tBody input[type='checkbox']").prop("checked",this.checked);
		});
		$("#tBody").on("click","input[type='checkbox']",function (){
			if ($("#tBody input[type='checkbox']").size()==$("#tBody input[type='checkbox']:checked").size()){
				$("#checkAll").prop("checked",true);
			}else {
				//如果列表中的所有checkbox至少有一个没有选中,则全选按钮也取消
				$("#checkAll").prop("checked",false);
			}
		});

		//给删除按钮添加单击事件
		$("#deleteSaleBtn").click(function () {

			//收集参数
			//从列表中获取所被选中该的checkbox
			var checkedIds = $("#tBody input[type='checkbox']:checked");
			if (checkedIds.size()==0){
				alert("请选择要删除的联系人");
				return;
			}
			if (window.confirm("确定要删除吗?")){
				var ids = "";
				$.each(checkedIds,function (){
					ids+="id="+this.value+"&";
				});
				ids = ids.substr(0,ids.length-1);

				//发送请求
				$.ajax({
					url:'workbench/sale/deleteSale.do',
					data:ids,
					type:'post',
					dataType: "json",
					success:function (data){
						if(data.code=="1"){
							//刷新聊天记录列表,显示第一页数据,保持显示条数不变
							querySaleByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});

		//给修改按钮添加单击事件
		$("#editSaleBtn").click(function (){
			//收集参数
			var checkedIds = $("#tBody input[type='checkbox']:checked");
			if (checkedIds.size()==0){
				alert("请选择要修改的联系人");
				return;
			}
			if (checkedIds.size() > 1){
				alert("每次只能修改一个联系人");
				return;
			}
			var id = checkedIds.get(0).value;


			//发送请求
			$.ajax({
				url:'workbench/sale/querySaleById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function (data){
					//显示
					$("#edit-id").val(data.id);
					$("#edit-custName").val(data.custId);
					$("#edit-goodsName").val(data.goodsId);
					$("#edit-orderNum").val(data.orderNum);
					$("#edit-orderPrice").val(data.orderPrice);
					$("#edit-saleTime").val(data.saleTime);
					$("#edit-saleDiscount").val(data.saleDiscount);
					$("#edit-user").val(data.saleUid);
					$("#edit-descInfo").val(data.descInfo);

					//弹出模态窗口
					$("#editSaleModal").modal("show");
				}
			});
		});

		//给修改中更新按钮添加单击事件
		$("#saveEditSaleBtn").click(function (){
			var id = $("#edit-id").val();
			var custId = $("#edit-custName").val();
			var goodsId = $("#edit-goodsName").val();
			var orderNum = $("#edit-orderNum").val();
			var orderPrice = $("#edit-orderPrice").val();
			var saleTime = $("#edit-saleTime").val();
			var saleDiscount = $("#edit-saleDiscount").val();
			var saleUid = $("#edit-user").val();
			var descInfo = $("#edit-descInfo").val();
			$.ajax({
				url:'workbench/sale/saveEditSale.do',
				data:{
					id:id,
					custId:custId,
					goodsId:goodsId,
					orderNum:orderNum,
					orderPrice:orderPrice,
					saleTime:saleTime,
					saleDiscount:saleDiscount,
					saleUid:saleUid,
					descInfo:descInfo
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						$("#editSaleModal").modal("hide")
						querySaleByPage($("#demo_page").bs_pagination('getOption','currentPage'),$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editSaleModal").modal("show");
					}
				}
			});
		});


	});

	//封装函数
	function querySaleByPage(pageNo,pageSize){

		//收集参数
		var goodsName = $("#query-goodsName").val();
		var custName = $("#query-custName").val();

		$.ajax({
			url:'workbench/sale/querySaleByPage.do',
			data:{
				goodsName:goodsName,
				custName:custName,
				pageNo:pageNo,
				pageSize:pageSize
			},
			success:function (data){
				//显示联系人信息
				//遍历concatList,拼接所有数据
				var htmlStr="";
				$.each(data.saleList,function (index,obj){

					htmlStr+="<tr class=\"active\">";
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
					htmlStr+="<td>"+obj.customer.custName+"</td>";
					htmlStr+="<td>"+obj.goods.goodsName+"</td>";
					htmlStr+="<td>"+obj.user.username+"</td>";
					htmlStr+="<td>"+obj.orderNum+"</td>";
					htmlStr+="<td>"+obj.orderPrice+"</td>";
					htmlStr+="<td>"+obj.saleTime+"</td>";
					htmlStr+="<td>"+obj.saleDiscount+"</td>";
					htmlStr+="<td>"+obj.descInfo+"</td>";
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
						querySaleByPage(pageObj.currentPage,pageObj.rowsPerPage);
					}
				});
			}
		});

	}


</script>
</head>
<body>

	
	<!-- 创建销售记录的模态窗口 -->
	<div class="modal fade" id="createSaleModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建销售记录</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createSaleForm">
					
						<div class="form-group">
							<label for="create-custName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-custName">
									<c:forEach items="${customerList}" var="customer">
										<option value="${customer.id}">${customer.custName}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-goodsName" class="col-sm-2 control-label">商品</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-goodsName">
									<c:forEach items="${goodsList}" var="goods">
										<option value="${goods.id}">${goods.goodsName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-user" class="col-sm-2 control-label">客户经理<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-user">
									<c:forEach items="${userList}" var="user">
										<option value="${user.id}">${user.username}</option>
									</c:forEach>
								</select>							</div>
							<label for="create-orderNum" class="col-sm-2 control-label">订单数量</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-orderNum">
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="create-orderPrice" class="col-sm-2 control-label">订单价格</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-orderPrice">
							</div>
							<label for="create-saleTime" class="col-sm-2 control-label">销售时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="create-saleTime" readonly>
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-saleDiscount" class="col-sm-2 control-label">折扣</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-saleDiscount">
							</div>
						</div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-descInfo" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-descInfo"></textarea>
								</div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateSaleBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editSaleModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改销售记录</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
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
							<label for="edit-goodsName" class="col-sm-2 control-label">商品</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-goodsName">
									<c:forEach items="${goodsList}" var="goods">
										<option value="${goods.id}">${goods.goodsName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-user" class="col-sm-2 control-label">客户经理<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-user">
									<c:forEach items="${userList}" var="user">
										<option value="${user.id}">${user.username}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-orderNum" class="col-sm-2 control-label">订单数量</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-orderNum" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-orderPrice" class="col-sm-2 control-label">订单价格</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-orderPrice">
							</div>
							<label for="edit-saleTime" class="col-sm-2 control-label">销售时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-saleTime" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="edit-saleDiscount" class="col-sm-2 control-label">折扣</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-saleDiscount">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-descInfo" class="col-sm-2 control-label">备注</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-descInfo"></textarea>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditSaleBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>销售记录</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户</div>
				      <input class="form-control" type="text" id="query-custName">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">商品</div>
				      <input class="form-control" type="text" id="query-goodsName">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="querySaleBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createSaleBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editSaleBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteSaleBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>客户名称</td>
							<td>商品</td>
							<td>客户经理</td>
							<td>订单数量</td>
							<td>订单价格</td>
							<td>销售时间</td>
							<td>折扣</td>
							<td>备注</td>
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