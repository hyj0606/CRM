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

		//当联系人主页面加载完毕后,查询所有数据展示第一页以及所有数据的总条数
		queryConcatByPage(1,5);

		//给查询按钮添加单击事件
		$("#queryConcatBtn").click(function (){
			queryConcatByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
		});

		//给创建按钮添加单击事件
		$("#createConcatBtn").click(function () {
			//初始化工作
			//重置表单
			$("#createConcatForm").get(0).reset();

			//弹出创建联系人活动的模态窗口
			$("#createConcatModal").modal("show");
		});
		//给创建中保存按钮添加单击事件
		$("#saveCreateConcatBtn").click(function () {

			var formData = new FormData();

			//收集参数
			var concatName = $("#create-concatName").val();
			var gender = $("#create-gender").val();
			var custId = $("#create-custName").val();
			var job = $("#create-job").val();
			var telphone = $("#create-telphone").val();
			var wxAccount = $("#create-wx").val();
			var borndate = $("#create-borndate").val();
			var imgFile = $("#create-photo").get(0).files[0];
			var address = $("#create-address").val();
			var descInfo = $("#create-descInfo").val();

			formData.append('concatName',concatName);
			formData.append('gender',gender);
			formData.append('custId',custId);
			formData.append('job',job);
			formData.append('telphone',telphone);
			formData.append('wxAccount',wxAccount);
			formData.append('borndate',borndate);
			formData.append('imgFile',imgFile);
			formData.append('address',address);
			formData.append('descInfo',descInfo);


			//发送请求
			$.ajax({
				url:'workbench/concat/saveConcat.do',
				data:formData,
				type:'post',
				contentType:false,
				processData: false,
				cache:false,
				success:function (data){
					if (data.code=="1"){
						//关闭模态窗口
						$("#createConcatModal").modal("hide");
						//刷新市场活动,显示第一页数据,保持每页显示条数不变
						queryConcatByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						//提示信息
						alert(data.message);
						//模态从窗口不关闭
						$("#createConcatModal").modal("show");//可以不写
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

		//给修改按钮添加单击事件
		$("#editConcatBtn").click(function (){
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
				url:'workbench/concat/queryConcatById.do',
				data:{
					id:id
				},
				type:'post',
				dataType:'json',
				success:function (data){
					//显示
					$("#edit-id").val(data.id);
					$("#edit-concatName").val(data.concatName);
					$("#edit-gender").val(data.gender);
					$("#edit-custName").val(data.custId);
					$("#edit-job").val(data.job);
					$("#edit-telphone").val(data.telphone);
					$("#edit-wx").val(data.wxAccount);
					$("#edit-borndate").val(data.borndate);
					$("#edit-address").val(data.address);
					$("#edit-createName").val(data.user.username);
					$("#edit-descInfo").val(data.descInfo);

					//弹出模态窗口
					$("#editConcatModal").modal("show");
				}
			});
		});
		//给修改中更新按钮添加单击事件
		$("#saveEditConcatBtn").click(function (){

			var formData = new FormData();

			var id = $("#edit-id").val();
			var concatName = $("#edit-concatName").val();
			var gender = $("#edit-gender").val();
			var job = $("#edit-job").val();
			var telphone = $("#edit-telphone").val();
			var wxAccount = $("#edit-wx").val();
			var borndate = $("#edit-borndate").val();
			var imgFile = $("#edit-photo").get(0).files[0];
			var address = $("#edit-address").val();
			var descInfo = $("#edit-descInfo").val();

			formData.append("id",id);
			formData.append("concatName",concatName);
			formData.append("gender",gender);
			formData.append("job",job);
			formData.append("telphone",telphone);
			formData.append("wxAccount",wxAccount);
			formData.append("borndate",borndate);
			formData.append("imgFile",imgFile);
			formData.append("address",address);
			formData.append("descInfo",descInfo);

			$.ajax({
				url:'workbench/concat/saveEditConcat.do',
				data:formData,
				type:'post',
				contentType:false,
				processData:false,
				cache:false,
				success:function (data){
					if (data.code=="1"){
						$("#editConcatModal").modal("hide")
						queryConcatByPage($("#demo_page").bs_pagination('getOption','currentPage'),$("#demo_page").bs_pagination('getOption','rowsPerPage'));
					}else {
						alert(data.message);
						$("#editCustomerModal").modal("show");
					}
				}
			});
		});

		//给删除按钮添加单击事件
		$("#deleteConcatBtn").click(function () {

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
					url:'workbench/concat/deleteConcat.do',
					data:ids,
					type:'post',
					dataType: "json",
					success:function (data){
						if(data.code=="1"){
							//刷新聊天记录列表,显示第一页数据,保持显示条数不变
							queryConcatByPage(1,$("#demo_page").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});


	});

	//封装函数
	function queryConcatByPage(pageNo,pageSize){

		//收集参数
		var username = $("#query-username").val();
		var concatName = $("#query-concatName").val();
		var custName = $("#query-custName").val();

		$.ajax({
			url:'workbench/concat/queryConcatByPage.do',
			data:{
				username:username,
				concatName:concatName,
				custName:custName,
				pageNo:pageNo,
				pageSize:pageSize
			},
			success:function (data){
				//显示联系人信息
				//遍历concatList,拼接所有数据
				var htmlStr="";
				$.each(data.concatList,function (index,obj){

					htmlStr+="<tr class=\"active\">";
					htmlStr+="<td><input type=\"checkbox\" value='"+obj.id+"' /></td>";
					htmlStr+="<td>"+obj.concatName+"</td>";
					htmlStr+="<td>"+obj.customer.custName+"</td>";
					if (obj.gender==1){
						htmlStr+="<td>男</td>";
					}
					if (obj.gender==2){
						htmlStr+="<td>女</td>";
					}
					htmlStr+="<td>"+obj.job+"</td>";
					htmlStr+="<td>"+obj.telphone+"</td>";
					htmlStr+="<td>"+obj.wxAccount+"</td>";
					htmlStr+="<td>"+obj.borndate+"</td>";
					htmlStr+="<td>"+obj.address+"</td>";
					htmlStr+="<td><p style='display: inline-block; overflow: hidden; text-overflow: ellipsis; width: 8em; white-space: nowrap;'>"+obj.photo+"</p></td>";
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
						queryConcatByPage(pageObj.currentPage,pageObj.rowsPerPage);
					}
				});
			}
		});

	}
	
</script>
</head>
<body>

	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createConcatModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="createConcatForm">
						<div class="form-group">
							<label for="create-concatName" class="col-sm-2 control-label">联系人姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-concatName">
							</div>
							<label for="create-gender" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-gender">
									<option value=""></option>
									<option value="1">男</option>
									<option value="2">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="create-custName" class="col-sm-2 control-label">老板<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-custName">
									<c:forEach items="${customerList}" var="customer">
										<option value="${customer.id}">${customer.custName}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
						</div>

						<div class="form-group">
							<label for="create-telphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-telphone">
							</div>
							<label for="create-wx" class="col-sm-2 control-label">微信</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-wx">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-borndate" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="create-borndate" readonly>
							</div>
							<label for="create-photo" class="col-sm-2 control-label">照片地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="file" class="form-control" id="create-photo">
							</div>
						</div>
						<div style="position: relative;top: 20px;">
							<div class="form-group">
								<label for="create-address" class="col-sm-2 control-label">详细地址</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="1" id="create-address"></textarea>
								</div>
							</div>
						</div>
						<div class="form-group" style="position: relative;">
							<label for="create-descInfo" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-descInfo"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCreateConcatBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editConcatModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-concatName" class="col-sm-2 control-label">联系人姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-concatName">
							</div>
							<label for="edit-gender" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-gender">
								  <option value=""></option>
								  <option value="1">男</option>
								  <option value="2">女</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-custName" class="col-sm-2 control-label">老板<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-custName">
									<c:forEach items="${customerList}" var="customer">
										<option value="${customer.id}">${customer.custName}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-telphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-telphone">
							</div>
							<label for="edit-wx" class="col-sm-2 control-label">微信</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-wx" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-borndate" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control myDate" id="edit-borndate" readonly>
							</div>
							<label for="edit-photo" class="col-sm-2 control-label">照片地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="file" class="form-control" id="edit-photo">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-address" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<textarea type="text" class="form-control" rows="1" id="edit-address"></textarea>
							</div>
							<label for="edit-createName" class="col-sm-2 control-label">创建者</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-createName" readonly>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-descInfo" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-descInfo"></textarea>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveEditConcatBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
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
				      		<div class="input-group-addon">联系人</div>
				      		<input class="form-control" type="text" id="query-concatName">
				    	</div>
				  	</div>
				  	<button type="button" class="btn btn-default" id="queryConcatBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createConcatBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editConcatBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteConcatBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>联系人</td>
							<td>客户名称</td>
							<td>性别</td>
							<td>岗位</td>
							<td>电话</td>
							<td>微信</td>
							<td>生日</td>
							<td>家庭住址</td>
							<td>照片地址</td>
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