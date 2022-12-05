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
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<!--  PAGINATION plugin -->
<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>


<script type="text/javascript">

	$(function(){
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

		queryGoodsByPage(1,5);

		//给查询按钮添加单击事件
		$("#queryGoodsBtn").click(function (){
			//查询所有符合条件数据的第一页以及所有符合条件数据的总数;
			queryGoodsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
		});

		//给创建按钮添加单击事件
		$("#createGoodsBtn").click(function () {
			//初始化工作
			//重置表单
			$("#createGoodsForm").get(0).reset();

			//弹出创建客户活动的模态窗口
			$("#createGoodsModal").modal("show");
		});
		//给创建后保存按钮创建单击事件
		$("#saveCreateGoodsBtn").click(function () {

			var formData = new FormData();

			//收集参数
			var goodsName = $("#create-goodsName").val();
			var providerId = $("#create-providerName").val();
			var unit = $("#create-unit").val();
			var cost = $("#create-cost").val();
			var salePrice = $("#create-salePrice").val();
			var descInfo = $("#create-descInfo").val();
			var imgFile = $("#create-goodsImg").get(0).files[0];

			formData.append('goodsName',goodsName);
			formData.append('providerId',providerId);
			formData.append('unit',unit);
			formData.append('cost',cost);
			formData.append('salePrice',salePrice);
			formData.append('descInfo',descInfo);
			formData.append('imgFile',imgFile);

			//数据的检验
			//发送请求
			$.ajax({
				url:'workbench/supply/goods/saveGoods.do',
				data:formData,
				type:'post',
				contentType:false,
				processData: false,
				cache:false,
				success:function(data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#createGoodsModal").modal("hide");
						//刷新聊天记录,显示第一页数据,保持每页显示条数不变
						queryGoodsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//模态窗口不关闭
						$("#createGoodsModal").modal("show");
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


		//给修改添加单击事件
		$("#editGoodsBtn").click(function (){

			//收集参数
			//获取列表中被选中的checkbox
			var checkedIds = $("tBody input[type='checkbox']:checked");
			if (checkedIds.size()==0){
				alert("请选择要修改的商品");
				return;
			}if (checkedIds.size() > 1){
				alert("每次只能修改一天商品");
				return;
			}
			var id= checkedIds.get(0).value;

			//发送请求
			$.ajax({
				url:'workbench/supply/goods/queryGoodsById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function(data){
					//把市场活动信息显示在修改的模态窗口上
					$("#edit-id").val(data.id);
					$("#edit-providerName").val(data.providerId);
					$("#edit-goodsName").val(data.goodsName);
					$("#edit-unit").val(data.unit);
					$("#edit-cost").val(data.cost);
					$("#edit-salePrice").val(data.salePrice);
					$("#edit-descInfo").val(data.descInfo);
					//$("#edit-goodsImg").val(data.goodsImg);
					//弹出模态窗口
					$("#editGoodsModal").modal("show");
				}
			});
		});
		//给修改中更新按钮添加事件
		$("#saveEditGoodsBtn").click(function () {

			var formData = new FormData();

			//收集参数
			var id = $("#edit-id").val();
			var goodsName = $("#edit-goodsName").val();
			var unit = $("#edit-unit").val();
			var cost = $.trim($("#edit-cost").val());
			var salePrice = $.trim($("#edit-salePrice").val());
			var descInfo = $.trim($("#edit-descInfo").val());
			var imgFile = $("#edit-goodsImg").get(0).files[0];

			formData.append("id",id);
			formData.append("goodsName",goodsName);
			formData.append("unit",unit);
			formData.append("cost",cost);
			formData.append("salePrice",salePrice);
			formData.append("descInfo",descInfo);
			formData.append("imgFile",imgFile);

			$.ajax({
				url:'workbench/supply/goods/saveEditGoods.do',
				data:formData,
				type:'post',
				contentType:false,
				processData:false,
				cache:false,
				success:function (data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#editGoodsModal").modal("hide");
						queryGoodsByPage($("#demo_page").bs_pagination('getOption','currentPage'),$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editGoodsModal").modal("show");
					}
				}

			});
		});


		//给删除按钮添加点击事件
		$("#deleteGoodsBtn").click(function () {
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
					url:'workbench/supply/goods/deleteGoods.do',
					data:ids,
					type:'post',
					dataType:'json',
					success:function (data){
						if (data.code=="1"){
							//刷新聊天记录列表,显示第一页数据,保持显示条数不变
							queryGoodsByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});
	});

	function queryGoodsByPage(pageNo, pageSize){
		//收集参数
		var providerName = $("#query-providerName").val();
		var goodsName = $("#query-goodsName").val();

		$.ajax({
			url:'workbench/supply/goods/queryGoodsByPage.do',
			data:{
				providerName:providerName,
				goodsName:goodsName,
				pageNo:pageNo,
				pageSize:pageSize
			},
			type:'post',
			dataType:'json',
			success:function (data){
				//显示聊天记录
				//遍历chatsList,拼接所有行数据
				var htmlStr="";
				$.each(data.goodsList,function (index, obj) {
					htmlStr+="<tr class=\"active\">";
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
					htmlStr+="<td>"+obj.goodsName+"</td>";
					htmlStr+="<td>"+obj.provider.providerName+"</td>";
					htmlStr+="<td>"+obj.unit+"</td>";
					htmlStr+="<td>"+obj.cost+"</td>";
					htmlStr+="<td>"+obj.salePrice+"</td>";
					htmlStr+="<td>"+obj.descInfo+"</td>";
					htmlStr+="<td> <p style='display: inline-block; overflow: hidden; text-overflow: ellipsis; width: 8em; white-space: nowrap;'> "+obj.goodsImg+"</p></td>";
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
						queryGoodsByPage(pageObj.currentPage,pageObj.rowsPerPage);
					}
				});
			}
		});

	}
	
</script>
</head>
<body>

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createGoodsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加商品</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createGoodsForm">
					
						<div class="form-group">
							<label for="create-goodsName" class="col-sm-2 control-label">商品名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-goodsName">
							</div>
							<label for="create-providerName" class="col-sm-2 control-label">供应商<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-providerName">
									<c:forEach items="${providerList}" var="provider">
										<option value="${provider.id}">${provider.providerName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-unit" class="col-sm-2 control-label">单位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-unit">
							</div>
							<label for="create-cost" class="col-sm-2 control-label">成本单价<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-salePrice" class="col-sm-2 control-label">销售单价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-salePrice">
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-descInfo" class="col-sm-2 control-label">商品备注</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-descInfo"></textarea>
							</div>
						</div>
						
						<div style="position: relative;top: 20px;">
							<div class="form-group">
                                <label for="create-goodsImg" class="col-sm-2 control-label">产品图片</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <input type="file" class="form-control" id="create-goodsImg">
                                </div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateGoodsBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editGoodsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改商品</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-goodsName" class="col-sm-2 control-label">商品名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-goodsName">
							</div>
							<label for="edit-providerName" class="col-sm-2 control-label">供应商<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-providerName" readonly>
									<c:forEach items="${providerList}" var="provider">
										<option value="${provider.id}">${provider.providerName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-unit" class="col-sm-2 control-label">单位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-unit">
							</div>
							<label for="edit-cost" class="col-sm-2 control-label">成本单价<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-salePrice" class="col-sm-2 control-label">销售单价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-salePrice">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-descInfo" class="col-sm-2 control-label">商品备注</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-descInfo"></textarea>
							</div>
						</div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-goodsImg" class="col-sm-2 control-label">产品图片</label>
								<div class="col-sm-10" style="width: 81%;">
									<input type="file" class="form-control" id="edit-goodsImg">
								</div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditGoodsBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>商品</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">商品名称</div>
							<input class="form-control" type="text" id="query-goodsName">
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">供应商</div>
							<input class="form-control" type="text" id="query-providerName">
						</div>
					</div>

				  <button type="button" class="btn btn-default" id="queryGoodsBtn">查询</button>
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createGoodsBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editGoodsBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteGoodsBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>商品名称</td>
							<td>供应商</td>
							<td>单位</td>
							<td>成本单价</td>
							<td>销售单价</td>
							<td>商品备注</td>
							<td>产品图片</td>
						</tr>
					</thead>
					<tbody id="tBody">

					</tbody>
				</table>
				<div id="demo_page"></div>
			</div>
		</div>
		
	</div>
</body>
</html>