<%--
  Created by IntelliJ IDEA.
  User: Annisia
  Date: 2022-05-16
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>向日葵水果 - 新鲜水果直达您家</title>
    <meta name="description" content="向日葵水果 - 新鲜优质水果，健康生活从这里开始">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    <style>
        /* 首页特定样式 - 使用Flexbox布局 */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        .search-box {
            background-color: #34495e;
            padding: 20px 0;
            margin-top: 0;
        }
        
        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .search-input {
            border-radius: 25px;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            flex: 1;
        }
        
        .search-btn {
            background-color: #e74c3c;
            border: none;
            border-radius: 25px;
            padding: 12px 25px;
            color: white;
            font-size: 16px;
            margin-left: 10px;
            cursor: pointer;
        }
        
        .search-btn:hover {
            background-color: #c0392b;
            color: white;
        }
        
        .carousel-item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        
        .section {
            background-color: white;
            padding: 40px 20px;
            margin: 20px 0;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .category-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .category-item {
            flex: 1;
            min-width: 150px;
            max-width: 180px;
            text-align: center;
            padding: 25px 15px;
            background-color: #f8f9fa;
            border-radius: 12px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .category-item:hover {
            background-color: #3498db;
            color: white;
            transform: translateY(-8px);
            border-color: #2980b9;
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
        }
        
        .category-icon {
            font-size: 48px;
            margin-bottom: 15px;
            color: #3498db;
            transition: color 0.3s ease;
        }
        
        .category-item:hover .category-icon {
            color: white;
        }
        
        .products-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .product-card {
            flex: 1;
            min-width: 280px;
            max-width: 320px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }
        
        .product-card:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            transform: translateY(-5px);
            border-color: #3498db;
        }
        
        .loading-placeholder {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
        
        .view-more-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .product-img {
            width: 100%;
            height: 200px;
            background-color: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            color: #bdc3c7;
            font-size: 48px;
        }
        .product-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .product-price {
            font-size: 18px;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .product-info {
            margin-bottom: 15px;
            font-size: 12px;
            color: #7f8c8d;
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 8px;
        }
        
        .product-rating .stars {
            color: #f39c12;
            margin-right: 5px;
        }
        
        .product-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 11px;
            color: #95a5a6;
        }
        
        .product-actions {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
        
        .btn-buy {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
            font-size: 12px;
            flex: 1;
        }
        
        .btn-buy:hover {
            background-color: #c0392b;
            color: white;
        }
        
        .btn-detail {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
            font-size: 12px;
            flex: 1;
        }
        
        .btn-detail:hover {
            background-color: #2980b9;
            color: white;
        }
        .section-title {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-size: 28px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>

    <!-- 搜索栏 -->
<%--    <div class="search-box">--%>
<%--        <div class="container">--%>
<%--            <div class="row">--%>
<%--                <div class="col-md-8 col-md-offset-2">--%>
<%--                    <div class="input-group">--%>
<%--                        <input type="text" class="form-control search-input" placeholder="搜索您想要的商品..." id="searchInput">--%>
<%--                        <span class="input-group-btn">--%>
<%--                            <button class="btn search-btn" type="button" onclick="searchProducts()">--%>
<%--                                <i class="fa fa-search"></i> 搜索--%>
<%--                            </button>--%>
<%--                        </span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

    <!-- 主要内容区域 -->
    <div class="container main-container">
        <!-- 轮播图 -->
        <div id="carousel-banner" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carousel-banner" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-banner" data-slide-to="1"></li>
                <li data-target="#carousel-banner" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active">
                    <div style="height: 400px; background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-sun-o" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>新鲜水果</h2>
                            <p style="font-size: 24px;">每日新鲜直达</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div style="height: 400px; background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-leaf" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>有机认证</h2>
                            <p style="font-size: 24px;">绿色健康保证</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div style="height: 400px; background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-truck" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>当日配送</h2>
                            <p style="font-size: 24px;">新鲜直达您家</p>
                        </div>
                    </div>
                </div>
            </div>
            <a class="left carousel-control" href="#carousel-banner" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-banner" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>

    <!-- 商品分类 -->
    <div class="main-container">
        <div class="section">
            <h2 class="section-title">水果分类</h2>
            <div class="category-grid">
                <div class="category-item" data-category="citrus" onclick="location.href='${ctx}/web/category.jsp?type=citrus'">
                    <div class="category-icon">
                        <i class="fa fa-circle-o" style="color: #f39c12;"></i>
                    </div>
                    <h4>柑橘类</h4>
                </div>
                <div class="category-item" data-category="berry" onclick="location.href='${ctx}/web/category.jsp?type=berry'">
                    <div class="category-icon">
                        <i class="fa fa-circle" style="color: #8e44ad;"></i>
                    </div>
                    <h4>浆果类</h4>
                </div>
                <div class="category-item" data-category="tropical" onclick="location.href='${ctx}/web/category.jsp?type=tropical'">
                    <div class="category-icon">
                        <i class="fa fa-sun-o" style="color: #e67e22;"></i>
                    </div>
                    <h4>热带水果</h4>
                </div>
                <div class="category-item" data-category="stone" onclick="location.href='${ctx}/web/category.jsp?type=stone'">
                    <div class="category-icon">
                        <i class="fa fa-heart" style="color: #e74c3c;"></i>
                    </div>
                    <h4>核果类</h4>
                </div>
                <div class="category-item" data-category="melon" onclick="location.href='${ctx}/web/category.jsp?type=melon'">
                    <div class="category-icon">
                        <i class="fa fa-circle" style="color: #27ae60;"></i>
                    </div>
                    <h4>瓜果类</h4>
                </div>
                <div class="category-item" data-category="gift" onclick="location.href='${ctx}/web/gift.jsp'">
                    <div class="category-icon">
                        <i class="fa fa-gift" style="color: #9b59b6;"></i>
                    </div>
                    <h4>礼品装</h4>
                </div>
            </div>
        </div>
    </div>

    <!-- 热门商品 -->
    <div class="main-container">
        <div class="section">
            <h2 class="section-title">热门水果</h2>
            <div class="products-grid" id="hotProducts">
                <!-- 热门商品将在这里动态加载 -->
                <div class="loading-placeholder">
                    <p>正在加载热门商品...</p>
                </div>
            </div>
            <div class="view-more-container">
                <button class="btn btn-primary btn-lg" onclick="viewAllProducts()">
                    查看更多水果 <i class="fa fa-arrow-right"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- 推荐商品 -->
    <div class="main-container">
        <div class="section">
            <h2 class="section-title">时令推荐</h2>
            <div class="products-grid" id="recommendProducts">
                <!-- 推荐商品将在这里动态加载 -->
                <div class="loading-placeholder">
                    <p>正在加载推荐商品...</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    <script>
        // 首页特有的JavaScript功能
        
        // 搜索商品
        function searchProducts() {
            var keyword = document.getElementById('searchInput').value;
            if (keyword.trim() === '') {
                alert('请输入搜索关键词');
                return;
            }
            // 跳转到商品搜索页面
            window.location.href = '${ctx}/web/search.jsp?keyword=' + encodeURIComponent(keyword);
        }

        // 回车搜索
        function initSearchInput() {
            var searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        searchProducts();
                    }
                });
            }
        }

        // 商品分类跳转
        function goToCategory(category) {
            window.location.href = '${ctx}/web/category.jsp?category=' + encodeURIComponent(category);
        }

        // 加入购物车
        function addToCart(productId) {
            <% if (session.getAttribute("loginName") != null) { %>
                if (typeof showLoading === 'function') {
                    showLoading('正在添加到购物车...');
                }
                $.ajax({
                    url: '${ctx}/cart/add',
                    type: 'POST',
                    data: {
                        productId: productId,
                        quantity: 1
                    },
                    success: function(response) {
                        if (typeof hideLoading === 'function') {
                            hideLoading();
                        }
                        if (response.success) {
                            alert('商品已成功加入购物车！');
                        } else {
                            alert('添加失败：' + response.message);
                        }
                    },
                    error: function() {
                        if (typeof hideLoading === 'function') {
                            hideLoading();
                        }
                        alert('网络错误，请稍后重试');
                    }
                });
            <% } else { %>
                alert('请先登录后再购买商品');
                window.location.href = '${ctx}/login.jsp';
            <% } %>
        }

        // 查看更多商品
        function viewAllProducts() {
            window.location.href = '${ctx}/web/products.jsp';
        }

        // 加载热门商品
        function loadHotProducts() {
            $.ajax({
                url: '${ctx}/web/product',
                type: 'GET',
                data: {
                    opt: 'hot',
                    limit: 8
                },
                success: function(res) {
                    console.log(res)
                    if (res.code === 0 && res.data) {
                        renderProducts(res.data, 'hotProducts');
                    } else {
                        console.error('加载热门商品失败:', res.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('加载热门商品出错:', error);
                }
            });
        }

        // 加载推荐商品
        function loadRecommendedProducts() {
            $.ajax({
                url: '${ctx}/web/product',
                type: 'GET',
                data: {
                    opt: 'recommended',
                    limit: 8
                },
                success: function(response) {
                    if (response.code === 0 && response.data) {
                        renderProducts(response.data, 'recommendProducts');
                    } else {
                        console.error('加载推荐商品失败:', response.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('加载推荐商品出错:', error);
                }
            });
        }

        // 渲染商品列表
        function renderProducts(products, containerId) {
            var container = $('#' + containerId);
            if (!container.length) {
                console.error('容器不存在:', containerId);
                return;
            }
            
            container.empty();
            
            if (!products || products.length === 0) {
                container.html('<div class="loading-placeholder"><p>暂无商品数据</p></div>');
                return;
            }
            
            $.each(products, function(index, product) {
                var productHtml = createProductCard(product);
                container.append(productHtml);
            });
        }

        // 创建商品卡片HTML
        function createProductCard(product) {
            var imageHtml = '';
            if (product.imageUrl && product.imageUrl.trim() !== '') {
                imageHtml = '<img src="' + product.imageUrl + '" alt="' + product.productName + '" style="width: 100%; height: 200px; object-fit: cover; border-radius: 5px;">';
            } else {
                // 根据商品名称选择合适的图标
                var iconClass = getProductIcon(product.productName);
                var bgColor = getProductBgColor(product.productName);
                imageHtml = '<div class="product-img" style="background: ' + bgColor + '; color: white;"><i class="fa ' + iconClass + '" style="font-size: 60px;"></i></div>';
            }
            
            var price = product.price ? '¥' + parseFloat(product.price).toFixed(2) : '价格面议';
            var unit = product.weightUnit || '/斤';
            var rating = product.rating ? parseFloat(product.rating).toFixed(1) : '0.0';
            var salesCount = product.salesCount || 0;
            var originPlace = product.originPlace || '未知产地';
            var isOrganic = product.isOrganic ? '有机' : '';
            var isSeasonal = product.isSeasonal ? '时令' : '';
            
            // 生成星级评分
            var starsHtml = '';
            var fullStars = Math.floor(rating);
            var hasHalfStar = (rating - fullStars) >= 0.5;
            
            for (var i = 0; i < fullStars; i++) {
                starsHtml += '<i class="fa fa-star"></i>';
            }
            if (hasHalfStar) {
                starsHtml += '<i class="fa fa-star-half-o"></i>';
            }
            for (var i = fullStars + (hasHalfStar ? 1 : 0); i < 5; i++) {
                starsHtml += '<i class="fa fa-star-o"></i>';
            }
            
            // 生成标签
            var tags = [];
            if (isOrganic) tags.push(isOrganic);
            if (isSeasonal) tags.push(isSeasonal);
            var tagsHtml = tags.length > 0 ? '<span style="color: #27ae60; font-size: 10px;">' + tags.join(' ') + '</span>' : '';
            
            return '<div class="product-card">' +
                   imageHtml +
                   '<div class="product-name">' + (product.productName || '未知商品') + ' ' + tagsHtml + '</div>' +
                   '<div class="product-rating">' +
                   '<span class="stars">' + starsHtml + '</span>' +
                   '<span>' + rating + '</span>' +
                   '</div>' +
                   '<div class="product-price">' + price + unit + '</div>' +
                   '<div class="product-meta">' +
                   '<span>销量: ' + salesCount + '</span>' +
                   '<span>' + originPlace + '</span>' +
                   '</div>' +
                   '<div class="product-actions">' +
                   '<button class="btn btn-detail" onclick="viewProductDetail(' + product.id + ')">' +
                   '<i class="fa fa-eye"></i> 详情' +
                   '</button>' +
                   '<button class="btn btn-buy" onclick="addToCart(' + product.id + ')">' +
                   '<i class="fa fa-cart-plus"></i> 购买' +
                   '</button>' +
                   '</div>' +
                   '</div>';
        }

        // 根据商品名称获取图标
        function getProductIcon(productName) {
            if (!productName) return 'fa-circle';
            var name = productName.toLowerCase();
            if (name.includes('橙') || name.includes('柑') || name.includes('橘')) return 'fa-circle-o';
            if (name.includes('苹果')) return 'fa-heart';
            if (name.includes('香蕉')) return 'fa-star';
            if (name.includes('葡萄') || name.includes('提子')) return 'fa-circle';
            if (name.includes('芒果') || name.includes('热带')) return 'fa-sun-o';
            if (name.includes('猕猴桃') || name.includes('奇异果')) return 'fa-circle';
            if (name.includes('草莓') || name.includes('莓')) return 'fa-heart';
            if (name.includes('柠檬')) return 'fa-circle';
            return 'fa-circle';
        }

        // 根据商品名称获取背景色
        function getProductBgColor(productName) {
            if (!productName) return 'linear-gradient(45deg, #95a5a6, #7f8c8d)';
            var name = productName.toLowerCase();
            if (name.includes('橙') || name.includes('柑') || name.includes('橘')) return 'linear-gradient(45deg, #f39c12, #e67e22)';
            if (name.includes('苹果')) return 'linear-gradient(45deg, #e74c3c, #c0392b)';
            if (name.includes('香蕉')) return 'linear-gradient(45deg, #f1c40f, #f39c12)';
            if (name.includes('葡萄') || name.includes('提子')) return 'linear-gradient(45deg, #8e44ad, #9b59b6)';
            if (name.includes('芒果') || name.includes('热带')) return 'linear-gradient(45deg, #e67e22, #d35400)';
            if (name.includes('猕猴桃') || name.includes('奇异果')) return 'linear-gradient(45deg, #27ae60, #2ecc71)';
            if (name.includes('草莓') || name.includes('莓')) return 'linear-gradient(45deg, #e74c3c, #c0392b)';
            if (name.includes('柠檬')) return 'linear-gradient(45deg, #f39c12, #e67e22)';
            return 'linear-gradient(45deg, #95a5a6, #7f8c8d)';
        }

        // 查看商品详情
        function viewProductDetail(productId) {
            if (!productId) {
                alert('商品ID无效');
                return;
            }
            
            // 使用模态框显示详情
            loadProductDetailModal(productId);
        }
        
        // 加载商品详情模态框（可选实现）
        function loadProductDetailModal(productId) {
            $.ajax({
                url: '${ctx}/web/product',
                type: 'GET',
                data: {
                    opt: 'detail',
                    id: productId
                },
                success: function(response) {
                    if (response.code === 0 && response.data) {
                        showProductDetailModal(response.data);
                    } else {
                        alert('获取商品详情失败: ' + response.msg);
                    }
                },
                error: function(xhr, status, error) {
                    alert('网络错误，请稍后重试');
                }
            });
        }
        
        // 显示商品详情模态框
        function showProductDetailModal(product) {
            var modalHtml = '<div class="modal fade" id="productDetailModal" tabindex="-1">' +
                           '<div class="modal-dialog modal-lg">' +
                           '<div class="modal-content">' +
                           '<div class="modal-header">' +
                           '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
                           '<h4 class="modal-title">' + product.productName + '</h4>' +
                           '</div>' +
                           '<div class="modal-body">' +
                           '<div class="row">' +
                           '<div class="col-md-6">' +
                           (product.imageUrl ? 
                               '<img src="' + product.imageUrl + '" class="img-responsive" style="width: 100%; border-radius: 8px;">' :
                               '<div style="height: 300px; background: linear-gradient(45deg, #3498db, #2980b9); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; border-radius: 8px;"><i class="fa fa-image"></i></div>'
                           ) +
                           '</div>' +
                           '<div class="col-md-6">' +
                           '<h3 style="color: #e74c3c;">¥' + parseFloat(product.price).toFixed(2) + (product.weightUnit || '/斤') + '</h3>' +
                           '<p><strong>商品编码:</strong> ' + (product.productCode || '无') + '</p>' +
                           '<p><strong>产地:</strong> ' + (product.originPlace || '未知') + '</p>' +
                           '<p><strong>评分:</strong> ' + (product.rating || '0.0') + ' 分</p>' +
                           '<p><strong>销量:</strong> ' + (product.salesCount || 0) + ' 件</p>' +
                           '<p><strong>库存:</strong> ' + (product.stock || 0) + ' 件</p>' +
                           '<p><strong>保质期:</strong> ' + (product.shelfLife || '未知') + ' 天</p>' +
                           '<p><strong>储存方式:</strong> ' + (product.storageMethod || '常温保存') + '</p>' +
                           '<p><strong>营养信息:</strong> ' + (product.nutritionInfo || '无') + '</p>' +
                           '<p><strong>商品描述:</strong> ' + (product.description || '暂无描述') + '</p>' +
                           '<div style="margin-top: 20px;">' +
                           '<button class="btn btn-primary btn-lg" onclick="addToCart(' + product.id + '); $(\"#productDetailModal\").modal(\"hide\");">' +
                           '<i class="fa fa-cart-plus"></i> 加入购物车' +
                           '</button>' +
                           '</div>' +
                           '</div>' +
                           '</div>' +
                           '</div>' +
                           '</div>' +
                           '</div>' +
                           '</div>';
            
            // 移除已存在的模态框
            $('#productDetailModal').remove();
            
            // 添加新的模态框并显示
            $('body').append(modalHtml);
            $('#productDetailModal').modal('show');
        }

        // 页面加载完成后初始化
        $(document).ready(function() {
            // 初始化轮播图
            $('#carousel-banner').carousel({
                interval: 5000, // 5秒自动切换
                pause: 'hover' // 鼠标悬停时暂停
            });
            
            // 初始化搜索输入框
            initSearchInput();
            
            // 分类卡片点击事件
            $('.category-item').click(function() {
                var category = $(this).data('category');
                if (category) {
                    goToCategory(category);
                }
            });
            
            // 加载商品数据
            loadHotProducts();
            loadRecommendedProducts();
        });
    </script>
</body>
</html>
