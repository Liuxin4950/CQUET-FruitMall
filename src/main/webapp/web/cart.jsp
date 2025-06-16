<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车 - 向日葵水果</title>
    <meta name="description" content="向日葵水果 - 新鲜水果购物车">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .cart-container {
            padding: 40px 0;
            min-height: 500px;
        }
        
        .cart-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .cart-table {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .cart-table table {
            margin-bottom: 0;
        }
        
        .cart-table th {
            background-color: #f8f9fa;
            border: none;
            padding: 20px;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .cart-table td {
            padding: 20px;
            vertical-align: middle;
            border-top: 1px solid #ecf0f1;
        }
        
        .product-info {
            display: flex;
            align-items: center;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            background-color: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #bdc3c7;
            font-size: 24px;
        }
        
        .product-details h5 {
            margin: 0 0 5px 0;
            color: #2c3e50;
            font-size: 16px;
        }
        
        .product-specs {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quantity-btn {
            width: 30px;
            height: 30px;
            border: 1px solid #bdc3c7;
            background-color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 3px;
            transition: all 0.3s ease;
        }
        
        .quantity-btn:hover {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .quantity-input {
            width: 50px;
            text-align: center;
            border: 1px solid #bdc3c7;
            border-left: none;
            border-right: none;
            padding: 5px;
            margin: 0;
        }
        
        .price-cell {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        .remove-btn {
            color: #e74c3c;
            cursor: pointer;
            font-size: 18px;
            transition: all 0.3s ease;
        }
        
        .remove-btn:hover {
            color: #c0392b;
            transform: scale(1.2);
        }
        
        .cart-summary {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 30px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .summary-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            font-size: 20px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        .checkout-section {
            text-align: center;
            margin-top: 30px;
        }
        
        .btn-checkout {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 15px 50px;
            border-radius: 25px;
            font-size: 18px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        
        .btn-checkout:hover {
            background-color: #c0392b;
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-continue {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 20px;
            margin-right: 15px;
            transition: all 0.3s ease;
        }
        
        .btn-continue:hover {
            background-color: #2980b9;
            color: white;
        }
        
        .empty-cart {
            text-align: center;
            padding: 80px 0;
            color: #7f8c8d;
        }
        
        .empty-cart i {
            font-size: 80px;
            margin-bottom: 20px;
            color: #bdc3c7;
        }
        
        .empty-cart h3 {
            margin-bottom: 15px;
            color: #95a5a6;
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 20px 0;
        }
        
        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .select-all {
            display: flex;
            align-items: center;
        }
        
        .select-all input {
            margin-right: 8px;
        }
        
        .cart-operations {
            display: flex;
            gap: 10px;
        }
        
        .btn-clear {
            background-color: #95a5a6;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }
        
        .btn-clear:hover {
            background-color: #7f8c8d;
            color: white;
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
            <li class="active">购物车</li>
        </ol>
    </div>
    
    <!-- 购物车头部 -->
    <div class="cart-header">
        <div class="container">
            <h1><i class="fa fa-shopping-cart"></i> 我的购物车</h1>
            <p class="lead">精心挑选的商品，等待您的确认</p>
        </div>
    </div>
    
    <div class="container cart-container">
        <!-- 购物车操作栏 -->
        <div class="cart-actions">
            <div class="select-all">
                <input type="checkbox" id="selectAll">
                <label for="selectAll">全选</label>
            </div>
            <div class="cart-operations">
                <button class="btn btn-clear" onclick="clearSelected()">
                    <i class="fa fa-trash"></i> 删除选中
                </button>
                <button class="btn btn-clear" onclick="clearCart()">
                    <i class="fa fa-trash-o"></i> 清空购物车
                </button>
            </div>
        </div>
        
        <!-- 购物车内容 -->
        <div id="cartContent">
            <!-- 购物车表格 -->
            <div class="cart-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th width="5%">选择</th>
                            <th width="40%">商品信息</th>
                            <th width="15%">单价</th>
                            <th width="15%">数量</th>
                            <th width="15%">小计</th>
                            <th width="10%">操作</th>
                        </tr>
                    </thead>
                    <tbody id="cartItems">
                        <!-- 购物车项目将通过JavaScript动态生成 -->
                    </tbody>
                </table>
            </div>
            
            <!-- 购物车汇总 -->
            <div class="row">
                <div class="col-md-8">
                    <div class="checkout-section">
                        <button class="btn btn-continue" onclick="continueShopping()">
                            <i class="fa fa-arrow-left"></i> 继续购物
                        </button>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="cart-summary">
                        <h4><i class="fa fa-calculator"></i> 订单汇总</h4>
                        <div class="summary-row">
                            <span>商品总数：</span>
                            <span id="totalItems">0件</span>
                        </div>
                        <div class="summary-row">
                            <span>商品总价：</span>
                            <span id="subtotal">¥0.00</span>
                        </div>
                        <div class="summary-row">
                            <span>运费：</span>
                            <span id="shipping">免费</span>
                        </div>
                        <div class="summary-row">
                            <span>优惠券：</span>
                            <span id="discount">-¥0.00</span>
                        </div>
                        <div class="summary-row">
                            <span>应付总额：</span>
                            <span id="totalAmount">¥0.00</span>
                        </div>
                        
                        <div class="checkout-section">
                            <button class="btn btn-checkout" onclick="checkout()">
                                <i class="fa fa-credit-card"></i> 立即结算
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 空购物车 -->
        <div id="emptyCart" class="empty-cart" style="display: none;">
            <i class="fa fa-shopping-cart"></i>
            <h3>您的购物车还是空的</h3>
            <p>快去挑选喜欢的商品吧！</p>
            <button class="btn btn-checkout" onclick="continueShopping()">
                <i class="fa fa-shopping-bag"></i> 去购物
            </button>
        </div>
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // 模拟购物车数据
        var cartItems = [
            {id: 1, name: 'iPhone 14 Pro', price: 7999, quantity: 1, image: 'fa-mobile', specs: '深空黑色 128GB', selected: true},
            {id: 2, name: 'MacBook Pro', price: 12999, quantity: 1, image: 'fa-laptop', specs: '13英寸 M2芯片', selected: true},
            {id: 3, name: 'AirPods Pro', price: 1999, quantity: 2, image: 'fa-headphones', specs: '第二代 主动降噪', selected: false}
        ];
        
        // 渲染购物车
        function renderCart() {
            var container = $('#cartItems');
            container.empty();
            
            if (cartItems.length === 0) {
                $('#cartContent').hide();
                $('#emptyCart').show();
                return;
            }
            
            $('#cartContent').show();
            $('#emptyCart').hide();
            
            cartItems.forEach(function(item, index) {
                var itemHtml = `
                    <tr data-id="${item.id}">
                        <td>
                            <input type="checkbox" class="item-checkbox" ${item.selected ? 'checked' : ''} 
                                   onchange="toggleItemSelection(${item.id})">
                        </td>
                        <td>
                            <div class="product-info">
                                <div class="product-image">
                                    <i class="fa ${item.image}"></i>
                                </div>
                                <div class="product-details">
                                    <h5>${item.name}</h5>
                                    <div class="product-specs">${item.specs}</div>
                                </div>
                            </div>
                        </td>
                        <td class="price-cell">¥${item.price.toFixed(2)}</td>
                        <td>
                            <div class="quantity-controls">
                                <button class="quantity-btn" onclick="decreaseQuantity(${item.id})">
                                    <i class="fa fa-minus"></i>
                                </button>
                                <input type="number" class="quantity-input" value="${item.quantity}" 
                                       min="1" max="10" onchange="updateQuantity(${item.id}, this.value)">
                                <button class="quantity-btn" onclick="increaseQuantity(${item.id})">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </td>
                        <td class="price-cell">¥${(item.price * item.quantity).toFixed(2)}</td>
                        <td>
                            <i class="fa fa-trash remove-btn" onclick="removeItem(${item.id})" 
                               title="删除商品"></i>
                        </td>
                    </tr>
                `;
                container.append(itemHtml);
            });
            
            updateSummary();
            updateSelectAll();
        }
        
        // 更新汇总信息
        function updateSummary() {
            var selectedItems = cartItems.filter(item => item.selected);
            var totalItems = selectedItems.reduce((sum, item) => sum + item.quantity, 0);
            var subtotal = selectedItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            var shipping = subtotal >= 99 ? 0 : 10;
            var discount = 0;
            var totalAmount = subtotal + shipping - discount;
            
            $('#totalItems').text(totalItems + '件');
            $('#subtotal').text('¥' + subtotal.toFixed(2));
            $('#shipping').text(shipping === 0 ? '免费' : '¥' + shipping.toFixed(2));
            $('#discount').text('-¥' + discount.toFixed(2));
            $('#totalAmount').text('¥' + totalAmount.toFixed(2));
        }
        
        // 更新全选状态
        function updateSelectAll() {
            var allSelected = cartItems.length > 0 && cartItems.every(item => item.selected);
            $('#selectAll').prop('checked', allSelected);
        }
        
        // 切换商品选择状态
        function toggleItemSelection(itemId) {
            var item = cartItems.find(item => item.id === itemId);
            if (item) {
                item.selected = !item.selected;
                updateSummary();
                updateSelectAll();
            }
        }
        
        // 全选/取消全选
        $('#selectAll').change(function() {
            var checked = $(this).is(':checked');
            cartItems.forEach(item => item.selected = checked);
            $('.item-checkbox').prop('checked', checked);
            updateSummary();
        });
        
        // 增加数量
        function increaseQuantity(itemId) {
            var item = cartItems.find(item => item.id === itemId);
            if (item && item.quantity < 10) {
                item.quantity++;
                renderCart();
            }
        }
        
        // 减少数量
        function decreaseQuantity(itemId) {
            var item = cartItems.find(item => item.id === itemId);
            if (item && item.quantity > 1) {
                item.quantity--;
                renderCart();
            }
        }
        
        // 更新数量
        function updateQuantity(itemId, newQuantity) {
            var quantity = parseInt(newQuantity);
            if (quantity >= 1 && quantity <= 10) {
                var item = cartItems.find(item => item.id === itemId);
                if (item) {
                    item.quantity = quantity;
                    updateSummary();
                }
            } else {
                renderCart(); // 重新渲染以恢复原值
            }
        }
        
        // 删除商品
        function removeItem(itemId) {
            if (confirm('确定要删除这件商品吗？')) {
                cartItems = cartItems.filter(item => item.id !== itemId);
                renderCart();
            }
        }
        
        // 删除选中商品
        function clearSelected() {
            var selectedItems = cartItems.filter(item => item.selected);
            if (selectedItems.length === 0) {
                alert('请先选择要删除的商品');
                return;
            }
            
            if (confirm('确定要删除选中的商品吗？')) {
                cartItems = cartItems.filter(item => !item.selected);
                renderCart();
            }
        }
        
        // 清空购物车
        function clearCart() {
            if (cartItems.length === 0) {
                alert('购物车已经是空的了');
                return;
            }
            
            if (confirm('确定要清空购物车吗？')) {
                cartItems = [];
                renderCart();
            }
        }
        
        // 继续购物
        function continueShopping() {
            window.location.href = '${ctx}/web/products.jsp';
        }
        
        // 结算
        function checkout() {
            <% if (session.getAttribute("loginName") != null) { %>
                var selectedItems = cartItems.filter(item => item.selected);
                if (selectedItems.length === 0) {
                    alert('请选择要结算的商品');
                    return;
                }
                
                showLoading('正在跳转到结算页面...');
                
                // 模拟跳转到结算页面
                setTimeout(function() {
                    hideLoading();
                    alert('跳转到结算页面（功能开发中）');
                }, 1500);
            <% } else { %>
                alert('请先登录后再进行结算');
                window.location.href = '${ctx}/login.jsp';
            <% } %>
        }
        
        // 页面加载完成后初始化
        $(document).ready(function() {
            <% if (session.getAttribute("loginName") == null) { %>
                // 未登录用户显示空购物车
                cartItems = [];
            <% } %>
            
            renderCart();
        });
    </script>
</body>
</html>