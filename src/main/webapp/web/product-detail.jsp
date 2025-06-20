<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品详情 - EmarketMall购物商城</title>
    <meta name="description" content="EmarketMall购物商城 - 商品详情">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .product-detail {
            padding: 40px 0;
        }
        
        .product-images {
            text-align: center;
        }
        
        .main-image {
            width: 100%;
            height: 400px;
            background-color: #f8f9fa;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            color: #bdc3c7;
            font-size: 120px;
            border: 2px solid #e9ecef;
        }
        
        .thumbnail-images {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .thumbnail {
            width: 80px;
            height: 80px;
            background-color: #f8f9fa;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            color: #bdc3c7;
            font-size: 24px;
        }
        
        .thumbnail:hover,
        .thumbnail.active {
            border-color: #3498db;
        }
        
        .product-info {
            padding-left: 30px;
        }
        
        .product-title {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .product-rating {
            margin-bottom: 20px;
        }
        
        .rating-stars {
            color: #f39c12;
            margin-right: 10px;
        }
        
        .rating-text {
            color: #7f8c8d;
        }
        
        .product-price {
            margin-bottom: 25px;
        }
        
        .current-price {
            font-size: 32px;
            color: #e74c3c;
            font-weight: bold;
            margin-right: 15px;
        }
        
        .original-price {
            font-size: 18px;
            color: #95a5a6;
            text-decoration: line-through;
        }
        
        .product-specs {
            margin-bottom: 30px;
        }
        
        .spec-item {
            display: flex;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .spec-label {
            width: 100px;
            font-weight: bold;
            color: #34495e;
        }
        
        .spec-value {
            color: #7f8c8d;
        }
        
        .quantity-section {
            margin-bottom: 30px;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }
        
        .quantity-btn {
            width: 35px;
            height: 35px;
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
            width: 60px;
            text-align: center;
            border: 1px solid #bdc3c7;
            padding: 8px;
            border-radius: 3px;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .btn-add-cart {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .btn-add-cart:hover {
            background-color: #c0392b;
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-buy-now {
            background-color: #f39c12;
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .btn-buy-now:hover {
            background-color: #e67e22;
            color: white;
            transform: translateY(-2px);
        }
        
        .product-tabs {
            margin-top: 50px;
        }
        
        .tab-content {
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .description-content {
            line-height: 1.8;
            color: #34495e;
        }
        
        .reviews-section {
            margin-top: 30px;
        }
        
        .review-item {
            padding: 20px;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .reviewer-name {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .review-date {
            color: #95a5a6;
            font-size: 14px;
        }
        
        .review-rating {
            color: #f39c12;
            margin-bottom: 10px;
        }
        
        .review-content {
            color: #7f8c8d;
            line-height: 1.6;
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 20px 0;
        }
        
        .related-products {
            margin-top: 50px;
        }
        
        .related-product-item {
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .related-product-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .related-product-image {
            width: 100%;
            height: 150px;
            background-color: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            color: #bdc3c7;
            font-size: 36px;
        }
        
        .related-product-title {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 10px;
            height: 40px;
            overflow: hidden;
        }
        
        .related-product-price {
            font-size: 18px;
            color: #e74c3c;
            font-weight: bold;
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
            <li><a href="${ctx}/web/products.jsp">商品列表</a></li>
            <li class="active">商品详情</li>
        </ol>
    </div>
    
    <!-- 商品详情 -->
    <div class="container product-detail">
        <div class="row">
            <!-- 商品图片 -->
            <div class="col-md-6">
                <div class="product-images">
                    <div class="main-image" id="mainImage">
                        <i class="fa fa-mobile"></i>
                    </div>
                    <div class="thumbnail-images">
                        <div class="thumbnail active" data-icon="fa-mobile">
                            <i class="fa fa-mobile"></i>
                        </div>
                        <div class="thumbnail" data-icon="fa-camera">
                            <i class="fa fa-camera"></i>
                        </div>
                        <div class="thumbnail" data-icon="fa-battery-full">
                            <i class="fa fa-battery-full"></i>
                        </div>
                        <div class="thumbnail" data-icon="fa-headphones">
                            <i class="fa fa-headphones"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 商品信息 -->
            <div class="col-md-6">
                <div class="product-info">
                    <h1 class="product-title" id="productTitle">iPhone 14 Pro</h1>
                    
                    <div class="product-rating">
                        <span class="rating-stars">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </span>
                        <span class="rating-text">(128条评价)</span>
                    </div>
                    
                    <div class="product-price">
                        <span class="current-price" id="currentPrice">¥7,999.00</span>
                        <span class="original-price">¥8,999.00</span>
                    </div>
                    
                    <div class="product-specs">
                        <div class="spec-item">
                            <div class="spec-label">品牌：</div>
                            <div class="spec-value">Apple</div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">型号：</div>
                            <div class="spec-value">iPhone 14 Pro</div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">颜色：</div>
                            <div class="spec-value">深空黑色</div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">存储：</div>
                            <div class="spec-value">128GB</div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">保修：</div>
                            <div class="spec-value">1年有限保修</div>
                        </div>
                    </div>
                    
                    <div class="quantity-section">
                        <label><strong>数量：</strong></label>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">
                                <i class="fa fa-minus"></i>
                            </button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="10">
                            <button class="quantity-btn" onclick="increaseQuantity()">
                                <i class="fa fa-plus"></i>
                            </button>
                            <span style="margin-left: 10px; color: #95a5a6;">库存：99件</span>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <button class="btn btn-add-cart" onclick="addToCart()">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                        <button class="btn btn-buy-now" onclick="buyNow()">
                            <i class="fa fa-shopping-cart"></i> 立即购买
                        </button>
                    </div>
                    
                    <div class="product-features">
                        <p><i class="fa fa-truck" style="color: #27ae60;"></i> 免费配送</p>
                        <p><i class="fa fa-refresh" style="color: #3498db;"></i> 7天无理由退货</p>
                        <p><i class="fa fa-shield" style="color: #e74c3c;"></i> 正品保证</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 商品详情标签页 -->
        <div class="product-tabs">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#description" aria-controls="description" role="tab" data-toggle="tab">
                        <i class="fa fa-file-text-o"></i> 商品详情
                    </a>
                </li>
                <li role="presentation">
                    <a href="#specifications" aria-controls="specifications" role="tab" data-toggle="tab">
                        <i class="fa fa-list"></i> 规格参数
                    </a>
                </li>
                <li role="presentation">
                    <a href="#reviews" aria-controls="reviews" role="tab" data-toggle="tab">
                        <i class="fa fa-comments"></i> 用户评价
                    </a>
                </li>
            </ul>
            
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="description">
                    <div class="description-content">
                        <h3>产品介绍</h3>
                        <p>iPhone 14 Pro 采用了全新的A16仿生芯片，性能更加强劲。配备了专业级摄像头系统，支持4800万像素主摄，让你拍摄出更加清晰、细腻的照片。</p>
                        
                        <h4>主要特性</h4>
                        <ul>
                            <li>6.1英寸超视网膜XDR显示屏，支持ProMotion自适应刷新率</li>
                            <li>A16仿生芯片，6核CPU，5核GPU</li>
                            <li>专业级摄像头系统：4800万像素主摄 + 1200万像素超广角 + 1200万像素长焦</li>
                            <li>支持4K视频录制，电影效果模式</li>
                            <li>Face ID面容识别，安全便捷</li>
                            <li>支持5G网络，下载速度更快</li>
                            <li>IP68级防水防尘</li>
                        </ul>
                        
                        <h4>包装清单</h4>
                        <ul>
                            <li>iPhone 14 Pro × 1</li>
                            <li>USB-C转闪电连接线 × 1</li>
                            <li>说明书 × 1</li>
                            <li>保修卡 × 1</li>
                        </ul>
                    </div>
                </div>
                
                <div role="tabpanel" class="tab-pane" id="specifications">
                    <table class="table table-striped">
                        <tr><td><strong>显示屏</strong></td><td>6.1英寸超视网膜XDR显示屏</td></tr>
                        <tr><td><strong>分辨率</strong></td><td>2556 x 1179 像素，460 ppi</td></tr>
                        <tr><td><strong>芯片</strong></td><td>A16仿生芯片</td></tr>
                        <tr><td><strong>存储容量</strong></td><td>128GB / 256GB / 512GB / 1TB</td></tr>
                        <tr><td><strong>摄像头</strong></td><td>4800万像素主摄 + 1200万像素超广角 + 1200万像素长焦</td></tr>
                        <tr><td><strong>前置摄像头</strong></td><td>1200万像素原深感摄像头</td></tr>
                        <tr><td><strong>电池</strong></td><td>视频播放最长可达23小时</td></tr>
                        <tr><td><strong>防水等级</strong></td><td>IP68（在最深6米的水下停留时间最长可达30分钟）</td></tr>
                        <tr><td><strong>操作系统</strong></td><td>iOS 16</td></tr>
                        <tr><td><strong>尺寸</strong></td><td>147.5 × 71.5 × 7.85 毫米</td></tr>
                        <tr><td><strong>重量</strong></td><td>206 克</td></tr>
                    </table>
                </div>
                
                <div role="tabpanel" class="tab-pane" id="reviews">
                    <div class="reviews-section">
                        <div class="review-item">
                            <div class="review-header">
                                <span class="reviewer-name">张先生</span>
                                <span class="review-date">2024-01-15</span>
                            </div>
                            <div class="review-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="review-content">
                                手机很不错，拍照效果非常好，系统流畅，电池续航也很给力。包装精美，物流很快。
                            </div>
                        </div>
                        
                        <div class="review-item">
                            <div class="review-header">
                                <span class="reviewer-name">李女士</span>
                                <span class="review-date">2024-01-12</span>
                            </div>
                            <div class="review-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <div class="review-content">
                                整体满意，就是价格有点贵。不过质量确实很好，用起来很顺手。
                            </div>
                        </div>
                        
                        <div class="review-item">
                            <div class="review-header">
                                <span class="reviewer-name">王先生</span>
                                <span class="review-date">2024-01-10</span>
                            </div>
                            <div class="review-rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="review-content">
                                非常满意的一次购物，手机性能强劲，摄像头效果超出预期。客服态度也很好。
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 相关商品推荐 -->
        <div class="related-products">
            <h3><i class="fa fa-heart"></i> 相关商品推荐</h3>
            <div class="row" style="margin-top: 30px;">
                <div class="col-md-3 col-sm-6">
                    <div class="related-product-item">
                        <div class="related-product-image">
                            <i class="fa fa-laptop"></i>
                        </div>
                        <div class="related-product-title">MacBook Pro</div>
                        <div class="related-product-price">¥12,999.00</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="related-product-item">
                        <div class="related-product-image">
                            <i class="fa fa-tablet"></i>
                        </div>
                        <div class="related-product-title">iPad Pro</div>
                        <div class="related-product-price">¥6,999.00</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="related-product-item">
                        <div class="related-product-image">
                            <i class="fa fa-clock-o"></i>
                        </div>
                        <div class="related-product-title">Apple Watch</div>
                        <div class="related-product-price">¥2,999.00</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="related-product-item">
                        <div class="related-product-image">
                            <i class="fa fa-headphones"></i>
                        </div>
                        <div class="related-product-title">AirPods Pro</div>
                        <div class="related-product-price">¥1,999.00</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // 缩略图切换
        $('.thumbnail').click(function() {
            $('.thumbnail').removeClass('active');
            $(this).addClass('active');
            
            var icon = $(this).data('icon');
            $('#mainImage').html('<i class="fa ' + icon + '"></i>');
        });
        
        // 数量控制
        function increaseQuantity() {
            var quantity = parseInt($('#quantity').val());
            if (quantity < 10) {
                $('#quantity').val(quantity + 1);
            }
        }
        
        function decreaseQuantity() {
            var quantity = parseInt($('#quantity').val());
            if (quantity > 1) {
                $('#quantity').val(quantity - 1);
            }
        }
        
        // 加入购物车
        function addToCart() {
            <% if (session.getAttribute("loginName") != null) { %>
                var quantity = parseInt($('#quantity').val());
                var productId = window.currentProductId;
                
                if (!productId) {
                    alert('商品信息加载中，请稍后重试');
                    return;
                }
                
                if (quantity <= 0) {
                    alert('请选择正确的商品数量');
                    return;
                }
                
                showLoading('正在添加到购物车...');
                
                $.ajax({
                    url: '${ctx}/web/cart/add',
                    type: 'POST',
                    data: {
                        productId: productId,
                        quantity: quantity
                    },
                    dataType: 'json',
                    success: function(response) {
                        hideLoading();
                        if (response.code === 0) {
                            alert('商品已成功加入购物车！数量：' + quantity);
                        } else {
                            alert(response.msg || '添加购物车失败');
                        }
                    },
                    error: function(xhr, status, error) {
                        hideLoading();
                        console.error('添加购物车失败:', error);
                        alert('网络错误，请稍后重试');
                    }
                });
            <% } else { %>
                alert('请先登录后再购买商品');
                window.location.href = '${ctx}/login.jsp';
            <% } %>
        }
        
        // 立即购买
        function buyNow() {
            <% if (session.getAttribute("loginName") != null) { %>
                var quantity = $('#quantity').val();
                showLoading('正在跳转到结算页面...');
                
                // 模拟跳转
                setTimeout(function() {
                    hideLoading();
                    alert('跳转到结算页面（功能开发中）');
                }, 1000);
            <% } else { %>
                alert('请先登录后再购买商品');
                window.location.href = '${ctx}/login.jsp';
            <% } %>
        }
        
        // 根据URL参数加载商品信息
        $(document).ready(function() {
            var urlParams = new URLSearchParams(window.location.search);
            var productId = urlParams.get('id');
            
            if (productId) {
                loadProductDetail(productId);
            } else {
                alert('商品ID不能为空');
                window.location.href = '${ctx}/web/products.jsp';
            }
        });
        
        // 调用后端API获取商品详情
        function loadProductDetail(productId) {
            showLoading('正在加载商品详情...');
            
            $.ajax({
                url: '${ctx}/web/product',
                type: 'GET',
                data: { opt: 'detail', id: productId },
                dataType: 'json',
                success: function(response) {
                    hideLoading();
                    if (response.code === 0 && response.data) {
                        renderProductDetail(response.data);
                    } else {
                        alert(response.msg || '获取商品详情失败');
                        window.location.href = '${ctx}/web/products.jsp';
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    console.error('获取商品详情失败:', error);
                    alert('网络错误，请稍后重试');
                }
            });
        }
        
        // 渲染商品详情
        function renderProductDetail(product) {
            // 更新商品基本信息
            $('#productTitle').text(product.productName || '商品名称');
            $('#currentPrice').text('¥' + (product.price || 0).toFixed(2));
            
            // 更新商品图标
            var icon = getProductIcon(product.productName || '');
            $('#mainImage').html('<i class="fa ' + icon + '"></i>');
            $('.thumbnail.active').html('<i class="fa ' + icon + '"></i>');
            
            // 更新评分
            if (product.rating) {
                var stars = '';
                var fullStars = Math.floor(product.rating);
                var hasHalfStar = product.rating % 1 >= 0.5;
                
                for (var i = 0; i < fullStars; i++) {
                    stars += '<i class="fa fa-star"></i>';
                }
                if (hasHalfStar) {
                    stars += '<i class="fa fa-star-half-o"></i>';
                }
                var emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
                for (var i = 0; i < emptyStars; i++) {
                    stars += '<i class="fa fa-star-o"></i>';
                }
                
                $('.rating-stars').html(stars);
                $('.rating-text').text('(' + (product.rating || 0).toFixed(1) + '分)');
            }
            
            // 更新商品规格
            var specsHtml = '';
            if (product.productCode) {
                specsHtml += '<div class="spec-item"><div class="spec-label">商品编码:</div><div class="spec-value">' + product.productCode + '</div></div>';
            }
            if (product.originPlace) {
                specsHtml += '<div class="spec-item"><div class="spec-label">产地:</div><div class="spec-value">' + product.originPlace + '</div></div>';
            }
            if (product.stock !== undefined) {
                specsHtml += '<div class="spec-item"><div class="spec-label">库存:</div><div class="spec-value">' + product.stock + '件</div></div>';
            }
            if (product.sales !== undefined) {
                specsHtml += '<div class="spec-item"><div class="spec-label">销量:</div><div class="spec-value">' + product.sales + '件</div></div>';
            }
            if (product.shelfLife) {
                specsHtml += '<div class="spec-item"><div class="spec-label">保质期:</div><div class="spec-value">' + product.shelfLife + '</div></div>';
            }
            if (product.storageMethod) {
                specsHtml += '<div class="spec-item"><div class="spec-label">储存方式:</div><div class="spec-value">' + product.storageMethod + '</div></div>';
            }
            
            $('.product-specs').html(specsHtml);
            
            // 更新商品描述
            if (product.description) {
                $('#description .description-content').html(
                    '<h3>产品介绍</h3>' +
                    '<p>' + product.description + '</p>' +
                    (product.nutritionInfo ? '<h4>营养信息</h4><p>' + product.nutritionInfo + '</p>' : '')
                );
            }
            
            // 更新规格参数表格
            var specsTableHtml = '';
            if (product.productCode) specsTableHtml += '<tr><td><strong>商品编码</strong></td><td>' + product.productCode + '</td></tr>';
            if (product.originPlace) specsTableHtml += '<tr><td><strong>产地</strong></td><td>' + product.originPlace + '</td></tr>';
            if (product.rating) specsTableHtml += '<tr><td><strong>评分</strong></td><td>' + product.rating.toFixed(1) + '分</td></tr>';
            if (product.sales !== undefined) specsTableHtml += '<tr><td><strong>销量</strong></td><td>' + product.sales + '件</td></tr>';
            if (product.stock !== undefined) specsTableHtml += '<tr><td><strong>库存</strong></td><td>' + product.stock + '件</td></tr>';
            if (product.shelfLife) specsTableHtml += '<tr><td><strong>保质期</strong></td><td>' + product.shelfLife + '</td></tr>';
            if (product.storageMethod) specsTableHtml += '<tr><td><strong>储存方式</strong></td><td>' + product.storageMethod + '</td></tr>';
            if (product.nutritionInfo) specsTableHtml += '<tr><td><strong>营养信息</strong></td><td>' + product.nutritionInfo + '</td></tr>';
            
            $('#specifications table').html(specsTableHtml);
            
            // 存储商品ID用于购物车操作
            window.currentProductId = product.id;
        }
        
        // 根据商品名称获取图标
        function getProductIcon(productName) {
            var name = productName.toLowerCase();
            if (name.includes('苹果') || name.includes('apple')) return 'fa-apple';
            if (name.includes('香蕉') || name.includes('banana')) return 'fa-pagelines';
            if (name.includes('橙') || name.includes('orange')) return 'fa-circle';
            if (name.includes('葡萄') || name.includes('grape')) return 'fa-circle-o';
            if (name.includes('草莓') || name.includes('strawberry')) return 'fa-heart';
            if (name.includes('西瓜') || name.includes('watermelon')) return 'fa-circle';
            if (name.includes('菠萝') || name.includes('pineapple')) return 'fa-star';
            if (name.includes('芒果') || name.includes('mango')) return 'fa-leaf';
            if (name.includes('樱桃') || name.includes('cherry')) return 'fa-circle';
            if (name.includes('桃') || name.includes('peach')) return 'fa-heart-o';
            if (name.includes('梨') || name.includes('pear')) return 'fa-lightbulb-o';
            if (name.includes('柠檬') || name.includes('lemon')) return 'fa-sun-o';
            return 'fa-leaf'; // 默认图标
        }
    </script>
</body>
</html>