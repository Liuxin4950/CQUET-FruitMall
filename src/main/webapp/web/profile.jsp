<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心 - 向日葵水果</title>
    <meta name="description" content="向日葵水果 - 个人中心，管理您的个人信息和订单">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .profile-container {
            padding: 40px 0;
            min-height: 600px;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
        }
        
        .profile-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .profile-sidebar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 0;
            overflow: hidden;
        }
        
        .sidebar-header {
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .user-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 2rem;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar-menu li {
            border-bottom: 1px solid #ecf0f1;
        }
        
        .sidebar-menu li:last-child {
            border-bottom: none;
        }
        
        .sidebar-menu a {
            display: block;
            padding: 15px 20px;
            color: #2c3e50;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background-color: #f8f9fa;
            color: #ff9a56;
            text-decoration: none;
        }
        
        .sidebar-menu i {
            margin-right: 10px;
            width: 20px;
        }
        
        .profile-content {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .content-section {
            display: none;
        }
        
        .content-section.active {
            display: block;
        }
        
        .section-title {
            color: #2c3e50;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #ecf0f1;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            color: #2c3e50;
            font-weight: 500;
            margin-bottom: 8px;
        }
        
        .form-control {
            border: 2px solid #ecf0f1;
            border-radius: 8px;
            padding: 12px 15px;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #ff9a56;
            box-shadow: 0 0 0 0.2rem rgba(255, 154, 86, 0.25);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 154, 86, 0.4);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .stat-label {
            opacity: 0.9;
        }
        
        .order-item {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #ff9a56;
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .order-number {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .order-status {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-processing {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-shipped {
            background-color: #cce7ff;
            color: #004085;
        }
        
        .order-details {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .address-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            border: 2px solid transparent;
            transition: border-color 0.3s ease;
        }
        
        .address-card.default {
            border-color: #ff9a56;
        }
        
        .address-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .address-name {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .default-badge {
            background-color: #ff9a56;
            color: white;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
        }
        
        .address-details {
            color: #7f8c8d;
            line-height: 1.6;
        }
        
        .address-actions {
            margin-top: 15px;
        }
        
        .btn-sm {
            padding: 5px 15px;
            font-size: 0.9rem;
            margin-right: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        @media (max-width: 768px) {
            .profile-header h1 {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>
    
    <!-- 面包屑导航 -->
    <div class="container">
        <ol class="breadcrumb">
            <li><a href="${ctx}/web/index.jsp">首页</a></li>
            <li class="active">个人中心</li>
        </ol>
    </div>
    
    <!-- 个人中心头部 -->
    <div class="profile-header">
        <div class="container">
            <h1><i class="fa fa-user-circle"></i> 个人中心</h1>
            <p>管理您的个人信息和订单</p>
        </div>
    </div>
    
    <div class="container profile-container">
        <div class="row">
            <!-- 侧边栏 -->
            <div class="col-md-3">
                <div class="profile-sidebar">
                    <div class="sidebar-header">
                        <div class="user-avatar">
                            <i class="fa fa-user"></i>
                        </div>
                        <h4 id="userName">游客用户</h4>
                        <p>欢迎回来！</p>
                    </div>
                    <ul class="sidebar-menu">
                        <li><a href="#" class="menu-item active" data-section="overview"><i class="fa fa-dashboard"></i> 概览</a></li>
                        <li><a href="#" class="menu-item" data-section="profile"><i class="fa fa-user"></i> 个人信息</a></li>
                        <li><a href="#" class="menu-item" data-section="orders"><i class="fa fa-shopping-bag"></i> 我的订单</a></li>
                        <li><a href="#" class="menu-item" data-section="addresses"><i class="fa fa-map-marker"></i> 收货地址</a></li>
                        <li><a href="#" class="menu-item" data-section="security"><i class="fa fa-shield"></i> 安全设置</a></li>
                    </ul>
                </div>
            </div>
            
            <!-- 主要内容 -->
            <div class="col-md-9">
                <div class="profile-content">
                    <!-- 概览 -->
                    <div id="overview" class="content-section active">
                        <h3 class="section-title">账户概览</h3>
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-number">12</div>
                                <div class="stat-label">总订单数</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">3</div>
                                <div class="stat-label">待收货</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">¥1,280</div>
                                <div class="stat-label">累计消费</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">85</div>
                                <div class="stat-label">积分余额</div>
                            </div>
                        </div>
                        
                        <h4>最近订单</h4>
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-number">订单号：SF202312150001</span>
                                <span class="order-status status-shipped">配送中</span>
                            </div>
                            <div class="order-details">
                                商品：赣南脐橙 5斤装 + 烟台红富士 3斤装<br>
                                下单时间：2023-12-15 14:30<br>
                                订单金额：¥128.00
                            </div>
                        </div>
                        
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-number">订单号：SF202312140002</span>
                                <span class="order-status status-completed">已完成</span>
                            </div>
                            <div class="order-details">
                                商品：海南芒果 2斤装<br>
                                下单时间：2023-12-14 10:15<br>
                                订单金额：¥68.00
                            </div>
                        </div>
                    </div>
                    
                    <!-- 个人信息 -->
                    <div id="profile" class="content-section">
                        <h3 class="section-title">个人信息</h3>
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="nickname">昵称</label>
                                        <input type="text" class="form-control" id="nickname" value="水果爱好者">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="realName">真实姓名</label>
                                        <input type="text" class="form-control" id="realName" value="张三">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone">手机号码</label>
                                        <input type="tel" class="form-control" id="phone" value="138****8888">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">邮箱地址</label>
                                        <input type="email" class="form-control" id="email" value="user@example.com">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="gender">性别</label>
                                        <select class="form-control" id="gender">
                                            <option value="">请选择</option>
                                            <option value="male" selected>男</option>
                                            <option value="female">女</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="birthday">生日</label>
                                        <input type="date" class="form-control" id="birthday" value="1990-01-01">
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">保存修改</button>
                        </form>
                    </div>
                    
                    <!-- 我的订单 -->
                    <div id="orders" class="content-section">
                        <h3 class="section-title">我的订单</h3>
                        
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-number">订单号：SF202312150001</span>
                                <span class="order-status status-shipped">配送中</span>
                            </div>
                            <div class="order-details">
                                商品：赣南脐橙 5斤装 + 烟台红富士 3斤装<br>
                                下单时间：2023-12-15 14:30<br>
                                订单金额：¥128.00<br>
                                收货地址：北京市朝阳区xxx小区xxx号楼xxx室
                            </div>
                        </div>
                        
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-number">订单号：SF202312140002</span>
                                <span class="order-status status-completed">已完成</span>
                            </div>
                            <div class="order-details">
                                商品：海南芒果 2斤装<br>
                                下单时间：2023-12-14 10:15<br>
                                订单金额：¥68.00<br>
                                收货地址：北京市朝阳区xxx小区xxx号楼xxx室
                            </div>
                        </div>
                        
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-number">订单号：SF202312130003</span>
                                <span class="order-status status-processing">处理中</span>
                            </div>
                            <div class="order-details">
                                商品：新疆葡萄 2斤装 + 陕西猕猴桃 1斤装<br>
                                下单时间：2023-12-13 16:45<br>
                                订单金额：¥95.00<br>
                                收货地址：北京市朝阳区xxx小区xxx号楼xxx室
                            </div>
                        </div>
                    </div>
                    
                    <!-- 收货地址 -->
                    <div id="addresses" class="content-section">
                        <h3 class="section-title">收货地址</h3>
                        
                        <div class="address-card default">
                            <div class="address-header">
                                <span class="address-name">张三</span>
                                <span class="default-badge">默认地址</span>
                            </div>
                            <div class="address-details">
                                手机号码：138****8888<br>
                                收货地址：北京市朝阳区xxx小区xxx号楼xxx室<br>
                                邮政编码：100000
                            </div>
                            <div class="address-actions">
                                <button class="btn btn-sm btn-primary">编辑</button>
                                <button class="btn btn-sm btn-default">删除</button>
                            </div>
                        </div>
                        
                        <div class="address-card">
                            <div class="address-header">
                                <span class="address-name">李四</span>
                            </div>
                            <div class="address-details">
                                手机号码：139****9999<br>
                                收货地址：上海市浦东新区yyy路yyy号<br>
                                邮政编码：200000
                            </div>
                            <div class="address-actions">
                                <button class="btn btn-sm btn-primary">编辑</button>
                                <button class="btn btn-sm btn-default">设为默认</button>
                                <button class="btn btn-sm btn-default">删除</button>
                            </div>
                        </div>
                        
                        <button class="btn btn-primary"><i class="fa fa-plus"></i> 添加新地址</button>
                    </div>
                    
                    <!-- 安全设置 -->
                    <div id="security" class="content-section">
                        <h3 class="section-title">安全设置</h3>
                        
                        <form>
                            <div class="form-group">
                                <label for="currentPassword">当前密码</label>
                                <input type="password" class="form-control" id="currentPassword" placeholder="请输入当前密码">
                            </div>
                            <div class="form-group">
                                <label for="newPassword">新密码</label>
                                <input type="password" class="form-control" id="newPassword" placeholder="请输入新密码">
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">确认新密码</label>
                                <input type="password" class="form-control" id="confirmPassword" placeholder="请再次输入新密码">
                            </div>
                            <button type="submit" class="btn btn-primary">修改密码</button>
                        </form>
                        
                        <hr style="margin: 40px 0;">
                        
                        <h4>账户安全</h4>
                        <div class="form-group">
                            <label>手机验证</label>
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <span class="text-success"><i class="fa fa-check-circle"></i> 已绑定：138****8888</span>
                                <button class="btn btn-sm btn-default">更换手机号</button>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>邮箱验证</label>
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <span class="text-success"><i class="fa fa-check-circle"></i> 已绑定：user@example.com</span>
                                <button class="btn btn-sm btn-default">更换邮箱</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        $(document).ready(function() {
            // 侧边栏菜单切换
            $('.menu-item').click(function(e) {
                e.preventDefault();
                
                // 移除所有活动状态
                $('.menu-item').removeClass('active');
                $('.content-section').removeClass('active');
                
                // 添加当前活动状态
                $(this).addClass('active');
                
                // 显示对应内容
                var section = $(this).data('section');
                $('#' + section).addClass('active');
            });
            
            // 模拟用户登录状态检查
            checkLoginStatus();
        });
        
        function checkLoginStatus() {
            // 这里应该检查用户的登录状态
            // 如果未登录，显示登录提示
            var isLoggedIn = false; // 模拟未登录状态
            
            if (!isLoggedIn) {
                $('#userName').text('未登录用户');
                // 可以添加登录提示或重定向到登录页面
            }
        }
        
        // 表单提交处理
        $('form').submit(function(e) {
            e.preventDefault();
            alert('功能开发中，敬请期待！');
        });
        
        // 按钮点击处理
        $('.btn').click(function(e) {
            if ($(this).attr('type') !== 'submit') {
                e.preventDefault();
                alert('功能开发中，敬请期待！');
            }
        });
    </script>
</body>
</html>