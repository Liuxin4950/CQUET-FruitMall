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

            $.ajax({
                url: '${ctx}/web/order/myOrders',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(requestData),
                dataType: 'json',
                success: function(data) {
                    console.log('订单数据:', data);
                    if (data && data.code === 0) {
                        renderOrders(data.data);
                    } else {
                        showError('获取订单失败：' + (data ? data.msg : '未知错误'));
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    showError('网络错误，请稍后重试');
                }
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
            
            // 获取订单商品详情
            const orderDetails = order.orderDetails || order.orderDetailList || [];
            
            if (orderDetails && orderDetails.length > 0) {
                // 显示前3个商品，如果超过3个则显示"等X件商品"
                const displayCount = Math.min(3, orderDetails.length);
                
                for (let i = 0; i < displayCount; i++) {
                    const detail = orderDetails[i];
                    
                    // 创建商品行
                    const productRow = document.createElement('div');
                    productRow.className = 'product-row';
                    
                    const productImage = document.createElement('div');
                    productImage.className = 'product-image';
                    
                    // 优先使用productInfo中的图片，然后是detail中的图片
                    const imageUrl = (detail.productInfo && detail.productInfo.imageUrl) || detail.productImage;
                    if (imageUrl) {
                        const img = document.createElement('img');
                        img.src = imageUrl;
                        img.alt = detail.productName || '商品图片';
                        img.style.cssText = 'width: 100%; height: 100%; object-fit: cover; border-radius: 4px;';
                        img.onerror = function() {
                            // 图片加载失败时显示默认图标
                            this.style.display = 'none';
                            const icon = document.createElement('i');
                            icon.className = 'fa fa-apple';
                            icon.style.cssText = 'font-size: 24px; color: #999;';
                            productImage.appendChild(icon);
                        };
                        productImage.appendChild(img);
                    } else {
                        const icon = document.createElement('i');
                        icon.className = 'fa fa-apple';
                        productImage.appendChild(icon);
                    }
                    
                    const productDetails = document.createElement('div');
                    productDetails.className = 'product-details';
                    
                    const productName = document.createElement('div');
                    productName.className = 'product-name';
                    productName.textContent = detail.productName || '商品';
                    
                    const productSpecs = document.createElement('div');
                    productSpecs.className = 'product-specs';
                    productSpecs.textContent = '规格：' + (detail.productSpec || '标准装');
                    
                    productDetails.appendChild(productName);
                    productDetails.appendChild(productSpecs);
                    
                    const productQuantity = document.createElement('div');
                    productQuantity.className = 'product-quantity';
                    productQuantity.textContent = '×' + (detail.amount || detail.quantity || '1');
                    
                    const productPrice = document.createElement('div');
                    productPrice.className = 'product-price';
                    productPrice.textContent = '¥' + (detail.productPrice || detail.price || '0');
                    
                    productRow.appendChild(productImage);
                    productRow.appendChild(productDetails);
                    productRow.appendChild(productQuantity);
                    productRow.appendChild(productPrice);
                    
                    orderProducts.appendChild(productRow);
                }
                
                // 如果商品数量超过3个，显示"等X件商品"
                if (orderDetails.length > 3) {
                    const moreRow = document.createElement('div');
                    moreRow.className = 'product-row more-products';
                    moreRow.style.cssText = 'justify-content: center; color: #666; font-size: 14px; padding: 10px;';
                    moreRow.textContent = `等${orderDetails.length}件商品`;
                    orderProducts.appendChild(moreRow);
                }
            } else {
                // 没有商品详情时显示默认信息
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
            }
            
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
        
        // 获取支付方式文本
        function getPaymentMethodText(method) {
            switch(parseInt(method)) {
                case 1: return '默认支付';
                case 2: return '支付宝';
                case 3: return '微信支付';
                default: return '未知支付方式';
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
                        if (response.code === 0) {
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
            if (!orderId) {
                alert('订单ID不能为空');
                return;
            }
            
            // 调用后端接口获取订单详情
            $.ajax({
                url: '${ctx}/web/order/orderDetail',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ orderId: orderId }),
                dataType: 'json'
            }).done(function(data) {
                console.log(data);
                if (data && data.code === 0) {
                    showOrderDetailModal(data.data);
                } else {
                    alert('获取订单详情失败：' + (data ? data.msg : '未知错误'));
                }
            }).fail(function(jqXHR, textStatus, errorThrown) {
                console.error('请求失败:', textStatus, errorThrown);
                alert('网络错误，请稍后重试');
            });
        }
        
        // 显示订单详情弹窗
        function showOrderDetailModal(order) {
            console.log("订单详情数据:", order);
            // 创建遮罩层
            const overlay = document.createElement('div');
            overlay.className = 'modal-overlay';
            overlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                display: flex;
                justify-content: center;
                align-items: center;
            `;
            
            // 创建弹窗容器
            const modal = document.createElement('div');
            modal.className = 'order-detail-modal';
            modal.style.cssText = `
                background: white;
                border-radius: 8px;
                width: 90%;
                max-width: 800px;
                max-height: 80%;
                overflow-y: auto;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            `;
            
            // 创建弹窗内容
            const modalContent = createOrderDetailContent(order);
            modal.appendChild(modalContent);
            
            // 点击遮罩层关闭弹窗
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) {
                    document.body.removeChild(overlay);
                }
            });
            
            overlay.appendChild(modal);
            document.body.appendChild(overlay);
        }
        
        // 创建订单详情内容
        function createOrderDetailContent(order) {
            const container = document.createElement('div');
            container.style.padding = '20px';
            
            // 标题栏
            const header = document.createElement('div');
            header.style.cssText = `
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #eee;
                padding-bottom: 15px;
                margin-bottom: 20px;
            `;
            
            const title = document.createElement('h3');
            title.textContent = '订单详情';
            title.style.margin = '0';
            
            const closeBtn = document.createElement('button');
            closeBtn.innerHTML = '×';
            closeBtn.style.cssText = `
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: #999;
            `;
            closeBtn.addEventListener('click', function() {
                const overlay = document.querySelector('.modal-overlay');
                if (overlay) {
                    document.body.removeChild(overlay);
                }
            });
            
            header.appendChild(title);
            header.appendChild(closeBtn);
            
            // 订单基本信息
            const orderInfo = document.createElement('div');
            orderInfo.style.cssText = `
                background: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            `;
            
            const statusClass = getStatusClass(order.orderStatus);
            const statusText = getStatusText(order.orderStatus);
            const orderDate = formatDate(order.createdTime);
            
            // 创建订单信息网格容器
            const infoGrid = document.createElement('div');
            infoGrid.style.cssText = 'display: grid; grid-template-columns: 1fr 1fr; gap: 15px; font-size: 14px;';
            
            // 订单号
            const orderNumDiv = document.createElement('div');
            const orderNumLabel = document.createElement('strong');
            orderNumLabel.textContent = '订单号：';
            orderNumDiv.appendChild(orderNumLabel);
            orderNumDiv.appendChild(document.createTextNode(order.orderNum || 'N/A'));
            
            // 订单状态
            const statusDiv = document.createElement('div');
            const statusLabel = document.createElement('strong');
            statusLabel.textContent = '订单状态：';
            const statusSpan = document.createElement('span');
            statusSpan.className = statusClass;
            statusSpan.textContent = statusText;
            statusDiv.appendChild(statusLabel);
            statusDiv.appendChild(statusSpan);
            
            // 下单时间
            const timeDiv = document.createElement('div');
            const timeLabel = document.createElement('strong');
            timeLabel.textContent = '下单时间：';
            timeDiv.appendChild(timeLabel);
            timeDiv.appendChild(document.createTextNode(orderDate));
            
            // 更新时间
            const updateTimeDiv = document.createElement('div');
            const updateTimeLabel = document.createElement('strong');
            updateTimeLabel.textContent = '更新时间：';
            updateTimeDiv.appendChild(updateTimeLabel);
            updateTimeDiv.appendChild(document.createTextNode(formatDate(order.updatedTime) || 'N/A'));
            
            // 收货地址
            const addressDiv = document.createElement('div');
            addressDiv.style.cssText = 'grid-column: 1 / -1;';
            const addressLabel = document.createElement('strong');
            addressLabel.textContent = '收货地址：';
            addressDiv.appendChild(addressLabel);
            addressDiv.appendChild(document.createTextNode(order.address || 'N/A'));
            
            // 收货人信息
            const userInfoDiv = document.createElement('div');
            const userInfoLabel = document.createElement('strong');
            userInfoLabel.textContent = '收货人：';
            userInfoDiv.appendChild(userInfoLabel);
            userInfoDiv.appendChild(document.createTextNode((order.shippingUser || order.userName || 'N/A') + ' (' + (order.userPhone || 'N/A') + ')'));
            
            // 用户邮箱
            const emailDiv = document.createElement('div');
            const emailLabel = document.createElement('strong');
            emailLabel.textContent = '邮箱：';
            emailDiv.appendChild(emailLabel);
            emailDiv.appendChild(document.createTextNode(order.userEmail || 'N/A'));
            
            // 支付方式
            const payMethodDiv = document.createElement('div');
            const payMethodLabel = document.createElement('strong');
            payMethodLabel.textContent = '支付方式：';
            const payMethodText = getPaymentMethodText(order.paymentMethod);
            payMethodDiv.appendChild(payMethodLabel);
            payMethodDiv.appendChild(document.createTextNode(payMethodText));
            
            // 支付时间
            const payTimeDiv = document.createElement('div');
            const payTimeLabel = document.createElement('strong');
            payTimeLabel.textContent = '支付时间：';
            const payTimeText = order.payTime ? formatDate(new Date(order.payTime)) : 'N/A';
            payTimeDiv.appendChild(payTimeLabel);
            payTimeDiv.appendChild(document.createTextNode(payTimeText));
            
            // 支付交易号
            if (order.paymentTransactionId) {
                const transactionDiv = document.createElement('div');
                transactionDiv.style.cssText = 'grid-column: 1 / -1;';
                const transactionLabel = document.createElement('strong');
                transactionLabel.textContent = '支付交易号：';
                transactionDiv.appendChild(transactionLabel);
                transactionDiv.appendChild(document.createTextNode(order.paymentTransactionId));
                infoGrid.appendChild(transactionDiv);
            }
            
            // 订单备注
            if (order.remark) {
                const remarkDiv = document.createElement('div');
                remarkDiv.style.cssText = 'grid-column: 1 / -1;';
                const remarkLabel = document.createElement('strong');
                remarkLabel.textContent = '订单备注：';
                remarkDiv.appendChild(remarkLabel);
                remarkDiv.appendChild(document.createTextNode(order.remark));
                infoGrid.appendChild(remarkDiv);
            }
            
            // 添加到网格
            infoGrid.appendChild(orderNumDiv);
            infoGrid.appendChild(statusDiv);
            infoGrid.appendChild(timeDiv);
            infoGrid.appendChild(updateTimeDiv);
            infoGrid.appendChild(addressDiv);
            infoGrid.appendChild(userInfoDiv);
            infoGrid.appendChild(emailDiv);
            infoGrid.appendChild(payMethodDiv);
            infoGrid.appendChild(payTimeDiv);
            
            orderInfo.appendChild(infoGrid);
            
            // 费用明细
            const costTitle = document.createElement('h4');
            costTitle.textContent = '费用明细';
            costTitle.style.cssText = 'margin: 20px 0 10px 0; color: #333;';
            
            const costDetail = document.createElement('div');
            costDetail.style.cssText = `
                background: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                border-left: 4px solid #28a745;
            `;
            
            const costGrid = document.createElement('div');
            costGrid.style.cssText = 'display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-size: 14px;';
            
            // 商品金额
            const orderMoneyDiv = document.createElement('div');
            const orderMoneyLabel = document.createElement('strong');
            orderMoneyLabel.textContent = '商品金额：';
            orderMoneyDiv.appendChild(orderMoneyLabel);
            orderMoneyDiv.appendChild(document.createTextNode('¥' + (order.orderMoney || '0')));
            
            // 配送费用
            const shippingMoneyDiv = document.createElement('div');
            const shippingMoneyLabel = document.createElement('strong');
            shippingMoneyLabel.textContent = '配送费用：';
            shippingMoneyDiv.appendChild(shippingMoneyLabel);
            shippingMoneyDiv.appendChild(document.createTextNode('¥' + (order.shippingMoney || '0')));
            
            // 优惠金额
            const discountMoneyDiv = document.createElement('div');
            const discountMoneyLabel = document.createElement('strong');
            discountMoneyLabel.textContent = '优惠金额：';
            discountMoneyDiv.appendChild(discountMoneyLabel);
            discountMoneyDiv.appendChild(document.createTextNode('¥' + (order.districtMoney || '0')));
            
            // 实付金额
            const paymentMoneyDiv = document.createElement('div');
            paymentMoneyDiv.style.cssText = 'grid-column: 1 / -1; border-top: 1px solid #dee2e6; padding-top: 10px; margin-top: 10px;';
            const paymentMoneyLabel = document.createElement('strong');
            paymentMoneyLabel.textContent = '实付金额：';
            paymentMoneyLabel.style.cssText = 'font-size: 16px;';
            const paymentMoneySpan = document.createElement('span');
            paymentMoneySpan.style.cssText = 'color: #e74c3c; font-weight: bold; font-size: 18px;';
            paymentMoneySpan.textContent = '¥' + (order.paymentMoney || '0');
            paymentMoneyDiv.appendChild(paymentMoneyLabel);
            paymentMoneyDiv.appendChild(paymentMoneySpan);
            
            costGrid.appendChild(orderMoneyDiv);
            costGrid.appendChild(shippingMoneyDiv);
            costGrid.appendChild(discountMoneyDiv);
            costGrid.appendChild(paymentMoneyDiv);
            
            costDetail.appendChild(costGrid);
            
            // 商品列表
            const productsTitle = document.createElement('h4');
            productsTitle.textContent = '商品清单';
            productsTitle.style.cssText = 'margin: 20px 0 10px 0; color: #333;';
            
            const productsList = document.createElement('div');
            
            // 检查orderDetails字段（根据用户提供的数据结构）
            const orderDetails = order.orderDetails || order.orderDetailList || [];
            
            if (orderDetails && orderDetails.length > 0) {
                orderDetails.forEach(function(detail) {
                    const productItem = document.createElement('div');
                    productItem.style.cssText = 'display: flex; align-items: center; padding: 15px; border: 1px solid #eee; border-radius: 5px; margin-bottom: 10px;';
                    
                    // 商品图片
                    const imageDiv = document.createElement('div');
                    imageDiv.style.cssText = 'width: 60px; height: 60px; background: #f0f0f0; border-radius: 5px; display: flex; align-items: center; justify-content: center; margin-right: 15px; overflow: hidden;';
                    
                    // 优先使用productInfo中的图片，然后是detail中的图片
                    const imageUrl = (detail.productInfo && detail.productInfo.imageUrl) || detail.productImage;
                    if (imageUrl) {
                        const img = document.createElement('img');
                        img.src = imageUrl;
                        img.alt = detail.productName || '商品图片';
                        img.style.cssText = 'width: 100%; height: 100%; object-fit: cover; border-radius: 5px;';
                        img.onerror = function() {
                            // 图片加载失败时显示默认图标
                            this.style.display = 'none';
                            const icon = document.createElement('i');
                            icon.className = 'fa fa-apple';
                            icon.style.cssText = 'font-size: 24px; color: #999;';
                            imageDiv.appendChild(icon);
                        };
                        imageDiv.appendChild(img);
                    } else {
                        const icon = document.createElement('i');
                        icon.className = 'fa fa-apple';
                        icon.style.cssText = 'font-size: 24px; color: #999;';
                        imageDiv.appendChild(icon);
                    }
                    
                    // 商品信息
                    const infoDiv = document.createElement('div');
                    infoDiv.style.cssText = 'flex: 1;';
                    
                    const nameDiv = document.createElement('div');
                    nameDiv.style.cssText = 'font-weight: bold; margin-bottom: 5px;';
                    nameDiv.textContent = detail.productName || '商品';
                    
                    const specDiv = document.createElement('div');
                    specDiv.style.cssText = 'color: #666; font-size: 12px;';
                    specDiv.textContent = '规格：' + (detail.productSpec || '标准装');
                    
                    infoDiv.appendChild(nameDiv);
                    infoDiv.appendChild(specDiv);
                    
                    // 数量
                    const quantityDiv = document.createElement('div');
                    quantityDiv.style.cssText = 'text-align: center; margin: 0 20px;';
                    
                    const quantityLabel = document.createElement('div');
                    quantityLabel.style.cssText = 'color: #666; font-size: 12px;';
                    quantityLabel.textContent = '数量';
                    
                    const quantityValue = document.createElement('div');
                    quantityValue.style.cssText = 'font-weight: bold;';
                    quantityValue.textContent = '×' + (detail.amount || detail.quantity || '1');
                    
                    quantityDiv.appendChild(quantityLabel);
                    quantityDiv.appendChild(quantityValue);
                    
                    // 单价
                    const priceDiv = document.createElement('div');
                    priceDiv.style.cssText = 'text-align: right;';
                    
                    const priceLabel = document.createElement('div');
                    priceLabel.style.cssText = 'color: #666; font-size: 12px;';
                    priceLabel.textContent = '单价';
                    
                    const priceValue = document.createElement('div');
                    priceValue.style.cssText = 'color: #e74c3c; font-weight: bold;';
                    priceValue.textContent = '¥' + (detail.productPrice || detail.price || '0');
                    
                    priceDiv.appendChild(priceLabel);
                    priceDiv.appendChild(priceValue);
                    
                    // 组装商品项
                    productItem.appendChild(imageDiv);
                    productItem.appendChild(infoDiv);
                    productItem.appendChild(quantityDiv);
                    productItem.appendChild(priceDiv);
                    
                    productsList.appendChild(productItem);
                });
            } else {
                const emptyMsg = document.createElement('div');
                emptyMsg.textContent = '暂无商品信息';
                emptyMsg.style.cssText = 'text-align: center; color: #999; padding: 20px;';
                productsList.appendChild(emptyMsg);
            }
            
            // 组装内容
            container.appendChild(header);
            container.appendChild(orderInfo);
            container.appendChild(costTitle);
            container.appendChild(costDetail);
            container.appendChild(productsTitle);
            container.appendChild(productsList);
            
            return container;
        }
        
        // 格式化日期
        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return `${year}-${month}-${day} ${hours}:${minutes}`;
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
        
        // 回车搜索 - 原生JavaScript实现
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.which === 13 || e.keyCode === 13) {
                        searchOrders();
                    }
                });
            }
        });
    </script>
</body>
</html>