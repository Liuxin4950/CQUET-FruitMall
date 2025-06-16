<%--
  Created by IntelliJ IDEA.
  User: Annisia
  Date: 2024-01-15
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>时令水果 - 向日葵水果</title>
    <meta name="description" content="向日葵水果时令水果 - 应季而食，健康生活">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    <style>
        .seasonal-hero {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .seasonal-hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .seasonal-hero p {
            font-size: 20px;
            margin-bottom: 30px;
        }
        .season-tabs {
            background: white;
            padding: 40px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .season-tab {
            display: inline-block;
            padding: 15px 30px;
            margin: 0 10px;
            background: #f8f9fa;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        .season-tab.active {
            background: #3498db;
            color: white;
            border-color: #2980b9;
        }
        .season-tab:hover {
            background: #e9ecef;
        }
        .season-tab.active:hover {
            background: #2980b9;
        }
        .season-content {
            padding: 60px 0;
            display: none;
        }
        .season-content.active {
            display: block;
        }
        .seasonal-product {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        .seasonal-product:hover {
            transform: translateY(-5px);
        }
        .product-image {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 60px;
            position: relative;
        }
        .season-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(255,255,255,0.9);
            color: #2c3e50;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
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
        .nutrition-info {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 12px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>

    <!-- 时令水果横幅 -->
    <div class="seasonal-hero">
        <div class="container">
            <h1><i class="fa fa-calendar"></i> 时令水果</h1>
            <p>应季而食，顺应自然 - 每个季节都有最好的味道</p>
            <button class="btn btn-warning btn-lg">
                <i class="fa fa-leaf"></i> 发现时令美味
            </button>
        </div>
    </div>

    <!-- 季节选择标签 -->
    <div class="season-tabs">
        <div class="container text-center">
            <div class="season-tab active" onclick="showSeason('spring')">
                <i class="fa fa-leaf"></i> 春季水果
            </div>
            <div class="season-tab" onclick="showSeason('summer')">
                <i class="fa fa-sun-o"></i> 夏季水果
            </div>
            <div class="season-tab" onclick="showSeason('autumn')">
                <i class="fa fa-tree"></i> 秋季水果
            </div>
            <div class="season-tab" onclick="showSeason('winter')">
                <i class="fa fa-snowflake-o"></i> 冬季水果
            </div>
        </div>
    </div>

    <!-- 春季水果 -->
    <div class="season-content active" id="spring">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #27ae60; font-size: 36px; font-weight: bold;">春季时令水果</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                            <div class="season-badge">春季特供</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">春季草莓</div>
                            <div class="product-desc">春天的第一抹红色，酸甜可口，维C丰富</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、叶酸、钾元素
                            </div>
                            <div class="product-price">¥32.80/盒</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                            <div class="season-badge">新鲜上市</div>
                            <i class="fa fa-circle-o"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">春橙</div>
                            <div class="product-desc">春季最后的柑橘，汁水饱满，清香怡人</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、柠檬酸、膳食纤维
                            </div>
                            <div class="product-price">¥16.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #8e44ad, #9b59b6);">
                            <div class="season-badge">限量供应</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">春季桑葚</div>
                            <div class="product-desc">紫黑色的春天珍品，酸甜适中，营养价值高</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含花青素、维生素E、铁元素
                            </div>
                            <div class="product-price">¥45.80/盒</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 夏季水果 -->
    <div class="season-content" id="summer">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #f39c12; font-size: 36px; font-weight: bold;">夏季时令水果</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                            <div class="season-badge">夏日清爽</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">夏季西瓜</div>
                            <div class="product-desc">夏日解暑神器，汁多味甜，清热降火</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含水分、维生素A、番茄红素
                            </div>
                            <div class="product-price">¥3.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #e67e22, #d35400);">
                            <div class="season-badge">热带风情</div>
                            <i class="fa fa-sun-o"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">夏季芒果</div>
                            <div class="product-desc">热带水果之王，香甜浓郁，口感丰富</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素A、维生素C、胡萝卜素
                            </div>
                            <div class="product-price">¥28.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #f1c40f, #f39c12);">
                            <div class="season-badge">夏日甜蜜</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">夏季蜜桃</div>
                            <div class="product-desc">夏日蜜桃，果肉鲜美，香甜多汁</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、钾元素、膳食纤维
                            </div>
                            <div class="product-price">¥22.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 秋季水果 -->
    <div class="season-content" id="autumn">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #e67e22; font-size: 36px; font-weight: bold;">秋季时令水果</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                            <div class="season-badge">秋季丰收</div>
                            <i class="fa fa-heart"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">秋季苹果</div>
                            <div class="product-desc">秋天的馈赠，脆嫩多汁，营养丰富</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、膳食纤维、钾元素
                            </div>
                            <div class="product-price">¥18.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                            <div class="season-badge">金秋特产</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">秋季柿子</div>
                            <div class="product-desc">金秋柿子，甜如蜜糖，软糯香甜</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素A、维生素C、胡萝卜素
                            </div>
                            <div class="product-price">¥15.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #8e44ad, #9b59b6);">
                            <div class="season-badge">秋季精选</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">秋季葡萄</div>
                            <div class="product-desc">秋季葡萄，粒大饱满，甜度极高</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含花青素、白藜芦醇、维生素C
                            </div>
                            <div class="product-price">¥25.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 冬季水果 -->
    <div class="season-content" id="winter">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #3498db; font-size: 36px; font-weight: bold;">冬季时令水果</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                            <div class="season-badge">冬日暖阳</div>
                            <i class="fa fa-circle-o"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">冬季橙子</div>
                            <div class="product-desc">冬日暖阳，维C补充，增强免疫力</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、柠檬酸、类黄酮
                            </div>
                            <div class="product-price">¥14.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                            <div class="season-badge">冬季养生</div>
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">冬季猕猴桃</div>
                            <div class="product-desc">维C之王，冬季养生首选，酸甜适中</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、维生素E、叶酸
                            </div>
                            <div class="product-price">¥19.80/斤</div>
                            <button class="btn btn-success btn-block">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="seasonal-product">
                        <div class="product-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                            <div class="season-badge">冬日甜蜜</div>
                            <i class="fa fa-heart"></i>
                        </div>
                        <div class="product-info">
                            <div class="product-name">冬季草莓</div>
                            <div class="product-desc">温室草莓，冬日的甜蜜惊喜</div>
                            <div class="nutrition-info">
                                <i class="fa fa-info-circle"></i> 富含维生素C、叶酸、花青素
                            </div>
                            <div class="product-price">¥38.80/盒</div>
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
    
    <script>
        function showSeason(season) {
            // 隐藏所有季节内容
            var contents = document.querySelectorAll('.season-content');
            contents.forEach(function(content) {
                content.classList.remove('active');
            });
            
            // 移除所有标签的激活状态
            var tabs = document.querySelectorAll('.season-tab');
            tabs.forEach(function(tab) {
                tab.classList.remove('active');
            });
            
            // 显示选中的季节内容
            document.getElementById(season).classList.add('active');
            
            // 激活选中的标签
            event.target.classList.add('active');
        }
    </script>
</body>
</html>