<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单 - 向日葵水果</title>
    <meta name="description" content="向日葵水果 - 我的订单，查看和管理您的水果订单">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .orders-container {
            padding: 40px 0;
            min-height: 500px;
        }
        
        .orders-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .order-filters {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .filter-tabs {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .filter-tab {
            padding: 10px 20px;
            border: 1px solid #ddd;
            background-color: white;
            color: #333;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .filter-tab:hover,
        .filter-tab.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .search-section {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .search-input {
            flex: 1;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 20px;
        }
        
        .btn-search {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            background-color: #2980b9;
            color: white;
        }
        
        .order-item {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }
        
        .order-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-info {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .order-number {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .order-date {
            color: #7f8c8d;
        }
        
        .order-status {
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-pending {
            background-color: #f39c12;
            color: white;
        }
        
        .status-paid {
            background-color: #3498db;
            color: white;
        }
        
        .status-shipped {
            background-color: #9b59b6;
            color: white;
        }
        
        .status-delivered {
            background-color: #27ae60;
            color: white;
        }
        
        .status-cancelled {
            background-color: #e74c3c;
            color: white;
        }
        
        .order-content {
            padding: 20px;
        }
        
        .order-products {
            margin-bottom: 20px;
        }
        
        .product-row {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .product-row:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 60px;
            height: 60px;
            background-color: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #bdc3c7;
            font-size: 20px;
        }
        
        .product-details {
            flex: 1;
        }
        
        .product-name {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .product-specs {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .product-quantity {
            color: #7f8c8d;
            margin: 0 20px;
        }
        
        .product-price {
            font-weight: bold;
            color: #e74c3c;
            font-size: 16px;
        }
        
        .order-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #ecf0f1;
        }
        
        .order-total {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        .order-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-action {
            padding: 8px 20px;
            border: 1px solid #ddd;
            background-color: white;
            color: #333;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        
        .btn-action:hover {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        
        .btn-danger {
            background-color: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }
        
        .empty-orders {
            text-align: center;
            padding: 80px 0;
            color: #7f8c8d;
        }
        
        .empty-orders i {
            font-size: 80px;
            margin-bottom: 20px;
            color: #bdc3c7;
        }
        
        .empty-orders h3 {
            margin-bottom: 15px;
            color: #95a5a6;
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 20px 0;
        }
        
        .pagination-wrapper {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>
    
    <!-- 面包屑导航 -->
    <div class="container">
        <ol class="breadcrumb">
            <li><a href="${ctx}/web/index.jsp"><i class="fa fa-home"></i> 首页</a></li>
            <li class="active">我的订单</li>
        </ol>
    </div>
    
    <!-- 订单头部 -->
    <div class="orders-header">
        <div class="container">
            <h1><i class="fa fa-list-alt"></i> 我的订单</h1>
            <p class="lead">查看和管理您的所有订单</p>
        </div>
    </div>
    
    <div class="container orders-container">
        <!-- 订单筛选 -->
        <div class="order-filters">
            <div class="filter-tabs">
                <button class="filter-tab active" data-status="all">全部订单</button>
                <button class="filter-tab" data-status="pending">待付款</button>
                <button class="filter-tab" data-status="paid">待发货</button>
                <button class="filter-tab" data-status="shipped">待收货</button>
                <button class="filter-tab" data-status="delivered">已完成</button>
                <button class="filter-tab" data-status="cancelled">已取消</button>
            </div>
            
            <div class="search-section">
                <input type="text" class="search-input" placeholder="搜索订单号或商品名称" id="searchInput">
                <button class="btn btn-search" onclick="searchOrders()">
                    <i class="fa fa-search"></i> 搜索
                </button>
            </div>
        </div>
        
        <!-- 订单列表 -->
        <div id="ordersContainer">
            <!-- 订单项目将通过JavaScript动态生成 -->
        </div>
        
        <!-- 空订单 -->
        <div id="emptyOrders" class="empty-orders" style="display: none;">
            <i class="fa fa-list-alt"></i>
            <h3>暂无订单</h3>
            <p>您还没有任何订单，快去购物吧！</p>
            <button class="btn btn-primary" onclick="goShopping()">
                <i class="fa fa-shopping-bag"></i> 去购物
            </button>
        </div>
        
        <!-- 分页 -->
        <div class="pagination-wrapper">
            <nav>
                <ul class="pagination">
                    <li class="disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                </ul>
            </nav>
        </div>
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // 模拟订单数据
        var orders = [
            {
                id: 'EM202401150001',
                date: '2024-01-15 14:30:25',
                status: 'delivered',
                statusText: '已完成',
                products: [
                    {name: 'iPhone 14 Pro', specs: '深空黑色 128GB', quantity: 1, price: 7999, image: 'fa-mobile'},
                    {name: 'AirPods Pro', specs: '第二代 主动降噪', quantity: 1, price: 1999, image: 'fa-headphones'}
                ],
                total: 9998
            },
            {
                id: 'EM202401120002',
                date: '2024-01-12 10:15:30',
                status: 'shipped',
                statusText: '待收货',
                products: [
                    {name: 'MacBook Pro', specs: '13英寸 M2芯片', quantity: 1, price: 12999, image: 'fa-laptop'}
                ],
                total: 12999
            },
            {
                id: 'EM202401100003',
                date: '2024-01-10 16:45:12',
                status: 'paid',
                statusText: '待发货',
                products: [
                    {name: 'iPad Pro', specs: '11英寸 256GB', quantity: 1, price: 6999, image: 'fa-tablet'},
                    {name: 'Apple Pencil', specs: '第二代', quantity: 1, price: 999, image: 'fa-pencil'}
                ],
                total: 7998
            },
            {
                id: 'EM202401080004',
                date: '2024-01-08 09:20:45',
                status: 'pending',
                statusText: '待付款',
                products: [
                    {name: 'Apple Watch', specs: 'Series 9 45mm', quantity: 1, price: 2999, image: 'fa-clock-o'}
                ],
                total: 2999
            },
            {
                id: 'EM202401050005',
                date: '2024-01-05 13:10:20',
                status: 'cancelled',
                statusText: '已取消',
                products: [
                    {name: '智能电视', specs: '55英寸 4K', quantity: 1, price: 3999, image: 'fa-tv'}
                ],
                total: 3999
            }
        ];
        
        var currentOrders = orders;
        var currentStatus = 'all';
        
        // 渲染订单列表
        function renderOrders(orderList) {
            var container = $('#ordersContainer');
            container.empty();
            
            if (orderList.length === 0) {
                $('#emptyOrders').show();
                return;
            }
            
            $('#emptyOrders').hide();
            
            orderList.forEach(function(order) {
                var productsHtml = order.products.map(function(product) {
                    return `
                        <div class="product-row">
                            <div class="product-image">
                                <i class="fa ${product.image}"></i>
                            </div>
                            <div class="product-details">
                                <div class="product-name">${product.name}</div>
                                <div class="product-specs">${product.specs}</div>
                            </div>
                            <div class="product-quantity">×${product.quantity}</div>
                            <div class="product-price">¥${product.price.toFixed(2)}</div>
                        </div>
                    `;
                }).join('');
                
                var actionsHtml = getOrderActions(order.status);
                
                var orderHtml = `
                    <div class="order-item">
                        <div class="order-header">
                            <div class="order-info">
                                <div class="order-number">订单号：${order.id}</div>
                                <div class="order-date">${order.date}</div>
                            </div>
                            <div class="order-status status-${order.status}">${order.statusText}</div>
                        </div>
                        <div class="order-content">
                            <div class="order-products">
                                ${productsHtml}
                            </div>
                            <div class="order-summary">
                                <div class="order-total">订单总额：¥${order.total.toFixed(2)}</div>
                                <div class="order-actions">
                                    ${actionsHtml}
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                container.append(orderHtml);
            });
        }
        
        // 获取订单操作按钮
        function getOrderActions(status) {
            switch (status) {
                case 'pending':
                    return `
                        <button class="btn-action btn-primary" onclick="payOrder()">立即付款</button>
                        <button class="btn-action" onclick="viewOrder()">查看详情</button>
                        <button class="btn-action btn-danger" onclick="cancelOrder()">取消订单</button>
                    `;
                case 'paid':
                    return `
                        <button class="btn-action" onclick="viewOrder()">查看详情</button>
                        <button class="btn-action" onclick="viewLogistics()">查看物流</button>
                    `;
                case 'shipped':
                    return `
                        <button class="btn-action btn-primary" onclick="confirmReceipt()">确认收货</button>
                        <button class="btn-action" onclick="viewOrder()">查看详情</button>
                        <button class="btn-action" onclick="viewLogistics()">查看物流</button>
                    `;
                case 'delivered':
                    return `
                        <button class="btn-action" onclick="viewOrder()">查看详情</button>
                        <button class="btn-action" onclick="writeReview()">评价商品</button>
                        <button class="btn-action" onclick="buyAgain()">再次购买</button>
                    `;
                case 'cancelled':
                    return `
                        <button class="btn-action" onclick="viewOrder()">查看详情</button>
                        <button class="btn-action" onclick="buyAgain()">再次购买</button>
                    `;
                default:
                    return `<button class="btn-action" onclick="viewOrder()">查看详情</button>`;
            }
        }
        
        // 筛选订单
        function filterOrders(status) {
            currentStatus = status;
            
            if (status === 'all') {
                currentOrders = orders;
            } else {
                currentOrders = orders.filter(order => order.status === status);
            }
            
            renderOrders(currentOrders);
        }
        
        // 搜索订单
        function searchOrders() {
            var keyword = $('#searchInput').val().trim().toLowerCase();
            
            if (!keyword) {
                filterOrders(currentStatus);
                return;
            }
            
            var filteredOrders = currentOrders.filter(function(order) {
                // 搜索订单号
                if (order.id.toLowerCase().includes(keyword)) {
                    return true;
                }
                
                // 搜索商品名称
                return order.products.some(function(product) {
                    return product.name.toLowerCase().includes(keyword);
                });
            });
            
            renderOrders(filteredOrders);
        }
        
        // 订单操作函数
        function payOrder() {
            showLoading('正在跳转到支付页面...');
            setTimeout(function() {
                hideLoading();
                alert('跳转到支付页面（功能开发中）');
            }, 1000);
        }
        
        function viewOrder() {
            alert('查看订单详情（功能开发中）');
        }
        
        function cancelOrder() {
            if (confirm('确定要取消这个订单吗？')) {
                showLoading('正在取消订单...');
                setTimeout(function() {
                    hideLoading();
                    alert('订单已取消');
                    // 这里可以更新订单状态并重新渲染
                }, 1000);
            }
        }
        
        function viewLogistics() {
            alert('查看物流信息（功能开发中）');
        }
        
        function confirmReceipt() {
            if (confirm('确认已收到商品吗？')) {
                showLoading('正在确认收货...');
                setTimeout(function() {
                    hideLoading();
                    alert('收货确认成功');
                    // 这里可以更新订单状态并重新渲染
                }, 1000);
            }
        }
        
        function writeReview() {
            alert('商品评价（功能开发中）');
        }
        
        function buyAgain() {
            showLoading('正在添加到购物车...');
            setTimeout(function() {
                hideLoading();
                alert('商品已添加到购物车');
            }, 1000);
        }
        
        function goShopping() {
            window.location.href = '${ctx}/web/products.jsp';
        }
        
        // 页面加载完成后初始化
        $(document).ready(function() {
            <% if (session.getAttribute("loginName") == null) { %>
                // 未登录用户重定向到登录页面
                alert('请先登录后查看订单');
                window.location.href = '${ctx}/login.jsp';
                return;
            <% } %>
            
            // 初始化订单列表
            renderOrders(orders);
            
            // 筛选标签事件
            $('.filter-tab').click(function() {
                $('.filter-tab').removeClass('active');
                $(this).addClass('active');
                
                var status = $(this).data('status');
                filterOrders(status);
            });
            
            // 搜索框回车事件
            $('#searchInput').keypress(function(e) {
                if (e.which === 13) {
                    searchOrders();
                }
            });
        });
    </script>
</body>
</html>