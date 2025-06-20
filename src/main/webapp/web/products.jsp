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
    
    <!-- 搜索区域 -->
    <div class="container" style="margin-top: 20px;">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="input-group input-group-lg">
                    <input type="text" class="form-control" id="searchInput" placeholder="搜索商品名称...">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="button" id="searchBtn">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 筛选区域 -->
    <div class="filter-section">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <div class="filter-item">
                        <label>分类：</label><br>
                        <button class="filter-btn active" data-category="">全部</button>
                        <button class="filter-btn" data-category="1">水果</button>
                        <button class="filter-btn" data-category="2">蔬菜</button>
                        <button class="filter-btn" data-category="3">坚果</button>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="filter-item">
                        <label>价格：</label><br>
                        <button class="filter-btn active" data-price="">全部</button>
                        <button class="filter-btn" data-price="low">¥50以下</button>
                        <button class="filter-btn" data-price="medium">¥50-200</button>
                        <button class="filter-btn" data-price="high">¥200以上</button>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="filter-item">
                        <label>特性：</label><br>
                        <button class="filter-btn" data-organic="true">有机</button>
                        <button class="filter-btn" data-seasonal="true">时令</button>
                        <button class="filter-btn" data-fresh="true">新鲜</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="filter-item">
                        <label>产地：</label><br>
                        <button class="filter-btn" data-origin="山东">山东</button>
                        <button class="filter-btn" data-origin="新疆">新疆</button>
                        <button class="filter-btn" data-origin="海南">海南</button>
                        <button class="filter-btn" data-origin="进口">进口</button>
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
        // 全局变量
        var currentProducts = [];
        var currentPage = 1;
        var pageSize = 12;
        var totalPages = 1;
        var currentFilters = {
            categoryId: null,
            minPrice: null,
            maxPrice: null,
            isOrganic: null,
            isSeasonal: null,
            originPlace: null,
            sortField: null,
            sortOrder: null,
            productName: null
        };
        
        // API调用函数
        function callProductAPI(opt, params, callback) {
            var url = '${ctx}/web/product?opt=' + opt;
            
            // 添加参数到URL
            if (params) {
                for (var key in params) {
                    if (params[key] !== null && params[key] !== undefined && params[key] !== '') {
                        url += '&' + key + '=' + encodeURIComponent(params[key]);
                    }
                }
            }
            
            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.code === 0) {
                        callback(response.data);
                    } else {
                        console.error('API调用失败:', response.msg);
                        alert('数据加载失败: ' + response.msg);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX请求失败:', error);
                    alert('网络请求失败，请稍后重试');
                }
            });
        }
        
        // 渲染商品列表
        function renderProducts(data) {
            var container = $('#productsContainer');
            container.empty();
            
            var productList = [];
            if (data && data.rows) {
                // 分页数据格式
                productList = data.rows;
                totalPages = Math.ceil(data.total / pageSize);
                updatePagination();
            } else if (Array.isArray(data)) {
                // 直接数组格式
                productList = data;
            }
            
            if (productList.length === 0) {
                container.html('<div class="col-12 text-center"><p class="text-muted">暂无商品数据</p></div>');
                return;
            }
            
            productList.forEach(function(product) {
                var stars = '';
                var rating = product.rating || 0;
                for (var i = 0; i < 5; i++) {
                    stars += i < rating ? '<i class="fa fa-star"></i>' : '<i class="fa fa-star-o"></i>';
                }
                
                // 根据商品名称生成图标
                var icon = getProductIcon(product.productName || product.name);
                var price = product.price || product.salePrice || 0;
                var productName = product.productName || product.name || '未知商品';
                var productId = product.productId || product.id;
                
                var productHtml = `
                    <div class="col-md-3 col-sm-6">
                        <div class="product-item">
                            <div class="product-image">
                                <i class="fa ${icon}"></i>
                            </div>
                            <div class="product-title">${productName}</div>
                            <div class="product-rating">${stars} (${rating})</div>
                            <div class="product-price">¥${parseFloat(price).toFixed(2)}</div>
                            ${product.isOrganic ? '<span class="badge badge-success">有机</span>' : ''}
                            ${product.isSeasonal ? '<span class="badge badge-warning">时令</span>' : ''}
                            <div class="product-meta">
                                <small class="text-muted">产地: ${product.originPlace || '未知'}</small><br>
                                <small class="text-muted">销量: ${product.salesCount || 0}</small>
                            </div>
                            <div class="product-actions">
                                <button class="btn btn-detail" onclick="viewProduct(${productId})">
                                    <i class="fa fa-eye"></i> 详情
                                </button>
                                <button class="btn btn-cart" onclick="addToCart(${productId})">
                                    <i class="fa fa-cart-plus"></i> 购买
                                </button>
                            </div>
                        </div>
                    </div>
                `;
                container.append(productHtml);
            });
        }
        
        // 根据商品名称获取图标
        function getProductIcon(productName) {
            if (!productName) return 'fa-cube';
            
            var name = productName.toLowerCase();
            if (name.includes('苹果') || name.includes('apple')) return 'fa-apple';
            if (name.includes('香蕉') || name.includes('banana')) return 'fa-leaf';
            if (name.includes('橙') || name.includes('orange')) return 'fa-circle';
            if (name.includes('葡萄') || name.includes('grape')) return 'fa-circle-o';
            if (name.includes('草莓') || name.includes('strawberry')) return 'fa-heart';
            if (name.includes('西瓜') || name.includes('watermelon')) return 'fa-circle';
            if (name.includes('桃') || name.includes('peach')) return 'fa-heart-o';
            if (name.includes('梨') || name.includes('pear')) return 'fa-leaf';
            return 'fa-cube';
        }
        
        // 加载商品列表
        function loadProducts() {
            var params = {
                pageNum: currentPage,
                pageSize: pageSize
            };
            
            // 添加筛选条件
            Object.assign(params, currentFilters);
            
            callProductAPI('list', params, function(data) {
                currentProducts = data;
                renderProducts(data);
            });
        }
        
        // 筛选商品
        function filterProducts() {
            // 重置到第一页
            currentPage = 1;
            
            // 获取当前筛选条件
            var activeCategory = $('.filter-btn[data-category].active').data('category');
            var activePrice = $('.filter-btn[data-price].active').data('price');
            
            // 获取特性筛选（可多选）
            var organicBtn = $('.filter-btn[data-organic].active');
            var seasonalBtn = $('.filter-btn[data-seasonal].active');
            var freshBtn = $('.filter-btn[data-fresh].active');
            
            // 获取产地筛选
            var activeOrigin = $('.filter-btn[data-origin].active').data('origin');
            
            // 更新筛选条件
            currentFilters.oneCategoryId = activeCategory || null;
            
            // 价格筛选
            if (activePrice) {
                switch(activePrice) {
                    case 'low':
                        currentFilters.minPrice = null;
                        currentFilters.maxPrice = 50;
                        break;
                    case 'medium':
                        currentFilters.minPrice = 50;
                        currentFilters.maxPrice = 200;
                        break;
                    case 'high':
                        currentFilters.minPrice = 200;
                        currentFilters.maxPrice = null;
                        break;
                }
            } else {
                currentFilters.minPrice = null;
                currentFilters.maxPrice = null;
            }
            
            // 特性筛选
            currentFilters.isOrganic = organicBtn.length > 0 ? true : null;
            currentFilters.isSeasonal = seasonalBtn.length > 0 ? true : null;
            
            // 产地筛选
            currentFilters.originPlace = activeOrigin || null;
            
            loadProducts();
        }
        
        // 排序商品
        function sortProducts(sortType) {
            currentPage = 1;
            
            switch(sortType) {
                case 'price-asc':
                    currentFilters.sortField = 'price';
                    currentFilters.sortOrder = 'asc';
                    break;
                case 'price-desc':
                    currentFilters.sortField = 'price';
                    currentFilters.sortOrder = 'desc';
                    break;
                case 'rating':
                    currentFilters.sortField = 'rating';
                    currentFilters.sortOrder = 'desc';
                    break;
                case 'sales':
                    currentFilters.sortField = 'salesCount';
                    currentFilters.sortOrder = 'desc';
                    break;
                default:
                    currentFilters.sortField = null;
                    currentFilters.sortOrder = null;
            }
            
            loadProducts();
        }
        
        // 更新分页
        function updatePagination() {
            var paginationHtml = '';
            
            // 上一页
            if (currentPage > 1) {
                paginationHtml += '<li><a href="#" onclick="goToPage(' + (currentPage - 1) + ')"><i class="fa fa-angle-left"></i></a></li>';
            } else {
                paginationHtml += '<li class="disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li>';
            }
            
            // 页码
            var startPage = Math.max(1, currentPage - 2);
            var endPage = Math.min(totalPages, currentPage + 2);
            
            for (var i = startPage; i <= endPage; i++) {
                if (i === currentPage) {
                    paginationHtml += '<li class="active"><a href="#">' + i + '</a></li>';
                } else {
                    paginationHtml += '<li><a href="#" onclick="goToPage(' + i + ')">' + i + '</a></li>';
                }
            }
            
            // 下一页
            if (currentPage < totalPages) {
                paginationHtml += '<li><a href="#" onclick="goToPage(' + (currentPage + 1) + ')"><i class="fa fa-angle-right"></i></a></li>';
            } else {
                paginationHtml += '<li class="disabled"><a href="#"><i class="fa fa-angle-right"></i></a></li>';
            }
            
            $('.pagination').html(paginationHtml);
        }
        
        // 跳转到指定页
        function goToPage(page) {
            if (page >= 1 && page <= totalPages && page !== currentPage) {
                currentPage = page;
                loadProducts();
            }
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
            // 获取URL参数
            var urlParams = new URLSearchParams(window.location.search);
            var categoryId = urlParams.get('categoryId');
            var keyword = urlParams.get('keyword');
            
            // 设置初始筛选条件
            if (categoryId) {
                currentFilters.oneCategoryId = parseInt(categoryId);
                $('.filter-btn[data-category="' + categoryId + '"]').addClass('active');
            }
            if (keyword) {
                currentFilters.productName = keyword;
            }
            
            // 初始化商品列表
            loadProducts();
            
            // 筛选按钮事件
            $('.filter-btn').click(function() {
                const $this = $(this);
                
                // 判断筛选类型
                if (this.dataset.category !== undefined) {
                    // 分类筛选 - 单选
                    $('.filter-btn[data-category]').removeClass('active');
                    $this.addClass('active');
                } else if (this.dataset.price !== undefined) {
                    // 价格筛选 - 单选
                    $('.filter-btn[data-price]').removeClass('active');
                    $this.addClass('active');
                } else if (this.dataset.origin !== undefined) {
                    // 产地筛选 - 单选
                    $('.filter-btn[data-origin]').removeClass('active');
                    $this.addClass('active');
                } else if (this.dataset.organic !== undefined || this.dataset.seasonal !== undefined || this.dataset.fresh !== undefined) {
                    // 特性筛选 - 可多选，点击切换状态
                    $this.toggleClass('active');
                }
                
                // 执行筛选
                filterProducts();
            });
            
            // 排序选择事件
            $('#sortSelect').change(function() {
                sortProducts($(this).val());
            });
            
            // 搜索功能
            $('#searchInput').on('keypress', function(e) {
                if (e.which === 13) {
                    var keyword = $(this).val().trim();
                    if (keyword) {
                        currentFilters.productName = keyword;
                        currentPage = 1;
                        loadProducts();
                    }
                }
            });
            
            // 搜索按钮
            $('#searchBtn').click(function() {
                var keyword = $('#searchInput').val().trim();
                if (keyword) {
                    currentFilters.productName = keyword;
                    currentPage = 1;
                    loadProducts();
                }
            });
        });
    </script>
</body>
</html>