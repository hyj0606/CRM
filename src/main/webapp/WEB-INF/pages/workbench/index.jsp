<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>"><%--根路径--%>
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

	//页面加载完毕
	$(function(){
		
		//导航中所有文本颜色为黑色
		$(".liClass > a").css("color" , "black");
		
		//默认选中导航菜单中的第一个菜单项
		$(".liClass:first").addClass("active");
		
		//第一个菜单项的文字变成白色
		$(".liClass:first > a").css("color" , "white");
		
		//给所有的菜单项注册鼠标单击事件
		$(".liClass").click(function(){
			//移除所有菜单项的激活状态
			$(".liClass").removeClass("active");
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");
			//当前项目被选中
			$(this).addClass("active");
			//当前项目颜色变成白色
			$(this).children("a").css("color","white");
		});
		
		
		window.open("workbench/main/index.do","workareaFrame");

		//给个人资料按钮添加单击事件
		$("#editUserBtn").click(function (){
			//弹出创建市场活动的模态窗口
			$("#editUserModal").modal("show");
		});

		$("#updateUserBtn").click(function (){
			//收集参数
			var password = $("#password").val();
			var telphone = $.trim($("#telphone").val());
			var email = $("#email").val();
			var address = $("#address").val();

			//发送请求
			$.ajax({
				url:'workbench/update/index.do',
				data:{
					password:password,
					telphone:telphone,
					email:email,
					address:address
				},
				type:'post',
				dataType:'json',
				success:function (data){
					if (data.code=="1"){
						if (data.retData==1){
							//关闭模态窗口
							$("#editUserModal").modal("hide");
						}else {
							//关闭模态窗口
							$("#editUserModal").modal("hide");
							window.location.href="settings/qx/user/logout.do"
						}

					}else {
						//提示信息
						alert(data.message);
						//模态从窗口不关闭
						$("#editUserModal").modal("show");//可以不写
					}
				}
			});
		});

		//给确定按钮添加单击事件
		$("#logoutBtn").click(function (){
			//发送同步请求
			window.location.href="settings/qx/user/logout.do";
		});
		
	});
	
</script>

</head>
<body>

	<!-- 个人资料 模态窗口 -->
	<div class="modal fade" id="editUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">个人资料</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="username" style="width: 200%;" value="${sessionScope.sessionUser.username}" readonly>
							</div>
							<label for="password" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="password" style="width: 200%;" value="${sessionScope.sessionUser.password}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="telphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="telphone" style="width: 200%;" value="${sessionScope.sessionUser.telphone}">
							</div>
							<label for="email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="email" style="width: 200%;" value="${sessionScope.sessionUser.email}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="address" class="col-sm-2 control-label">地址</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="address" style="width: 200%;" value="${sessionScope.sessionUser.address}">
							</div>
							<label for="lastLoginTime" class="col-sm-2 control-label">登录时间</label>
							<div class="col-sm-10" style="width: 150px;">
								<input type="text" class="form-control" id="lastLoginTime" style="width: 200%;" value="${sessionScope.sessionUser.lastLoginTime}" readonly>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="updateUserBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="logoutBtn">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;"></span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> ${sessionScope.sessionUser.username} <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="settings/index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal" id="editUserBtn"><span class="glyphicon glyphicon-edit"></span> 个人资料</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 15%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="workbench/main/index.do" target="workareaFrame"><span class="glyphicon glyphicon-home"></span> 客户公海</a></li>
				<li class="liClass"><a href="workbench/customer/index.do" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 客户</a></li>
				<li class="liClass"><a href="workbench/chats/index.do" target="workareaFrame"><span class="glyphicon glyphicon-play-circle"></span> 客户聊天记录</a></li>
				<li class="liClass"><a href="workbench/concat/index.do" target="workareaFrame"><span class="glyphicon glyphicon-earphone"></span> 联系人</a></li>
				<li class="liClass"><a href="workbench/business/index.do" target="workareaFrame"><span class="glyphicon glyphicon-search"></span> 商机管理</a></li>
				<li class="liClass"><a href="workbench/sale/index.do" target="workareaFrame"><span class="glyphicon glyphicon-usd"></span> 销售记录 </a></li>
				<li class="liClass">
					<a href="#no2" class="collapsed" data-toggle="collapse"><span class="glyphicon glyphicon-stats"></span> 供应商 </a>
					<ul id="no2" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="workbench/supply/provider/index.do" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 供应商</a></li>
						<li class="liClass"><a href="workbench/supply/goods/index.do" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 商品</a></li>
					</ul>
				</li>
			</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作台 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>

	<%--分割线--%>
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
</body>
</html>