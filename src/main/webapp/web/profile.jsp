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
        
        /* 地址卡片样式增强 */
        .address-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-color: #4CAF50;
        }
        
        .profile-section {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .profile-section h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
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
                                <div class="stat-number" id="orderCount">0</div>
                                <div class="stat-label">总订单数</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" id="totalAmount">¥0.00</div>
                                <div class="stat-label">消费总金额</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" id="userLevel">1</div>
                                <div class="stat-label">用户等级</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" id="points">0</div>
                                <div class="stat-label">积分</div>
                            </div>
                        </div>
                        
                        <div class="profile-section">
                            <h4>基本信息</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>登录名：</strong><span id="overviewLoginName">-</span></p>
                                    <p><strong>真实姓名：</strong><span id="overviewName">-</span></p>
                                    <p><strong>昵称：</strong><span id="overviewNickname">-</span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>手机号：</strong><span id="overviewPhone">-</span></p>
                                    <p><strong>邮箱：</strong><span id="overviewEmail">-</span></p>
                                    <p><strong>注册时间：</strong><span id="overviewRegisterTime">-</span></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="profile-section">
                            <h4>默认地址</h4>
                            <div id="defaultAddressInfo">
                                <p><strong>默认收货地址：</strong><span id="overviewDefaultAddress">暂未设置</span></p>
                                <small class="text-muted">您可以在"收货地址"页面管理您的地址信息</small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 个人信息 -->
                    <div id="profile" class="content-section">
                        <h3 class="section-title">个人信息</h3>
                        <form id="personal-info-form">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="loginName">登录名</label>
                                        <input type="text" class="form-control" id="loginName" readonly>
                                        <small class="text-muted">登录名不可修改</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="nickname">昵称</label>
                                        <input type="text" class="form-control" id="nickname" placeholder="请输入昵称">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="realName">真实姓名</label>
                                        <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone">手机号码</label>
                                        <input type="tel" class="form-control" id="phone" placeholder="请输入手机号码">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">邮箱地址</label>
                                        <input type="email" class="form-control" id="email" placeholder="请输入邮箱地址">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="avatar">头像URL</label>
                                        <input type="url" class="form-control" id="avatar" placeholder="请输入头像URL">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="registerTime">注册时间</label>
                                        <input type="text" class="form-control" id="registerTime" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lastLoginTime">最后登录时间</label>
                                        <input type="text" class="form-control" id="lastLoginTime" readonly>
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
                        <div class="empty-state">
                            <i class="fa fa-spinner fa-spin"></i>
                            <p>正在加载地址信息...</p>
                        </div>
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

        // 全局变量
        let currentUser = null;
        let addressList = [];
        
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
                
                // 根据不同页面加载相应数据
                if (section === 'overview') {
                    loadUserProfile();
                } else if (section === 'addresses') {
                    loadAddressList();
                }
            });
            
            // 模拟用户登录状态检查
            checkLoginStatus();
            
            // 默认加载用户概览
            loadUserProfile();
            
            // 预加载地址列表
            loadAddressList();
            
            // 绑定表单提交事件
            $('#personal-info-form').submit(function(e) {
                e.preventDefault();
                updateUserInfo();
            });
            
            $('#password-form').submit(function(e) {
                e.preventDefault();
                updatePassword();
            });
        });
        
        function checkLoginStatus() {
            // 这里应该检查用户的登录状态
            // 如果未登录，显示登录提示
            var isLoggedIn = true; // 模拟已登录状态
            
            if (!isLoggedIn) {
                $('#userName').text('未登录用户');
                // 可以添加登录提示或重定向到登录页面
            }
        }
        
        // 加载用户资料
        function loadUserProfile() {
            $.ajax({
                url: '/web/user?opt=profile',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0) {
                        currentUser = response.data;
                        updateUserProfileDisplay();
                    } else {
                        console.error('获取用户信息失败:', response.msg);
                    }
                },
                error: function() {
                    console.error('网络错误，无法获取用户信息');
                }
            });
        }
        
        // 更新用户资料显示
        function updateUserProfileDisplay() {
            if (!currentUser) return;
            
            // 更新侧边栏用户名
            $('#userName').text(currentUser.name || currentUser.nickname || currentUser.loginName || '用户');
            
            // 更新头像
            if (currentUser.avatar) {
                $('.user-avatar').html('<img src="' + currentUser.avatar + '" style="width:100%;height:100%;border-radius:50%;object-fit:cover;">');
            }
            
            // 更新概览页面统计信息
            $('#orderCount').text(currentUser.orderCount || 0);
            $('#totalAmount').text('¥' + (currentUser.totalAmount || 0).toFixed(2));
            $('#userLevel').text(currentUser.userLevel || 1);
            $('#points').text(currentUser.points || 0);
            
            // 更新概览页面基本信息
            $('#overviewLoginName').text(currentUser.loginName || '-');
            $('#overviewName').text(currentUser.name || '-');
            $('#overviewNickname').text(currentUser.nickname || '-');
            $('#overviewPhone').text(currentUser.phone || '-');
            $('#overviewEmail').text(currentUser.email || '-');
            $('#overviewRegisterTime').text(formatDate(currentUser.registerTime) || '-');
            
            // 更新默认地址信息
            if (currentUser.address && currentUser.address.trim() !== '') {
                $('#overviewDefaultAddress').text(currentUser.address);
            } else {
                $('#overviewDefaultAddress').text('暂未设置');
            }
            
            // 更新个人信息表单
            $('#loginName').val(currentUser.loginName || '');
            $('#nickname').val(currentUser.nickname || '');
            $('#realName').val(currentUser.name || '');
            $('#phone').val(currentUser.phone || '');
            $('#email').val(currentUser.email || '');
            $('#avatar').val(currentUser.avatar || '');
            $('#registerTime').val(formatDate(currentUser.registerTime) || '');
            $('#lastLoginTime').val(formatDate(currentUser.lastLoginTime) || '');
        }
        
        // 格式化日期
        function formatDate(dateStr) {
            if (!dateStr) return '';
            try {
                var date = new Date(dateStr);
                return date.getFullYear() + '-' + 
                       String(date.getMonth() + 1).padStart(2, '0') + '-' + 
                       String(date.getDate()).padStart(2, '0') + ' ' +
                       String(date.getHours()).padStart(2, '0') + ':' + 
                       String(date.getMinutes()).padStart(2, '0');
            } catch (e) {
                return dateStr;
            }
        }
        
        // 加载收货地址列表
        function loadAddressList() {
            $.ajax({
                url: '/web/address?opt=list',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    if (data.code === 0) {
                        addressList = data.data || [];
                        renderAddressList();
                    } else {
                        console.error('获取地址列表失败:', data.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                }
            });
        }
        
        // 渲染地址列表
        function renderAddressList() {
            var addressContainer = $('#addresses');
            if (!addressContainer.length) return;
            
            var html = '<h3 class="section-title">收货地址</h3>';
            
            if (addressList.length === 0) {
                html += '<div class="empty-state"><i class="fa fa-map-marker"></i><p>暂无收货地址</p></div>';
            } else {
                addressList.forEach(function(address) {
                    var isDefault = address.isDefault ? ' default' : '';
                    html += '<div class="address-card' + isDefault + '" data-id="' + address.id + '">';
                    html += '  <div class="address-header">';
                    html += '    <span class="address-name">' + address.receiverName + '</span>';
                    if (address.isDefault) {
                        html += '    <span class="default-badge">默认地址</span>';
                    }
                    html += '  </div>';
                    html += '  <div class="address-details">';
                    html += '    手机号码：' + address.phone + '<br>';
                    html += '    收货地址：' + address.fullAddress + '<br>';
                    html += '    邮政编码：' + (address.zipCode || '000000');
                    html += '  </div>';
                    html += '  <div class="address-actions">';
                    html += '    <button class="btn btn-sm btn-primary" onclick="editAddress(' + address.id + ')">编辑</button>';
                    if (!address.isDefault) {
                        html += '    <button class="btn btn-sm btn-default" onclick="setDefaultAddress(' + address.id + ')">设为默认</button>';
                    }
                    html += '    <button class="btn btn-sm btn-default" onclick="deleteAddress(' + address.id + ')">删除</button>';
                    html += '  </div>';
                    html += '</div>';
                });
            }
            
            html += '<button class="btn btn-primary" onclick="addNewAddress()"><i class="fa fa-plus"></i> 添加新地址</button>';
            addressContainer.html(html);
        }
        
        // 设置默认地址
        function setDefaultAddress(addressId) {
            // 先找到要设置为默认的地址信息
            var selectedAddress = addressList.find(function(addr) {
                return addr.id == addressId;
            });
            
            if (!selectedAddress) {
                alert('地址信息不存在');
                return;
            }
            
            $.ajax({
                url: '/web/address?opt=setDefault&id=' + addressId,
                type: 'POST',
                dataType: 'json',
                success: function(data) {
                    if (data.code === 0) {
                        // 设置默认地址成功后，更新用户表的address字段
                        updateUserDefaultAddress(selectedAddress.fullAddress);
                        alert('设置默认地址成功');
                        loadAddressList(); // 重新加载地址列表
                        loadUserProfile(); // 重新加载用户信息以更新概览页面
                    } else {
                        alert('设置失败: ' + data.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    alert('设置失败');
                }
            });
        }
        
        // 更新用户默认地址到用户表
        function updateUserDefaultAddress(addressText) {
            $.ajax({
                url: '/web/user',
                type: 'POST',
                data: {
                    opt: 'updateDefaultAddress',
                    address: addressText
                },
                dataType: 'json',
                success: function(response) {
                    console.log('用户默认地址更新成功');
                },
                error: function() {
                    console.error('更新用户默认地址失败');
                }
            });
        }
        
        // 编辑地址
        function editAddress(addressId) {
            // 找到要编辑的地址
            var address = addressList.find(function(addr) {
                return addr.id == addressId;
            });
            
            if (!address) {
                alert('地址信息不存在');
                return;
            }
            
            var receiverName = prompt('请输入收货人姓名:', address.receiverName);
            if (receiverName === null) return; // 用户取消
            
            var phone = prompt('请输入手机号码:', address.phone);
            if (phone === null) return;
            
            var fullAddress = prompt('请输入详细地址:', address.fullAddress);
            if (fullAddress === null) return;
            
            var zipCode = prompt('请输入邮政编码:', address.zipCode || '000000');
            if (zipCode === null) return;
            
            $.ajax({
                url: '/web/address?opt=update',
                type: 'POST',
                data: {
                    id: addressId,
                    receiverName: receiverName,
                    phone: phone,
                    fullAddress: fullAddress,
                    zipCode: zipCode
                },
                dataType: 'json',
                success: function(data) {
                    if (data.code === 0) {
                        alert('修改地址成功');
                        loadAddressList(); // 重新加载地址列表
                        // 如果修改的是默认地址，同时更新用户表的address字段
                        if (address.isDefault) {
                            updateUserDefaultAddress(fullAddress);
                            loadUserProfile(); // 重新加载用户信息以更新概览页面
                        }
                    } else {
                        alert('修改失败: ' + data.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    alert('修改失败');
                }
            });
        }
        
        // 删除地址
        function deleteAddress(addressId) {
            if (!confirm('确定要删除这个地址吗？')) {
                return;
            }
            
            $.ajax({
                url: '/web/address?opt=delete&id=' + addressId,
                type: 'POST',
                dataType: 'json',
                success: function(data) {
                    if (data.code === 0) {
                        alert('删除成功');
                        loadAddressList(); // 重新加载地址列表
                    } else {
                        alert('删除失败: ' + data.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    alert('删除失败');
                }
            });
        }
        
        // 添加新地址
        function addNewAddress() {
            var receiverName = prompt('请输入收货人姓名:');
            if (!receiverName) return;
            
            var phone = prompt('请输入手机号码:');
            if (!phone) return;
            
            var fullAddress = prompt('请输入详细地址:');
            if (!fullAddress) return;
            
            var zipCode = prompt('请输入邮政编码(可选):') || '000000';
            
            $.ajax({
                url: '/web/address?opt=add',
                type: 'POST',
                data: {
                    receiverName: receiverName,
                    phone: phone,
                    fullAddress: fullAddress,
                    zipCode: zipCode
                },
                dataType: 'json',
                success: function(data) {
                    if (data.code === 0) {
                        alert('添加地址成功');
                        loadAddressList(); // 重新加载地址列表
                    } else {
                        alert('添加失败: ' + data.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    alert('添加失败');
                }
            });
        }
        
        // 更新个人信息
        function updateUserInfo() {
            var formData = {
                opt: 'update',
                name: $('#realName').val(),
                nickname: $('#nickname').val(),
                avatar: $('#avatar').val(),
                email: $('#email').val(),
                phone: $('#phone').val()
            };
            
            $.ajax({
                url: '/web/user',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0) {
                        alert('个人信息更新成功！');
                        loadUserProfile(); // 重新加载用户资料
                    } else {
                        alert('更新失败：' + response.msg);
                    }
                },
                error: function() {
                    alert('网络错误，请稍后重试');
                }
            });
        }
        
        // 修改密码
        function updatePassword() {
            var oldPassword = $('#currentPassword').val();
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();
            
            if (!oldPassword || !newPassword || !confirmPassword) {
                alert('请填写完整的密码信息');
                return;
            }
            
            if (newPassword !== confirmPassword) {
                alert('两次输入的新密码不一致');
                return;
            }
            
            if (newPassword.length < 6) {
                alert('新密码长度不能少于6位');
                return;
            }
            
            var formData = {
                opt: 'updatePassword',
                oldPassword: oldPassword,
                newPassword: newPassword,
                confirmNewPassword: confirmPassword
            };
            
            $.ajax({
                url: '/web/user',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0) {
                        alert('密码修改成功，请重新登录');
                        // 清空密码框
                        $('#oldPassword').val('');
                        $('#newPassword').val('');
                        $('#confirmPassword').val('');
                        // 可以考虑跳转到登录页面
                        window.location.href = '/web/login';
                    } else {
                        alert('密码修改失败：' + response.msg);
                    }
                },
                error: function() {
                    alert('网络错误，请稍后重试');
                }
            });
        }
        
        // 表单提交处理
        $('form').submit(function(e) {
            e.preventDefault();
            // 已在上面具体处理
        });
        
        // 按钮点击处理
        $('.btn').click(function(e) {
            if ($(this).attr('type') !== 'submit' && !$(this).attr('onclick')) {
                e.preventDefault();
                alert('功能开发中，敬请期待！');
            }
        });
    </script>
</body>
</html>