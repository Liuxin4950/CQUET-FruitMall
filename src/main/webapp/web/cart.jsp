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
                            <span id="totalItems">}件</span>
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
        // 页面加载完成后获取购物车数据
        $(document).ready(function() {
            loadCartData();
        });

        // 获取购物车数据
        function loadCartData() {
            $.ajax({
                url: '${ctx}/web/cart/list',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log(response);
                    if (response.code === 0) {
                        renderCartData(response.data);
                    } else {
                        console.error('获取购物车数据失败:', response.msg);
                        showEmptyCart();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('请求失败:', error);
                    showEmptyCart();
                }
            });
        }

        // 渲染购物车数据
        function renderCartData(data) {
            const cartList = data.cartList;
            const summary = data.summary;
            
            if (!cartList || cartList.length === 0) {
                showEmptyCart();
                return;
            }
            
            // 显示购物车内容，隐藏空购物车提示
            $('#cartContent').show();
            $('#emptyCart').hide();
            
            // 渲染购物车项目
            const cartItemsHtml = cartList.map(item => {
                const productImage = item.productPic ? 
                    '<img src="' + '${ctx}' + item.productPic + '" alt="' + item.productName + '" style="width:100%;height:100%;object-fit:cover;border-radius:8px;">'
                    : '<i class="fa fa-image"></i>';
                
                return '<tr data-id="' + item.id + '">' +
                    '<td>' +
                        '<input type="checkbox" class="item-checkbox" ' + (item.isSelected ? 'checked' : '') + ' ' +
                               'onchange="updateItemSelection(' + item.id + ', this.checked)">' +
                    '</td>' +
                    '<td>' +
                        '<div class="product-info">' +
                            '<div class="product-image">' +
                                productImage +
                            '</div>' +
                            '<div class="product-details">' +
                                '<h5>' + item.productName + '</h5>' +
                                '<div class="product-specs">' + (item.description || '新鲜水果，品质保证') + '</div>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td class="price-cell">¥' + item.price.toFixed(2) + '</td>' +
                    '<td>' +
                        '<div class="quantity-controls">' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', ' + (item.amount - 1) + ')">' +
                                '<i class="fa fa-minus"></i>' +
                            '</button>' +
                            '<input type="text" class="quantity-input" value="' + item.amount + '" ' +
                                   'onchange="updateQuantity(' + item.id + ', this.value)">' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', ' + (item.amount + 1) + ')">' +
                                '<i class="fa fa-plus"></i>' +
                            '</button>' +
                        '</div>' +
                    '</td>' +
                    '<td class="price-cell">¥' + item.subtotal + '</td>' +
                    '<td>' +
                        '<span class="remove-btn" onclick="removeItem(' + item.id + ')" title="删除">' +
                            '<i class="fa fa-trash"></i>' +
                        '</span>' +
                    '</td>' +
                '</tr>';
            }).join('');
            
            $('#cartItems').html(cartItemsHtml);
            
            // 更新汇总信息
            updateSummary(summary);
            
            // 更新全选状态
            updateSelectAllStatus();
        }
        
        // 更新汇总信息
        function updateSummary(summary) {
            console.log(summary)
            $('#totalItems').text(summary.cartSize + '件');
            $('#subtotal').text('¥' + summary.totalAmount);
            $('#totalAmount').text('¥' + summary.totalAmount);
        }
        
        // 显示空购物车
        function showEmptyCart() {
            $('#cartContent').hide();
            $('#emptyCart').show();
        }
        
        // 更新全选状态
        function updateSelectAllStatus() {
            const checkboxes = $('.item-checkbox');
            const checkedBoxes = $('.item-checkbox:checked');
            $('#selectAll').prop('checked', checkboxes.length > 0 && checkboxes.length === checkedBoxes.length);
        }
        
        // 更新商品选择状态
        function updateItemSelection(itemId, isSelected) {
            $.ajax({
                url: '${ctx}/web/cart/select',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    cartId: itemId,
                    selected: isSelected
                }),
                success: function(response) {
                    if (response.code === 0) {
                        // 更新成功，重新加载购物车数据以更新汇总信息
                        loadCartData();
                    } else {
                        alert('更新失败：' + response.msg);
                        // 恢复复选框状态
                        $('tr[data-id="' + itemId + '"] .item-checkbox').prop('checked', !isSelected);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('更新选择状态失败:', error);
                    alert('更新失败，请稍后重试');
                    // 恢复复选框状态
                    $('tr[data-id="' + itemId + '"] .item-checkbox').prop('checked', !isSelected);
                }
            });
        }
        
        // 更新商品数量
        function updateQuantity(itemId, newQuantity) {
            // 验证和转换数量
            if (!newQuantity || newQuantity === '') {
                alert('请输入有效的商品数量');
                loadCartData(); // 重新加载数据恢复原始值
                return;
            }
            
            const quantity = parseInt(newQuantity);
            if (isNaN(quantity) || quantity < 1) {
                alert('商品数量必须是大于0的整数');
                loadCartData(); // 重新加载数据恢复原始值
                return;
            }
            
            $.ajax({
                url: '${ctx}/web/cart/update',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    cartId: itemId,
                    amount: quantity
                }),
                success: function(response) {
                    console.log(response);
                    
                    if (response.code === 0) {
                        // 更新成功，重新加载购物车数据
                        loadCartData();
                    } else {
                        alert('更新失败：' + response.msg);
                        // 重新加载数据以恢复原始数量
                        loadCartData();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('更新数量失败:', error);
                    alert('更新失败，请稍后重试');
                    // 重新加载数据以恢复原始数量
                    loadCartData();
                }
            });
        }
        
        // 删除商品
        function removeItem(itemId) {
            if (confirm('确定要删除这个商品吗？')) {
                $.ajax({
                    url: '${ctx}/web/cart/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        cartId: itemId
                    }),
                    success: function(response) {
                        if (response.code === 0) {
                            // 删除成功，重新加载购物车数据
                            loadCartData();
                        } else {
                            alert('删除失败：' + response.msg);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('删除商品失败:', error);
                        alert('删除商品失败，请稍后重试');
                    }
                });
            }
        }
        
        // 全选/取消全选
        $('#selectAll').change(function() {
            const isChecked = $(this).is(':checked');
            
            $.ajax({
                url: '${ctx}/web/cart/selectAll',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    selected: isChecked
                }),
                success: function(response) {
                    if (response.code === 0) {
                        // 更新成功，重新加载购物车数据
                        loadCartData();
                    } else {
                        alert('更新失败：' + response.msg);
                        // 恢复全选框状态
                        $('#selectAll').prop('checked', !isChecked);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('全选操作失败:', error);
                    alert('操作失败，请稍后重试');
                    // 恢复全选框状态
                    $('#selectAll').prop('checked', !isChecked);
                }
            });
        });
        
        // 继续购物
        function continueShopping() {
            // 跳转到商品列表页面
            window.location.href = '${ctx}/web/category.jsp';
        }
        
        // 结算
        function checkout() {
            const selectedItems = $('.item-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('请先选择要结算的商品');
                return;
            }
            
            // 获取选中商品的ID列表和数量信息
            const selectedIds = [];
            let totalAmount = 0;
            let totalQuantity = 0;
            
            selectedItems.each(function() {
                const row = $(this).closest('tr');
                const cartId = row.data('id');
                const quantity = parseInt(row.find('.quantity-input').val());
                const price = parseFloat(row.find('.price-cell').first().text().replace('¥', ''));
                
                selectedIds.push(cartId);
                totalQuantity += quantity;
                totalAmount += price * quantity;
            });
            
            console.log('selectedIds:', selectedIds);
            console.log('totalQuantity:', totalQuantity);
            console.log('totalAmount:', totalAmount);
            
            // 确认下单
            if (confirm(`确认下单？\n商品数量：`+totalQuantity+`件\n总金额：￥`+totalAmount)) {
                // 调用后端接口创建订单
                $.ajax({
                    url: '${ctx}/web/order/createOrderFromCart',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        cartIds: selectedIds.join(',')
                    }),
                    success: function(response) {
                        console.log('创建订单响应:', response);
                        if (response.code === 0) {
                            alert('订单创建成功！订单号：' + response.data);
                            // 刷新购物车页面
                            location.reload();
                        } else {
                            alert('订单创建失败：' + response.msg);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('创建订单失败:', error);
                        alert('网络错误，请稍后重试');
                    }
                });
            }
        }
        
        // 删除选中商品
        function clearSelected() {
            const selectedItems = $('.item-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('请先选择要删除的商品');
                return;
            }
            
            if (confirm('确定要删除选中的商品吗？')) {
                // 获取选中商品的ID列表
                const selectedIds = [];
                selectedItems.each(function() {
                    const cartId = $(this).closest('tr').data('id');
                    selectedIds.push(cartId);
                });
                
                // 逐个删除选中的商品
                let deleteCount = 0;
                let totalCount = selectedIds.length;
                
                selectedIds.forEach(function(cartId) {
                    $.ajax({
                        url: '${ctx}/web/cart/delete',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            cartId: cartId
                        }),
                        success: function(response) {
                            deleteCount++;
                            if (deleteCount === totalCount) {
                                // 所有删除操作完成
                                alert('选中商品已删除');
                                loadCartData();
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('删除商品失败:', error);
                            deleteCount++;
                            if (deleteCount === totalCount) {
                                alert('部分商品删除失败，请刷新页面查看');
                                loadCartData();
                            }
                        }
                    });
                });
            }
        }
        
        // 清空购物车
        function clearCart() {
            if (confirm('确定要清空购物车吗？')) {
                $.ajax({
                    url: '${ctx}/web/cart/clear',
                    type: 'POST',
                    contentType: 'application/json',
                    success: function(response) {
                        if (response.code === 0) {
                            alert('购物车已清空');
                            loadCartData();
                        } else {
                            alert('清空失败：' + response.msg);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('清空购物车失败:', error);
                        alert('清空失败，请稍后重试');
                    }
                });
            }
        }


    </script>
</body>
</html>