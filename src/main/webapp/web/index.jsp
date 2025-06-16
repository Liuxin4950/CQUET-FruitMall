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
    <title>欢迎光临——EmarketMall购物商城</title>
    <meta name="description" content="EmarketMall购物商城 - 您的购物首选">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    <style>
        /* 首页特定样式 */
        .search-box {
            background-color: #34495e;
            padding: 20px 0;
            margin-top: 0;
        }
        .search-input {
            border-radius: 25px;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
        }
        .search-btn {
            background-color: #e74c3c;
            border: none;
            border-radius: 25px;
            padding: 12px 25px;
            color: white;
            font-size: 16px;
            margin-left: 10px;
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
        .category-section {
            background-color: white;
            padding: 30px 0;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .category-item {
            text-align: center;
            padding: 20px;
            margin: 10px;
            background-color: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .category-item:hover {
            background-color: #3498db;
            color: white;
            transform: translateY(-5px);
        }
        .category-icon {
            font-size: 48px;
            margin-bottom: 15px;
            color: #3498db;
        }
        .category-item:hover .category-icon {
            color: white;
        }
        .product-section {
            background-color: white;
            padding: 30px 0;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .product-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            text-align: center;
            transition: all 0.3s ease;
            background-color: white;
        }
        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-3px);
        }
        .product-img {
            width: 100%;
            height: 200px;
            background-color: #f8f9fa;
            border-radius: 5px;
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
            margin-bottom: 15px;
        }
        .btn-buy {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        .btn-buy:hover {
            background-color: #c0392b;
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
                    <div style="height: 400px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-gift" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>春季大促销</h2>
                            <p style="font-size: 24px;">全场商品5折起</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div style="height: 400px; background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-star" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>新品上市</h2>
                            <p style="font-size: 24px;">最新潮流商品</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div style="height: 400px; background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        <div class="text-center">
                            <i class="fa fa-truck" style="font-size: 80px; margin-bottom: 20px;"></i>
                            <h2>免费配送</h2>
                            <p style="font-size: 24px;">满99元包邮</p>
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
    <div class="container">
        <div class="category-section">
            <h2 class="section-title">商品分类</h2>
            <div class="row">
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="electronics">
                        <div class="category-icon">
                            <i class="fa fa-laptop"></i>
                        </div>
                        <h4>数码电器</h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="clothing">
                        <div class="category-icon">
                            <i class="fa fa-female"></i>
                        </div>
                        <h4>服装鞋帽</h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="home">
                        <div class="category-icon">
                            <i class="fa fa-home"></i>
                        </div>
                        <h4>家居用品</h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="sports">
                        <div class="category-icon">
                            <i class="fa fa-futbol-o"></i>
                        </div>
                        <h4>运动户外</h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="books">
                        <div class="category-icon">
                            <i class="fa fa-book"></i>
                        </div>
                        <h4>图书文具</h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="category-item" data-category="food">
                        <div class="category-icon">
                            <i class="fa fa-cutlery"></i>
                        </div>
                        <h4>食品饮料</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 热门商品 -->
    <div class="container">
        <div class="product-section">
            <h2 class="section-title">热门商品</h2>
            <div class="row" id="hotProducts">
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-laptop"></i>
                        </div>
                        <div class="product-name">联想笔记本电脑</div>
                        <div class="product-price">¥4999.00</div>
                        <button class="btn btn-buy" onclick="addToCart(1)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-mobile"></i>
                        </div>
                        <div class="product-name">华为智能手机</div>
                        <div class="product-price">¥2999.00</div>
                        <button class="btn btn-buy" onclick="addToCart(2)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-headphones"></i>
                        </div>
                        <div class="product-name">无线蓝牙耳机</div>
                        <div class="product-price">¥299.00</div>
                        <button class="btn btn-buy" onclick="addToCart(3)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-camera"></i>
                        </div>
                        <div class="product-name">数码相机</div>
                        <div class="product-price">¥1999.00</div>
                        <button class="btn btn-buy" onclick="addToCart(4)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
            </div>
            <div class="text-center" style="margin-top: 30px;">
                <button class="btn btn-primary btn-lg" onclick="viewAllProducts()">
                    查看更多商品 <i class="fa fa-arrow-right"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- 推荐商品 -->
    <div class="container">
        <div class="product-section">
            <h2 class="section-title">推荐商品</h2>
            <div class="row" id="recommendProducts">
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-tshirt"></i>
                        </div>
                        <div class="product-name">时尚T恤</div>
                        <div class="product-price">¥99.00</div>
                        <button class="btn btn-buy" onclick="addToCart(5)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-coffee"></i>
                        </div>
                        <div class="product-name">咖啡机</div>
                        <div class="product-price">¥599.00</div>
                        <button class="btn btn-buy" onclick="addToCart(6)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-gamepad"></i>
                        </div>
                        <div class="product-name">游戏手柄</div>
                        <div class="product-price">¥199.00</div>
                        <button class="btn btn-buy" onclick="addToCart(7)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-card">
                        <div class="product-img">
                            <i class="fa fa-bicycle"></i>
                        </div>
                        <div class="product-name">山地自行车</div>
                        <div class="product-price">¥1299.00</div>
                        <button class="btn btn-buy" onclick="addToCart(8)">
                            <i class="fa fa-cart-plus"></i> 加入购物车
                        </button>
                    </div>
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
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchProducts();
            }
        });

        // 商品分类跳转
        function goToCategory(category) {
            window.location.href = '${ctx}/web/category.jsp?category=' + encodeURIComponent(category);
        }

        // 加入购物车
        function addToCart(productId) {
            <% if (session.getAttribute("loginName") != null) { %>
                showLoading('正在添加到购物车...');
                $.ajax({
                    url: '${ctx}/cart/add',
                    type: 'POST',
                    data: {
                        productId: productId,
                        quantity: 1
                    },
                    success: function(response) {
                        hideLoading();
                        if (response.success) {
                            alert('商品已成功加入购物车！');
                        } else {
                            alert('添加失败：' + response.message);
                        }
                    },
                    error: function() {
                        hideLoading();
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

        // 页面加载完成后初始化
        $(document).ready(function() {
            // 初始化轮播图
            $('#carousel-banner').carousel({
                interval: 5000, // 5秒自动切换
                pause: 'hover' // 鼠标悬停时暂停
            });
            
            // 商品卡片悬停效果
            $('.product-card').hover(
                function() {
                    $(this).find('.btn-buy').fadeIn(200);
                },
                function() {
                    $(this).find('.btn-buy').fadeOut(200);
                }
            );
            
            // 分类卡片点击事件
            $('.category-item').click(function() {
                var category = $(this).data('category');
                if (category) {
                    goToCategory(category);
                }
            });
        });
    </script>
</body>
</html>
