<%--
  Created by IntelliJ IDEA.
  User: Annisia
  Date: 2024-01-15
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>礼品装 - 向日葵水果</title>
    <meta name="description" content="向日葵水果礼品装 - 精美包装，心意满满">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    <style>
        .gift-hero {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .gift-hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .gift-hero p {
            font-size: 20px;
            margin-bottom: 30px;
        }
        .gift-features {
            background: #f8f9fa;
            padding: 60px 0;
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
            color: #9b59b6;
            margin-bottom: 20px;
        }
        .gift-categories {
            padding: 60px 0;
        }
        .category-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .category-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }
        .category-image {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 80px;
            position: relative;
        }
        .category-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .category-card:hover .category-overlay {
            opacity: 1;
        }
        .category-info {
            padding: 25px;
        }
        .category-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .category-desc {
            color: #7f8c8d;
            margin-bottom: 15px;
            line-height: 1.6;
        }
        .category-price {
            font-size: 18px;
            color: #e74c3c;
            font-weight: bold;
        }
        .gift-products {
            padding: 60px 0;
            background: #f8f9fa;
        }
        .gift-product {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        .gift-product:hover {
            transform: translateY(-5px);
        }
        .product-image {
            height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 80px;
            position: relative;
        }
        .gift-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #e74c3c;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .product-info {
            padding: 25px;
        }
        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .product-desc {
            color: #7f8c8d;
            margin-bottom: 15px;
            line-height: 1.6;
        }
        .product-contents {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .product-price {
            font-size: 24px;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .original-price {
            font-size: 16px;
            color: #95a5a6;
            text-decoration: line-through;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>

    <!-- 礼品装横幅 -->
    <div class="gift-hero">
        <div class="container">
            <h1><i class="fa fa-gift"></i> 精美礼品装</h1>
            <p>心意满满，品质保证 - 送礼首选，表达心意</p>
            <button class="btn btn-warning btn-lg">
                <i class="fa fa-heart"></i> 选择礼品
            </button>
        </div>
    </div>

    <!-- 礼品特色 -->
    <div class="gift-features">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-gift"></i>
                        </div>
                        <h4>精美包装</h4>
                        <p>专业设计师打造，每一份都是艺术品</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-star"></i>
                        </div>
                        <h4>精选品质</h4>
                        <p>严格筛选，只选最优质的水果</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-heart"></i>
                        </div>
                        <h4>贴心服务</h4>
                        <p>免费贺卡，专人配送，传递心意</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fa fa-shield"></i>
                        </div>
                        <h4>品质保证</h4>
                        <p>新鲜保证，不满意包退换</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 礼品分类 -->
    <div class="gift-categories">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #2c3e50; font-size: 36px; font-weight: bold;">礼品分类</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="category-card" onclick="scrollToProducts('business')">
                        <div class="category-image" style="background: linear-gradient(45deg, #3498db, #2980b9);">
                            <i class="fa fa-briefcase"></i>
                            <div class="category-overlay">
                                <span style="font-size: 18px; font-weight: bold;">查看详情</span>
                            </div>
                        </div>
                        <div class="category-info">
                            <div class="category-title">商务礼品</div>
                            <div class="category-desc">适合商务场合，体现专业品味，增进合作关系</div>
                            <div class="category-price">¥188 起</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card" onclick="scrollToProducts('family')">
                        <div class="category-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                            <i class="fa fa-home"></i>
                            <div class="category-overlay">
                                <span style="font-size: 18px; font-weight: bold;">查看详情</span>
                            </div>
                        </div>
                        <div class="category-info">
                            <div class="category-title">家庭礼品</div>
                            <div class="category-desc">温馨家庭装，适合探亲访友，传递温暖关怀</div>
                            <div class="category-price">¥128 起</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card" onclick="scrollToProducts('festival')">
                        <div class="category-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                            <i class="fa fa-star"></i>
                            <div class="category-overlay">
                                <span style="font-size: 18px; font-weight: bold;">查看详情</span>
                            </div>
                        </div>
                        <div class="category-info">
                            <div class="category-title">节日礼品</div>
                            <div class="category-desc">节日专属设计，增添节日氛围，表达美好祝愿</div>
                            <div class="category-price">¥168 起</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 精选礼品 -->
    <div class="gift-products" id="products">
        <div class="container">
            <h2 class="text-center" style="margin-bottom: 50px; color: #2c3e50; font-size: 36px; font-weight: bold;">精选礼品</h2>
            
            <!-- 商务礼品 -->
            <div id="business">
                <h3 style="color: #3498db; margin-bottom: 30px; font-size: 24px; font-weight: bold;">
                    <i class="fa fa-briefcase"></i> 商务礼品系列
                </h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #3498db, #2980b9);">
                                <div class="gift-badge">热销</div>
                                <i class="fa fa-briefcase"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">商务精选礼盒</div>
                                <div class="product-desc">专为商务场合设计，精选优质水果，体现专业品味</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 进口苹果 2个<br>
                                    • 新西兰猕猴桃 4个<br>
                                    • 泰国芒果 2个<br>
                                    • 智利车厘子 250g
                                </div>
                                <div class="product-price">
                                    ¥288.00 <span class="original-price">¥358.00</span>
                                </div>
                                <button class="btn btn-primary btn-block btn-lg">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #2c3e50, #34495e);">
                                <div class="gift-badge">高端</div>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">尊享商务礼盒</div>
                                <div class="product-desc">高端商务礼品，彰显尊贵身份，适合重要客户</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 日本富士苹果 3个<br>
                                    • 新西兰金果 6个<br>
                                    • 泰国金枕榴莲 1个<br>
                                    • 智利车厘子 500g
                                </div>
                                <div class="product-price">
                                    ¥588.00 <span class="original-price">¥728.00</span>
                                </div>
                                <button class="btn btn-primary btn-block btn-lg">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 家庭礼品 -->
            <div id="family" style="margin-top: 60px;">
                <h3 style="color: #e74c3c; margin-bottom: 30px; font-size: 24px; font-weight: bold;">
                    <i class="fa fa-home"></i> 家庭礼品系列
                </h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                                <div class="gift-badge">温馨</div>
                                <i class="fa fa-home"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">温馨家庭装</div>
                                <div class="product-desc">适合全家分享，营养搭配均衡，老少皆宜</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 红富士苹果 4个<br>
                                    • 香甜橙子 6个<br>
                                    • 香蕉 1串<br>
                                    • 时令梨子 4个
                                </div>
                                <div class="product-price">
                                    ¥168.00 <span class="original-price">¥208.00</span>
                                </div>
                                <button class="btn btn-danger btn-block btn-lg">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                                <div class="gift-badge">健康</div>
                                <i class="fa fa-heart"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">健康养生装</div>
                                <div class="product-desc">精选养生水果，关爱家人健康，营养价值丰富</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 猕猴桃 6个<br>
                                    • 火龙果 2个<br>
                                    • 牛油果 3个<br>
                                    • 蓝莓 2盒
                                </div>
                                <div class="product-price">
                                    ¥228.00 <span class="original-price">¥278.00</span>
                                </div>
                                <button class="btn btn-success btn-block btn-lg">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 节日礼品 -->
            <div id="festival" style="margin-top: 60px;">
                <h3 style="color: #f39c12; margin-bottom: 30px; font-size: 24px; font-weight: bold;">
                    <i class="fa fa-star"></i> 节日礼品系列
                </h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                                <div class="gift-badge">节日</div>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">节日庆典装</div>
                                <div class="product-desc">节日专属包装，增添节日氛围，表达美好祝愿</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 进口苹果 4个<br>
                                    • 新鲜草莓 2盒<br>
                                    • 香甜葡萄 1串<br>
                                    • 节日贺卡 1张
                                </div>
                                <div class="product-price">
                                    ¥198.00 <span class="original-price">¥248.00</span>
                                </div>
                                <button class="btn btn-warning btn-block btn-lg">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="gift-product">
                            <div class="product-image" style="background: linear-gradient(45deg, #9b59b6, #8e44ad);">
                                <div class="gift-badge">限量</div>
                                <i class="fa fa-gift"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-name">豪华庆典装</div>
                                <div class="product-desc">豪华节日礼盒，精美包装，适合重要节日赠送</div>
                                <div class="product-contents">
                                    <strong>礼盒内容：</strong><br>
                                    • 进口车厘子 500g<br>
                                    • 泰国榴莲 1个<br>
                                    • 新西兰猕猴桃 8个<br>
                                    • 定制贺卡 1张
                                </div>
                                <div class="product-price">
                                    ¥388.00 <span class="original-price">¥488.00</span>
                                </div>
                                <button class="btn btn-primary btn-block btn-lg" style="background: #9b59b6; border-color: #9b59b6;">
                                    <i class="fa fa-cart-plus"></i> 立即购买
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 引入通用页脚 -->
    <%@ include file="../common/footer.jsp" %>
    
    <script>
        function scrollToProducts(category) {
            document.getElementById(category).scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    </script>
</body>
</html>