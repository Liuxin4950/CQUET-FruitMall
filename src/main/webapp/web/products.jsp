<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表 - EmarketMall购物商城</title>
    <meta name="description" content="EmarketMall购物商城 - 商品列表">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .products-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
        }
        
        .filter-section {
            background-color: white;
            padding: 20px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .filter-item {
            margin-bottom: 15px;
        }
        
        .filter-item label {
            font-weight: bold;
            margin-right: 10px;
        }
        
        .filter-btn {
            margin: 2px;
            padding: 5px 15px;
            border: 1px solid #ddd;
            background-color: white;
            color: #333;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .filter-btn:hover,
        .filter-btn.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .products-grid {
            padding: 40px 0;
        }
        
        .product-item {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .product-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .product-image {
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
        
        .product-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
            height: 50px;
            overflow: hidden;
        }
        
        .product-price {
            font-size: 20px;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .product-rating {
            color: #f39c12;
            margin-bottom: 15px;
        }
        
        .product-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .btn-cart {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        
        .btn-cart:hover {
            background-color: #c0392b;
            color: white;
        }
        
        .btn-detail {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        
        .btn-detail:hover {
            background-color: #2980b9;
            color: white;
        }
        
        .pagination-wrapper {
            text-align: center;
            margin-top: 40px;
        }
        
        .sort-section {
            text-align: right;
            margin-bottom: 20px;
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 20px 0;
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
            <li class="active">商品列表</li>
        </ol>
    </div>
    
    <!-- 商品头部 -->
    <div class="products-header">
        <div class="container">
            <h1><i class="fa fa-fire"></i> 热门商品</h1>
            <p class="lead">发现最受欢迎的优质商品</p>
        </div>
    </div>
    
    <!-- 筛选区域 -->
    <div class="filter-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="filter-item">
                        <label>分类：</label><br>
                        <button class="filter-btn active" data-category="all">全部</button>
                        <button class="filter-btn" data-category="electronics">电子产品</button>
                        <button class="filter-btn" data-category="clothing">服装鞋帽</button>
                        <button class="filter-btn" data-category="home">家居生活</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="filter-item">
                        <label>价格：</label><br>
                        <button class="filter-btn active" data-price="all">全部</button>
                        <button class="filter-btn" data-price="0-100">¥0-100</button>
                        <button class="filter-btn" data-price="100-500">¥100-500</button>
                        <button class="filter-btn" data-price="500+">¥500以上</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="filter-item">
                        <label>品牌：</label><br>
                        <button class="filter-btn active" data-brand="all">全部</button>
                        <button class="filter-btn" data-brand="apple">Apple</button>
                        <button class="filter-btn" data-brand="samsung">Samsung</button>
                        <button class="filter-btn" data-brand="nike">Nike</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="sort-section">
                        <label>排序：</label>
                        <select class="form-control" id="sortSelect" style="display: inline-block; width: auto;">
                            <option value="default">默认排序</option>
                            <option value="price-asc">价格从低到高</option>
                            <option value="price-desc">价格从高到低</option>
                            <option value="rating">评分最高</option>
                            <option value="sales">销量最高</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 商品网格 -->
    <div class="container products-grid">
        <div class="row" id="productsContainer">
            <!-- 商品项将通过JavaScript动态生成 -->
        </div>
        
        <!-- 分页 -->
        <div class="pagination-wrapper">
            <nav>
                <ul class="pagination">
                    <li class="disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                </ul>
            </nav>
        </div>
    </div>
    
    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // 模拟商品数据
        var products = [
            {id: 1, name: 'iPhone 14 Pro', price: 7999, category: 'electronics', brand: 'apple', rating: 5, image: 'fa-mobile'},
            {id: 2, name: 'MacBook Pro', price: 12999, category: 'electronics', brand: 'apple', rating: 5, image: 'fa-laptop'},
            {id: 3, name: 'Samsung Galaxy S23', price: 5999, category: 'electronics', brand: 'samsung', rating: 4, image: 'fa-mobile'},
            {id: 4, name: 'Nike Air Max', price: 899, category: 'clothing', brand: 'nike', rating: 4, image: 'fa-shopping-bag'},
            {id: 5, name: '智能电视', price: 3999, category: 'home', brand: 'other', rating: 4, image: 'fa-tv'},
            {id: 6, name: '咖啡机', price: 599, category: 'home', brand: 'other', rating: 4, image: 'fa-coffee'},
            {id: 7, name: '游戏手柄', price: 199, category: 'electronics', brand: 'other', rating: 4, image: 'fa-gamepad'},
            {id: 8, name: '运动鞋', price: 699, category: 'clothing', brand: 'nike', rating: 4, image: 'fa-shopping-bag'},
            {id: 9, name: 'iPad Pro', price: 6999, category: 'electronics', brand: 'apple', rating: 5, image: 'fa-tablet'},
            {id: 10, name: '智能手表', price: 2999, category: 'electronics', brand: 'apple', rating: 4, image: 'fa-clock-o'},
            {id: 11, name: '蓝牙耳机', price: 299, category: 'electronics', brand: 'other', rating: 4, image: 'fa-headphones'},
            {id: 12, name: '办公椅', price: 1299, category: 'home', brand: 'other', rating: 4, image: 'fa-home'}
        ];
        
        var currentProducts = products;
        
        // 渲染商品列表
        function renderProducts(productList) {
            var container = $('#productsContainer');
            container.empty();
            
            productList.forEach(function(product) {
                var stars = '';
                for (var i = 0; i < 5; i++) {
                    stars += i < product.rating ? '<i class="fa fa-star"></i>' : '<i class="fa fa-star-o"></i>';
                }
                
                var productHtml = `
                    <div class="col-md-3 col-sm-6">
                        <div class="product-item">
                            <div class="product-image">
                                <i class="fa ${product.image}"></i>
                            </div>
                            <div class="product-title">${product.name}</div>
                            <div class="product-rating">${stars}</div>
                            <div class="product-price">¥${product.price.toFixed(2)}</div>
                            <div class="product-actions">
                                <button class="btn btn-detail" onclick="viewProduct(${product.id})">
                                    <i class="fa fa-eye"></i> 详情
                                </button>
                                <button class="btn btn-cart" onclick="addToCart(${product.id})">
                                    <i class="fa fa-cart-plus"></i> 购买
                                </button>
                            </div>
                        </div>
                    </div>
                `;
                container.append(productHtml);
            });
        }
        
        // 筛选商品
        function filterProducts() {
            var category = $('.filter-btn[data-category].active').data('category');
            var price = $('.filter-btn[data-price].active').data('price');
            var brand = $('.filter-btn[data-brand].active').data('brand');
            
            currentProducts = products.filter(function(product) {
                var categoryMatch = category === 'all' || product.category === category;
                var brandMatch = brand === 'all' || product.brand === brand;
                var priceMatch = true;
                
                if (price !== 'all') {
                    if (price === '0-100') {
                        priceMatch = product.price <= 100;
                    } else if (price === '100-500') {
                        priceMatch = product.price > 100 && product.price <= 500;
                    } else if (price === '500+') {
                        priceMatch = product.price > 500;
                    }
                }
                
                return categoryMatch && brandMatch && priceMatch;
            });
            
            renderProducts(currentProducts);
        }
        
        // 排序商品
        function sortProducts(sortType) {
            switch (sortType) {
                case 'price-asc':
                    currentProducts.sort((a, b) => a.price - b.price);
                    break;
                case 'price-desc':
                    currentProducts.sort((a, b) => b.price - a.price);
                    break;
                case 'rating':
                    currentProducts.sort((a, b) => b.rating - a.rating);
                    break;
                case 'sales':
                    // 模拟销量排序
                    currentProducts.sort((a, b) => b.id - a.id);
                    break;
                default:
                    currentProducts = products.slice();
                    filterProducts();
                    return;
            }
            renderProducts(currentProducts);
        }
        
        // 查看商品详情
        function viewProduct(productId) {
            window.location.href = '${ctx}/web/product-detail.jsp?id=' + productId;
        }
        
        // 加入购物车
        function addToCart(productId) {
            <% if (session.getAttribute("loginName") != null) { %>
                showLoading('正在添加到购物车...');
                // 模拟AJAX请求
                setTimeout(function() {
                    hideLoading();
                    alert('商品已成功加入购物车！');
                }, 1000);
            <% } else { %>
                alert('请先登录后再购买商品');
                window.location.href = '${ctx}/login.jsp';
            <% } %>
        }
        
        $(document).ready(function() {
            // 初始化商品列表
            renderProducts(products);
            
            // 筛选按钮事件
            $('.filter-btn').click(function() {
                var group = $(this).data('category') ? 'category' : 
                           $(this).data('price') ? 'price' : 'brand';
                
                $(this).siblings(`[data-${group}]`).removeClass('active');
                $(this).addClass('active');
                
                filterProducts();
            });
            
            // 排序选择事件
            $('#sortSelect').change(function() {
                sortProducts($(this).val());
            });
            
            // 商品项动画
            $('.product-item').each(function(index) {
                $(this).delay(index * 50).animate({
                    opacity: 1
                }, 300);
            });
        });
    </script>
</body>
</html>