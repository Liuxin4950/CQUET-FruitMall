<%--
  Created by IntelliJ IDEA.
  User: Annisia
  Date: 2024-01-15
  Time: 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新鲜直达 - 向日葵水果</title>
    <meta name="description" content="向日葵水果新鲜直达 - 当日采摘，新鲜到家">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    <style>
        .fresh-hero {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .fresh-hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .fresh-hero p {
            font-size: 20px;
            margin-bottom: 30px;
        }
        .feature-section {
            padding: 60px 0;
            background-color: #f8f9fa;
        }
        .feature-item {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        .feature-item:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 60px;
            color: #27ae60;
            margin-bottom: 20px;
        }
        .product-grid {
            padding: 60px 0;
        }
        .fresh-product {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        .fresh-product:hover {
            transform: translateY(-5px);
        }
        .product-image {
            height: 200px;
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 60px;
        }
        .product-info {
            padding: 20px;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .product-desc {
            color: #7f8c8d;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .product-price {
            font-size: 20px;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .fresh-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #e74c3c;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>

    <!-- 新鲜直达横幅 -->
    <div class="fresh-hero">
        <div class="container">
            <h1><i class="fa fa-leaf"></i> 新鲜直达</h1>
            <p>当日采摘，新鲜到家 - 品质保证，健康生活</p>
            <button class="btn btn-warning btn-lg">
                <i class="fa fa-shopping-cart"></i> 立即选购
            </button>
        </div>
    </div>

    <!-- 特色服务 -->
    <div class="feature-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-clock-o"></i>
                        </div>
                        <h4>当日采摘</h4>
                        <p>每日清晨采摘，确保最佳新鲜度</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-truck"></i>
                        </div>
                        <h4>快速配送</h4>
                        <p>冷链运输，2小时内送达</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-shield"></i>
                        </div>
                        <h4>品质保证</h4>
                        <p>严格筛选，不满意包退换</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-leaf"></i>
                        </div>
                        <h4>有机认证</h4>
                        <p>绿色种植，健康无污染</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 新鲜水果展示 -->
    <div class="product-grid">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #2c3e50; font-size: 36px; font-weight: bold;">今日新鲜</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="fresh-product" style="position: relative;">
                        <div class="fresh-badge">今日特价</div>
                        <div class="product-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                            <i class="fa fa-circle-o"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">赣南脐橙</div>
                            <div class="product-desc">江西赣州特产，果肉饱满，酸甜可口</div>
                            <div class="product-price">¥15.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="fresh-product" style="position: relative;">
                        <div class="fresh-badge">限时抢购</div>
                        <div class="product-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                            <i class="fa fa-heart"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">烟台红富士</div>
                            <div class="product-desc">山东烟台苹果，脆嫩多汁，营养丰富</div>
                            <div class="product-price">¥18.60/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="fresh-product" style="position: relative;">
                        <div class="fresh-badge">新品上市</div>
                        <div class="product-image" style="background: linear-gradient(45deg, #f1c40f, #f39c12);">
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">海南香蕉</div>
                            <div class="product-desc">海南特产，香甜软糯，富含钾元素</div>
                            <div class="product-price">¥9.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="fresh-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #8e44ad, #9b59b6);">
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">新疆葡萄</div>
                            <div class="product-desc">新疆吐鲁番葡萄，粒大饱满，甜度极高</div>
                            <div class="product-price">¥22.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="fresh-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #e67e22, #d35400);">
                            <i class="fa fa-sun-o"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">海南芒果</div>
                            <div class="product-desc">海南特产芒果，果肉细腻，香甜浓郁</div>
                            <div class="product-price">¥25.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="fresh-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">陕西猕猴桃</div>
                            <div class="product-desc">陕西周至猕猴桃，维C之王，酸甜适中</div>
                            <div class="product-price">¥19.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>