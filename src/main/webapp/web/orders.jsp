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
                <button class="filter-tab" data-status="1">待付款</button>
                <button class="filter-tab" data-status="2">待发货</button>
                <button class="filter-tab" data-status="3">待收货</button>
                <button class="filter-tab" data-status="4">已完成</button>
                <button class="filter-tab" data-status="5">已取消</button>
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
        
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        let currentStatus = 'all';
        let currentPage = 1;
        let pageSize = 10;
        
        // 页面加载完成后初始化
        document.addEventListener('DOMContentLoaded', function() {
            loadOrders();
            initFilterTabs();
        });
        
        // 初始化筛选标签
        function initFilterTabs() {
            const filterTabs = document.querySelectorAll('.filter-tab');
            filterTabs.forEach(function(tab) {
                tab.addEventListener('click', function() {
                    // 移除所有active类
                    filterTabs.forEach(function(t) {
                        t.classList.remove('active');
                    });
                    // 给当前点击的标签添加active类
                    this.classList.add('active');
                    currentStatus = this.getAttribute('data-status');
                    currentPage = 1;
                    loadOrders();
                });
            });
        }
        
        // 加载订单列表
        function loadOrders() {
            const requestData = {};
            
            // 如果不是查询全部订单，添加状态参数
            if (currentStatus !== 'all') {
                requestData.status = currentStatus;
            }
            
            fetch('${ctx}/web/order/myOrders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            })
            .then(response => {
                if (response.status === 401) {
                    alert('请先登录');
                    window.location.href = '${ctx}/web/login.jsp';
                    return;
                }
                return response.json();
            })
            .then(data => {
                console.log('订单数据:', data);
                if (data && data.code === 0) {
                    renderOrders(data.data);
                } else {
                    showError('获取订单失败：' + (data ? data.msg : '未知错误'));
                }
            })
            .catch(error => {
                console.error('请求失败:', error);
                showError('网络错误，请稍后重试');
            });
        }
        
        // 渲染订单列表
        function renderOrders(orders) {
            console.log('开始渲染订单，订单数量:', orders ? orders.length : 0);
            const container = document.getElementById('ordersContainer');
            const emptyDiv = document.getElementById('emptyOrders');
            
            if (!orders || orders.length === 0) {
                console.log('没有订单数据，显示空状态');
                container.innerHTML = '';
                emptyDiv.style.display = 'block';
                return;
            }
            
            console.log('隐藏空状态，开始生成订单');
            emptyDiv.style.display = 'none';
            container.innerHTML = '';
            
            orders.forEach(function(order, index) {
                console.log('处理第', index + 1, '个订单:', order.orderNum);
                const orderElement = createOrderElement(order);
                container.appendChild(orderElement);
            });
            
            console.log('渲染完成');
        }
        
        // 创建订单元素
        function createOrderElement(order) {
            console.log('创建订单元素:', order);
            const statusClass = getStatusClass(order.orderStatus);
            const statusText = getStatusText(order.orderStatus);
            const orderDate = formatDate(order.createdTime);
            
            // 创建主容器
            const orderItem = document.createElement('div');
            orderItem.className = 'order-item';
            
            // 创建订单头部
            const orderHeader = document.createElement('div');
            orderHeader.className = 'order-header';
            
            const orderInfo = document.createElement('div');
            orderInfo.className = 'order-info';
            
            const orderNumber = document.createElement('span');
            orderNumber.className = 'order-number';
            orderNumber.textContent = '订单号：' + (order.orderNum || 'N/A');
            
            const orderDateSpan = document.createElement('span');
            orderDateSpan.className = 'order-date';
            orderDateSpan.textContent = orderDate || '';
            
            orderInfo.appendChild(orderNumber);
            orderInfo.appendChild(orderDateSpan);
            
            const orderStatus = document.createElement('span');
            orderStatus.className = 'order-status ' + statusClass;
            orderStatus.textContent = statusText;
            
            orderHeader.appendChild(orderInfo);
            orderHeader.appendChild(orderStatus);
            
            // 创建订单内容
            const orderContent = document.createElement('div');
            orderContent.className = 'order-content';
            
            const orderProducts = document.createElement('div');
            orderProducts.className = 'order-products';
            
            // 创建商品行
            const productRow = document.createElement('div');
            productRow.className = 'product-row';
            
            const productImage = document.createElement('div');
            productImage.className = 'product-image';
            const icon = document.createElement('i');
            icon.className = 'fa fa-apple';
            productImage.appendChild(icon);
            
            const productDetails = document.createElement('div');
            productDetails.className = 'product-details';
            
            const productName = document.createElement('div');
            productName.className = 'product-name';
            productName.textContent = '订单商品';
            
            const productSpecs = document.createElement('div');
            productSpecs.className = 'product-specs';
            productSpecs.textContent = '详情请查看订单详情';
            
            productDetails.appendChild(productName);
            productDetails.appendChild(productSpecs);
            
            const productQuantity = document.createElement('div');
            productQuantity.className = 'product-quantity';
            productQuantity.textContent = '-';
            
            const productPrice = document.createElement('div');
            productPrice.className = 'product-price';
            productPrice.textContent = '¥' + (order.paymentMoney || '0');
            
            productRow.appendChild(productImage);
            productRow.appendChild(productDetails);
            productRow.appendChild(productQuantity);
            productRow.appendChild(productPrice);
            
            orderProducts.appendChild(productRow);
            
            // 创建订单汇总
            const orderSummary = document.createElement('div');
            orderSummary.className = 'order-summary';
            
            const orderTotal = document.createElement('div');
            orderTotal.className = 'order-total';
            orderTotal.textContent = '实付款：¥' + (order.paymentMoney || '0');
            
            const orderActions = document.createElement('div');
            orderActions.className = 'order-actions';
            
            // 根据订单状态添加按钮
            const orderId = order.id || order.orderId || order.orderNum;
            if (order.orderStatus == 1) {
                const payBtn = document.createElement('button');
                payBtn.className = 'btn-action btn-primary';
                payBtn.innerHTML = '<i class="fa fa-credit-card"></i> 立即付款';
                payBtn.onclick = function() { payOrder(orderId); };
                
                const cancelBtn = document.createElement('button');
                cancelBtn.className = 'btn-action';
                cancelBtn.innerHTML = '<i class="fa fa-times"></i> 取消订单';
                cancelBtn.onclick = function() { cancelOrder(orderId); };
                
                orderActions.appendChild(payBtn);
                orderActions.appendChild(cancelBtn);
            } else {
                const viewBtn = document.createElement('button');
                viewBtn.className = 'btn-action';
                viewBtn.innerHTML = '<i class="fa fa-eye"></i> 查看详情';
                viewBtn.onclick = function() { viewOrderDetail(orderId); };
                orderActions.appendChild(viewBtn);
            }
            
            orderSummary.appendChild(orderTotal);
            orderSummary.appendChild(orderActions);
            
            orderContent.appendChild(orderProducts);
            orderContent.appendChild(orderSummary);
            
            orderItem.appendChild(orderHeader);
            orderItem.appendChild(orderContent);
            
            return orderItem;
        }
        

        
        // 获取状态样式类
        function getStatusClass(status) {
            switch(parseInt(status)) {
                case 1: return 'status-pending';
                case 2: return 'status-paid';
                case 3: return 'status-shipped';
                case 4: return 'status-delivered';
                case 5: return 'status-cancelled';
                default: return 'status-pending';
            }
        }
        
        // 获取状态文本
        function getStatusText(status) {
            switch(parseInt(status)) {
                case 1: return '待付款';
                case 2: return '待发货';
                case 3: return '待收货';
                case 4: return '已完成';
                case 5: return '已取消';
                default: return '未知状态';
            }
        }
        
        // 格式化日期
        function formatDate(dateStr) {
            if (!dateStr) return '';
            const date = new Date(dateStr);
            return date.getFullYear() + '-' + 
                   String(date.getMonth() + 1).padStart(2, '0') + '-' + 
                   String(date.getDate()).padStart(2, '0') + ' ' +
                   String(date.getHours()).padStart(2, '0') + ':' + 
                   String(date.getMinutes()).padStart(2, '0');
        }
        
        // 搜索订单
        function searchOrders() {
            const keyword = $('#searchInput').val().trim();
            if (keyword) {
                // 这里可以添加搜索逻辑
                alert('搜索功能开发中...');
            } else {
                loadOrders();
            }
        }
        
        // 支付订单
        function payOrder(orderId) {
            if (confirm('确认支付此订单？')) {
                $.ajax({
                    url: '${ctx}/web/order/payOrder',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({orderId: orderId}),
                    success: function(response) {
                        if (response.code === 0) {
                            alert('支付成功！');
                            loadOrders();
                        } else {
                            alert('支付失败：' + response.msg);
                        }
                    },
                    error: function() {
                        alert('网络错误，请稍后重试');
                    }
                });
            }
        }
        
        // 取消订单
        function cancelOrder(orderId) {
            if (confirm('确认取消此订单？')) {
                $.ajax({
                    url: '${ctx}/web/order/cancelOrder',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({orderId: orderId}),
                    success: function(response) {
                        if (response.code === 200) {
                            alert('订单已取消');
                            loadOrders();
                        } else {
                            alert('取消失败：' + response.msg);
                        }
                    },
                    error: function() {
                        alert('网络错误，请稍后重试');
                    }
                });
            }
        }
        
        // 确认收货
        function confirmReceive(orderId) {
            if (confirm('确认收货？')) {
                $.ajax({
                    url: '${ctx}/web/order/confirmReceive',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({orderId: orderId}),
                    success: function(response) {
                        if (response.code === 200) {
                            alert('确认收货成功！');
                            loadOrders();
                        } else {
                            alert('操作失败：' + response.msg);
                        }
                    },
                    error: function() {
                        alert('网络错误，请稍后重试');
                    }
                });
            }
        }
        
        // 查看订单详情
        function viewOrderDetail(orderId) {
            // 这里可以跳转到订单详情页面或弹出详情窗口
            alert('订单详情功能开发中...');
        }
        
        // 再次购买
        function buyAgain(orderId) {
            alert('再次购买功能开发中...');
        }
        
        // 去购物
        function goShopping() {
            window.location.href = '${ctx}/web/index.jsp';
        }
        
        // 显示错误信息
        function showError(message) {
            alert(message);
        }
        
        // 回车搜索
        $('#searchInput').keypress(function(e) {
            if (e.which == 13) {
                searchOrders();
            }
        });
    </script>
</body>
</html>