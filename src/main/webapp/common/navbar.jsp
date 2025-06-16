<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("ctx", request.getContextPath());%>

<!-- Bootstrap 原生导航栏 -->
<nav class="navbar navbar-default navbar-fixed-top" id="navbar">
    <div class="container">
        <!-- 品牌和切换按钮 -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar-collapse" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${ctx}/web/index.jsp">
                <i class="fa fa-sun-o"></i> 向日葵水果
            </a>
        </div>

        <!-- 导航链接和其他内容 -->
        <div class="collapse navbar-collapse" id="bs-navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="<%= request.getRequestURI().contains("/web/index.jsp") ? "active" : "" %>">
                    <a href="${ctx}/web/index.jsp"><i class="fa fa-home"></i> 首页</a>
                </li>
                <li class="dropdown <%= request.getRequestURI().contains("/web/category") ? "active" : "" %>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-apple"></i> 水果分类 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/web/category.jsp?type=citrus"><i class="fa fa-circle-o"></i> 柑橘类</a></li>
                        <li><a href="${ctx}/web/category.jsp?type=berry"><i class="fa fa-circle-o"></i> 浆果类</a></li>
                        <li><a href="${ctx}/web/category.jsp?type=tropical"><i class="fa fa-circle-o"></i> 热带水果</a></li>
                        <li><a href="${ctx}/web/category.jsp?type=stone"><i class="fa fa-circle-o"></i> 核果类</a></li>
                        <li><a href="${ctx}/web/category.jsp?type=melon"><i class="fa fa-circle-o"></i> 瓜果类</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/web/category.jsp"><i class="fa fa-th"></i> 全部分类</a></li>
                    </ul>
                </li>
                <li class="<%= request.getRequestURI().contains("/web/fresh") ? "active" : "" %>">
                    <a href="${ctx}/web/fresh.jsp"><i class="fa fa-leaf"></i> 新鲜直达</a>
                </li>
                <li class="<%= request.getRequestURI().contains("/web/seasonal") ? "active" : "" %>">
                    <a href="${ctx}/web/seasonal.jsp"><i class="fa fa-calendar"></i> 时令水果</a>
                </li>
                <li class="<%= request.getRequestURI().contains("/web/gift") ? "active" : "" %>">
                    <a href="${ctx}/web/gift.jsp"><i class="fa fa-gift"></i> 礼品装</a>
                </li>
                <li class="<%= request.getRequestURI().contains("/web/about") ? "active" : "" %>">
                    <a href="${ctx}/web/about.jsp"><i class="fa fa-info-circle"></i> 关于我们</a>
                </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right">
                <% 
                    String userInfo = (String) session.getAttribute("loginName");
                    String userType = (String) session.getAttribute("userType");
                    if (userInfo != null) {
                %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-user"></i> <%= userInfo %>
                            <% if ("admin".equals(userType)) { %>
                                <span class="label label-warning">管理员</span>
                            <% } %>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <% if ("admin".equals(userType)) { %>
                                <li><a href="${ctx}/admin/index.jsp"><i class="fa fa-cog"></i> 管理后台</a></li>
                                <li role="separator" class="divider"></li>
                            <% } else { %>
                                <li class="<%= request.getRequestURI().contains("/web/profile") ? "active" : "" %>">
                                    <a href="${ctx}/web/profile.jsp"><i class="fa fa-user-circle"></i> 个人中心</a>
                                </li>
                                <li class="<%= request.getRequestURI().contains("/web/orders") ? "active" : "" %>">
                                    <a href="${ctx}/web/orders.jsp"><i class="fa fa-list-alt"></i> 我的订单</a>
                                </li>
                                <li role="separator" class="divider"></li>
                            <% } %>
                            <li><a href="#" onclick="logout()"><i class="fa fa-sign-out"></i> 退出登录</a></li>
                        </ul>
                    </li>
                    <% if (!"admin".equals(userType)) { %>
                        <li class="<%= request.getRequestURI().contains("/web/cart") ? "active" : "" %>">
                            <a href="${ctx}/web/cart.jsp" class="cart-link">
                                <i class="fa fa-shopping-cart"></i> 购物车
                                <span class="badge cart-badge" id="cart-count">0</span>
                            </a>
                        </li>
                    <% } %>
                <% } else { %>
                    <li class="<%= request.getRequestURI().contains("/login.jsp") ? "active" : "" %>">
                        <a href="${ctx}/login.jsp"><i class="fa fa-sign-in"></i> 登录</a>
                    </li>
                    <li class="<%= request.getRequestURI().contains("/register.jsp") ? "active" : "" %>">
                        <a href="${ctx}/register.jsp"><i class="fa fa-user-plus"></i> 注册</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<style>
    /* 自定义导航栏样式 */
    .navbar-default {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 50%, #2c3e50 100%);
        border: none;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        min-height: 65px;
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
    }
    
    .navbar-default .navbar-brand {
        color: #ecf0f1;
        font-weight: bold;
        font-size: 22px;
        padding: 20px 15px;
        transition: all 0.3s ease;
        text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        position: relative;
    }
    
    .navbar-default .navbar-brand:hover,
    .navbar-default .navbar-brand:focus {
        color: #f39c12;
        text-decoration: none;
        transform: scale(1.05);
    }
    
    .navbar-default .navbar-brand i {
        margin-right: 8px;
        color: #f39c12;
        text-shadow: 0 0 10px rgba(243, 156, 18, 0.5);
        animation: sunGlow 2s ease-in-out infinite alternate;
    }
    
    @keyframes sunGlow {
        from { text-shadow: 0 0 10px rgba(243, 156, 18, 0.5); }
        to { text-shadow: 0 0 20px rgba(243, 156, 18, 0.8), 0 0 30px rgba(243, 156, 18, 0.3); }
    }
    
    .navbar-default .navbar-nav > li > a {
        color: #ecf0f1;
        transition: all 0.3s ease;
        padding: 20px 18px;
        border-radius: 0;
        position: relative;
        font-weight: 500;
        text-shadow: 0 1px 2px rgba(0,0,0,0.2);
    }
    
    .navbar-default .navbar-nav > li > a::before {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        width: 0;
        height: 3px;
        background: linear-gradient(90deg, #f39c12, #e67e22);
        transition: all 0.3s ease;
        transform: translateX(-50%);
    }
    
    .navbar-default .navbar-nav > li > a:hover,
    .navbar-default .navbar-nav > li > a:focus {
        color: #f39c12;
        background-color: rgba(52, 73, 94, 0.8);
        transform: translateY(-2px);
    }
    
    .navbar-default .navbar-nav > li > a:hover::before {
        width: 80%;
    }
    
    .navbar-default .navbar-nav > .active > a,
    .navbar-default .navbar-nav > .active > a:hover,
    .navbar-default .navbar-nav > .active > a:focus {
        color: #f39c12;
        background-color: rgba(52, 73, 94, 0.9);
    }
    
    .navbar-default .navbar-nav > .active > a::before {
        width: 100%;
    }
    
    /* 下拉菜单样式优化 */
    .navbar-default .navbar-nav > .dropdown > a .caret {
        border-top-color: #ecf0f1;
        border-bottom-color: #ecf0f1;
        transition: all 0.3s ease;
        margin-left: 6px;
    }
    
    .navbar-default .navbar-nav > .open > a,
    .navbar-default .navbar-nav > .open > a:hover,
    .navbar-default .navbar-nav > .open > a:focus {
        color: #f39c12;
        background-color: rgba(52, 73, 94, 0.9);
    }
    
    .navbar-default .navbar-nav > .open > a .caret {
        transform: rotate(180deg);
        border-top-color: #f39c12;
        border-bottom-color: #f39c12;
    }
    
    /* 下拉菜单美化 */
    .dropdown-menu {
        background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
        border: 1px solid rgba(243, 156, 18, 0.3);
        border-radius: 8px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.25);
        margin-top: 2px;
        animation: fadeInDown 0.3s ease;
        backdrop-filter: blur(10px);
    }
    
    .dropdown-menu > li > a {
        color: #ecf0f1;
        padding: 12px 20px;
        transition: all 0.3s ease;
        border-radius: 6px;
        margin: 2px 6px;
        position: relative;
        overflow: hidden;
    }
    
    .dropdown-menu > li > a::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(243, 156, 18, 0.2), transparent);
        transition: left 0.5s ease;
    }
    
    .dropdown-menu > li > a:hover,
    .dropdown-menu > li > a:focus {
        color: #f39c12;
        background-color: rgba(243, 156, 18, 0.1);
        transform: translateX(5px);
    }
    
    .dropdown-menu > li > a:hover::before {
        left: 100%;
    }
    
    .dropdown-menu > .active > a,
    .dropdown-menu > .active > a:hover,
    .dropdown-menu > .active > a:focus {
        color: #f39c12;
        background-color: rgba(243, 156, 18, 0.2);
    }
    
    .dropdown-menu .divider {
        background: linear-gradient(90deg, transparent, rgba(243, 156, 18, 0.5), transparent);
        margin: 8px 0;
        height: 1px;
    }
    
    /* 购物车徽章样式 */
    .cart-badge {
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: white;
        border-radius: 12px;
        padding: 2px 8px;
        font-size: 11px;
        font-weight: bold;
        margin-left: 5px;
        min-width: 18px;
        text-align: center;
        box-shadow: 0 2px 4px rgba(231, 76, 60, 0.3);
        animation: pulse 2s infinite;
        position: relative;
        top: -2px;
    }
    
    .cart-badge:empty {
        display: none;
    }
    
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }
    
    .cart-link:hover .cart-badge {
        background: linear-gradient(135deg, #f39c12, #e67e22);
        animation: bounce 0.6s ease;
    }
    
    @keyframes bounce {
        0%, 20%, 60%, 100% { transform: translateY(-2px) scale(1); }
        40% { transform: translateY(-6px) scale(1.1); }
        80% { transform: translateY(-2px) scale(1.05); }
    }
    
    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translate3d(0, -10px, 0);
        }
        to {
            opacity: 1;
            transform: translate3d(0, 0, 0);
        }
    }
    
    /* 汉堡菜单按钮样式 */
    .navbar-default .navbar-toggle {
        border-color: #34495e;
        background-color: transparent;
        padding: 6px 10px;
        margin: 13px 15px 13px 0;
        border-radius: 4px;
        transition: all 0.3s ease;
    }
    
    .navbar-default .navbar-toggle:hover,
    .navbar-default .navbar-toggle:focus {
        background-color: #34495e;
        border-color: #3498db;
    }
    
    .navbar-default .navbar-toggle .icon-bar {
        background-color: #ecf0f1;
        width: 22px;
        height: 2px;
        border-radius: 1px;
        transition: all 0.3s ease;
    }
    
    .navbar-default .navbar-toggle:hover .icon-bar {
        background-color: #3498db;
    }
    
    /* 手机端布局优化 */
    @media (max-width: 767px) {
        .navbar-default {
            min-height: 50px;
        }
        
        .navbar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            min-height: 50px;
        }
        
        .navbar-header .navbar-toggle {
            position: static;
            float: none;
            margin: 8px 0 8px 15px;
            order: 1;
        }
        
        .navbar-header .navbar-brand {
            order: 2;
            margin: 0;
            padding: 15px 15px 15px 0;
            font-size: 18px;
        }
        
        /* 折叠菜单样式优化 */
        .navbar-collapse {
            clear: both;
            width: 100%;
            margin-top: 0;
            border-top: 1px solid #34495e;
            background-color: #2c3e50;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.1);
        }
        
        .navbar-collapse.in {
            overflow-y: visible;
        }
        
        .navbar-collapse.collapsing {
            overflow-y: hidden;
        }
        
        .navbar-collapse .navbar-nav {
            margin: 0;
        }
        
        .navbar-collapse .navbar-nav > li {
            border-bottom: 1px solid #34495e;
        }
        
        .navbar-collapse .navbar-nav > li:last-child {
            border-bottom: none;
        }
        
        .navbar-collapse .navbar-nav > li > a {
            padding: 15px 20px;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }
        
        .navbar-collapse .navbar-nav > li > a:hover,
        .navbar-collapse .navbar-nav > li > a:focus {
            background-color: #34495e;
            border-left-color: #3498db;
            transform: none;
        }
        
        .navbar-collapse .navbar-nav > .active > a {
            background-color: #34495e;
            border-left-color: #3498db;
            border-bottom: none;
        }
        
        /* 手机端下拉菜单 - 保持Bootstrap原生行为 */
        .navbar-collapse .dropdown-menu {
            position: static;
            float: none;
            width: auto;
            margin-top: 0;
            background-color: #34495e;
            border: none;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.1);
            border-radius: 0;
            /* 移除animation: none，让Bootstrap控制显示/隐藏 */
        }
        
        .navbar-collapse .dropdown-menu > li > a {
            padding: 12px 30px;
            border-left: 3px solid transparent;
        }
        
        .navbar-collapse .dropdown-menu > li > a:hover {
            border-left-color: #3498db;
        }
        
        .navbar-collapse .dropdown-menu .divider {
            margin: 0;
            height: 1px;
        }
    }
    
    /* 桌面端保持原有样式 */
    @media (min-width: 768px) {
        .navbar-header .navbar-toggle {
            display: none;
        }
        
        .navbar-nav > li > a {
            position: relative;
        }
        
        .navbar-nav > li > a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 3px;
            background-color: #3498db;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        .navbar-nav > li > a:hover::after {
            width: 100%;
        }
        
        .navbar-nav > .active > a::after {
            width: 100%;
        }
    }
    
    /* 购物车徽章样式优化 */
    .navbar-nav .badge {
        position: absolute;
        top: 8px;
        right: 8px;
        background-color: #e74c3c;
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 10px;
        min-width: 18px;
        text-align: center;
        animation: pulse 2s infinite;
    }
    
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }
    
    /* 管理员标签样式优化 */
    .label-warning {
        background-color: #f39c12;
        margin-left: 5px;
        font-size: 10px;
        padding: 3px 8px;
        border-radius: 12px;
        font-weight: normal;
        animation: glow 2s ease-in-out infinite alternate;
    }
    
    @keyframes glow {
        from { box-shadow: 0 0 5px #f39c12; }
        to { box-shadow: 0 0 10px #f39c12, 0 0 15px #f39c12; }
    }
    
    /* 手机端徽章和标签调整 */
    @media (max-width: 767px) {
        .navbar-nav .badge {
            position: static;
            display: inline-block;
            margin-left: 8px;
            animation: none;
        }
        
        .label-warning {
            animation: none;
        }
    }
    
    /* 图标间距优化 */
    .navbar-nav a i {
        margin-right: 6px;
        width: 16px;
        text-align: center;
    }
    
    /* Bootstrap原生折叠动画 - 不要覆盖 */
    .navbar-collapse.collapsing {
        /* 让Bootstrap处理折叠动画 */
    }
</style>

<!-- 导航栏JavaScript增强 -->
<script>
$(document).ready(function() {
    // 确保Bootstrap下拉菜单功能正常
    $('.dropdown-toggle').dropdown();
    
    // 手机端点击菜单项后自动收起导航栏
    $('.navbar-collapse a').on('click', function() {
        if ($(window).width() < 768) {
            $('.navbar-collapse').collapse('hide');
        }
    });
    
    // 修复手机端下拉菜单点击问题
    $('.navbar-collapse .dropdown > a').on('click', function(e) {
        if ($(window).width() < 768) {
            e.preventDefault();
            var $dropdown = $(this).parent();
            var $menu = $dropdown.find('.dropdown-menu');
            
            // 切换下拉菜单显示状态
            if ($menu.is(':visible')) {
                $menu.slideUp(200);
                $dropdown.removeClass('open');
            } else {
                // 先关闭其他打开的下拉菜单
                $('.navbar-collapse .dropdown').removeClass('open');
                $('.navbar-collapse .dropdown-menu').slideUp(200);
                
                // 打开当前下拉菜单
                $menu.slideDown(200);
                $dropdown.addClass('open');
            }
        }
    });
    
    // 桌面端保持Bootstrap原生行为
    $(window).resize(function() {
        if ($(window).width() >= 768) {
            $('.navbar-collapse .dropdown-menu').removeAttr('style');
            $('.navbar-collapse .dropdown').removeClass('open');
        }
    });
});
</script>