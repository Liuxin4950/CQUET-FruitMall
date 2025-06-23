<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>水果分类 - 向日葵水果</title>
    <meta name="description" content="向日葵水果分类 - 新鲜水果，分类齐全">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .category-hero {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .category-hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .category-hero p {
            font-size: 20px;
            margin-bottom: 30px;
        }
        .category-nav {
            background: white;
            padding: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: sticky;
            top: 70px;
            z-index: 100;
        }
        .category-tabs {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .category-tab {
            padding: 12px 24px;
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .category-tab:hover,
        .category-tab.active {
            background: #27ae60;
            border-color: #27ae60;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        .category-section {
            padding: 60px 0;
            display: none;
        }
        .category-section.active {
            display: block;
        }
        .category-section:nth-child(even) {
            background: #f8f9fa;
        }
        .section-title {
            text-align: center;
            margin-bottom: 50px;
            color: #2c3e50;
            font-size: 36px;
            font-weight: bold;
        }
        .fruit-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        .fruit-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .fruit-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }
        .fruit-image {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 80px;
            position: relative;
        }
        .fruit-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #e74c3c;
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        .fruit-info {
            padding: 25px;
        }
        .fruit-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .fruit-desc {
            color: #7f8c8d;
            margin-bottom: 15px;
            line-height: 1.6;
            font-size: 14px;
        }
        .fruit-features {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 15px;
        }
        .feature-tag {
            background: #ecf0f1;
            color: #2c3e50;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .fruit-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .price-current {
            font-size: 22px;
            color: #e74c3c;
            font-weight: bold;
        }
        .price-unit {
            font-size: 14px;
            color: #95a5a6;
        }
        .fruit-actions {
            display: flex;
            gap: 4px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn-add-cart {
            background: #27ae60;
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 11px;
            flex: 1;
            min-width: 60px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-add-cart:hover {
            background: #219a52;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .btn-detail {
            background: #3498db;
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 11px;
            flex: 1;
            min-width: 60px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-detail:hover {
            background: #2980b9;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .btn-buy {
            background: #e74c3c;
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 11px;
            flex: 1;
            min-width: 60px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-buy:hover {
            background: #c0392b;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        
        /* 星级评分样式 */
        .product-rating {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 8px;
        }
        .stars {
            color: #f39c12;
            margin-right: 5px;
        }
        
        /* 商品元数据样式 */
        .product-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 11px;
            color: #95a5a6;
        }
        
        /* 商品详情模态框样式 */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .modal-header {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            border-radius: 15px 15px 0 0;
            border-bottom: none;
        }
        .modal-header .close {
            color: white;
            opacity: 0.8;
            text-shadow: none;
        }
        .modal-header .close:hover {
            opacity: 1;
        }
        .modal-body {
            padding: 30px;
        }
        
        /* 分类区域显示控制 */
        .category-section {
            display: none;
        }
        
        .category-section.active {
            display: block;
        }
        
        /* 特性标签样式 */
        .feature-tag {
            display: inline-block;
            background: #e8f5e8;
            color: #27ae60;
            padding: 2px 6px;
            border-radius: 10px;
            font-size: 11px;
            margin-right: 4px;
            margin-bottom: 2px;
        }
        
        /* 热销标签 */
        .fruit-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            background: #e74c3c;
            color: white;
            padding: 2px 6px;
            border-radius: 8px;
            font-size: 10px;
            font-weight: bold;
        }
        .category-intro {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .intro-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .intro-text {
            font-size: 16px;
            color: #7f8c8d;
            line-height: 1.6;
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
            <li class="active">水果分类</li>
        </ol>
    </div>

    <!-- 分类横幅 -->
    <div class="category-hero">
        <div class="container">
            <h1><i class="fa fa-leaf"></i> 水果分类</h1>
            <p>新鲜水果，分类齐全 - 满足您的不同需求</p>
            <button class="btn btn-warning btn-lg">
                <i class="fa fa-search"></i> 开始选购
            </button>
        </div>
    </div>

    <!-- 分类导航 -->
    <div class="category-nav">
        <div class="container">
            <div class="category-tabs">
                <a href="#" class="category-tab active" onclick="showCategory('apple')">🍎 苹果类</a>
                <a href="#" class="category-tab" onclick="showCategory('banana')">🍌 香蕉类</a>
                <a href="#" class="category-tab" onclick="showCategory('citrus')">🍊 柑橘类</a>
                <a href="#" class="category-tab" onclick="showCategory('berry')">🍓 浆果类</a>
                <a href="#" class="category-tab" onclick="showCategory('tropical')">🥭 热带水果</a>
                <a href="#" class="category-tab" onclick="showCategory('stone')">🍑 核果类</a>
                <a href="#" class="category-tab" onclick="showCategory('melon')">🍉 瓜果类</a>
            </div>
        </div>
    </div>

    <!-- 苹果类 -->
    <div id="apple" class="category-section active">
        <div class="container">
            <h2 class="section-title">🍎 苹果类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #e74c3c;">
                    <i class="fa fa-apple"></i>
                </div>
                <div class="intro-text">
                    苹果类水果营养丰富，口感清脆，富含膳食纤维和维生素，是健康生活的理想选择。我们精选优质苹果，确保每一颗都新鲜可口。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                        <div class="fruit-badge">有机</div>
                        <i class="fa fa-apple" style="color: #27ae60;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">有机苹果</div>
                        <div class="fruit-desc">有机种植苹果，无农药残留，口感清脆，营养丰富，适合全家食用</div>
                        <div class="fruit-features">
                            <span class="feature-tag">有机认证</span>
                            <span class="feature-tag">清脆</span>
                            <span class="feature-tag">营养丰富</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥25.80</span>
                            <span class="price-unit">/3斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                        <div class="fruit-badge">热销</div>
                        <i class="fa fa-apple" style="color: #e74c3c;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">红富士苹果</div>
                        <div class="fruit-desc">经典红富士苹果，果肉紧实，甜度适中，是最受欢迎的苹果品种之一</div>
                        <div class="fruit-features">
                            <span class="feature-tag">经典品种</span>
                            <span class="feature-tag">紧实</span>
                            <span class="feature-tag">甜度适中</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥22.80</span>
                            <span class="price-unit">/3斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 香蕉类 -->
    <div id="banana" class="category-section">
        <div class="container">
            <h2 class="section-title">🍌 香蕉类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #f1c40f;">
                    <i class="fa fa-moon-o"></i>
                </div>
                <div class="intro-text">
                    香蕉类水果富含钾元素和维生素B6，口感香甜，是运动前后的理想补充。我们的香蕉新鲜进口，确保最佳的成熟度和口感。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #f1c40f, #f39c12);">
                        <div class="fruit-badge">进口</div>
                        <i class="fa fa-moon-o" style="color: #f1c40f;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">进口香蕉</div>
                        <div class="fruit-desc">进口优质香蕉，果肉香甜，富含钾元素，是健康生活的理想选择</div>
                        <div class="fruit-features">
                            <span class="feature-tag">进口</span>
                            <span class="feature-tag">香甜</span>
                            <span class="feature-tag">富含钾</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥18.80</span>
                            <span class="price-unit">/2斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 柑橘类 -->
    <div id="citrus" class="category-section">
        <div class="container">
            <h2 class="section-title">🍊 柑橘类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #f39c12;">
                    <i class="fa fa-sun-o"></i>
                </div>
                <div class="intro-text">
                    柑橘类水果富含维生素C，酸甜可口，是日常补充维生素的最佳选择。我们精选优质产地，确保每一颗都新鲜饱满。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                        <div class="fruit-badge">热销</div>
                        <i class="fa fa-circle" style="color: #f39c12;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">赣南脐橙</div>
                        <div class="fruit-desc">江西赣南特产，果肉饱满，汁水丰富，酸甜适中，维生素C含量丰富</div>
                        <div class="fruit-features">
                            <span class="feature-tag">维C丰富</span>
                            <span class="feature-tag">汁水饱满</span>
                            <span class="feature-tag">产地直供</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥28.80</span>
                            <span class="price-unit">/3斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #f1c40f, #f39c12);">
                        <div class="fruit-badge">新品</div>
                        <i class="fa fa-circle" style="color: #f1c40f;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">冰糖橙</div>
                        <div class="fruit-desc">湖南特产冰糖橙，皮薄肉嫩，甜度极高，口感清香，老少皆宜</div>
                        <div class="fruit-features">
                            <span class="feature-tag">超甜</span>
                            <span class="feature-tag">皮薄</span>
                            <span class="feature-tag">易剥皮</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥32.80</span>
                            <span class="price-unit">/3斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 浆果类 -->
    <div id="berry" class="category-section">
        <div class="container">
            <h2 class="section-title">🍓 浆果类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #e74c3c;">
                    <i class="fa fa-heart"></i>
                </div>
                <div class="intro-text">
                    浆果类水果富含抗氧化物质和维生素，口感酸甜，是美容养颜的天然选择。我们的浆果新鲜采摘，保证最佳口感。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                        <div class="fruit-badge">当季</div>
                        <i class="fa fa-heart" style="color: #e74c3c;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">新鲜草莓</div>
                        <div class="fruit-desc">丹东草莓，果形饱满，香甜多汁，富含维生素C和抗氧化物质</div>
                        <div class="fruit-features">
                            <span class="feature-tag">香甜</span>
                            <span class="feature-tag">多汁</span>
                            <span class="feature-tag">抗氧化</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥38.80</span>
                            <span class="price-unit">/2盒装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 热带水果 -->
    <div id="tropical" class="category-section">
        <div class="container">
            <h2 class="section-title">🥭 热带水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #f39c12;">
                    <i class="fa fa-sun-o"></i>
                </div>
                <div class="intro-text">
                    热带水果带来异域风情，口感独特，营养丰富。我们直接从热带产地采购，确保水果的新鲜度和正宗口味。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #f39c12, #e67e22);">
                        <div class="fruit-badge">热销</div>
                        <i class="fa fa-leaf" style="color: #f39c12;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">海南芒果</div>
                        <div class="fruit-desc">海南特产芒果，果肉细腻，香甜浓郁，富含维生素A和胡萝卜素</div>
                        <div class="fruit-features">
                            <span class="feature-tag">香甜</span>
                            <span class="feature-tag">细腻</span>
                            <span class="feature-tag">维A丰富</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥35.80</span>
                            <span class="price-unit">/3个装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 核果类 -->
    <div id="stone" class="category-section">
        <div class="container">
            <h2 class="section-title">🍑 核果类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #e74c3c;">
                    <i class="fa fa-heart"></i>
                </div>
                <div class="intro-text">
                    核果类水果果肉饱满，口感丰富，营养价值高。我们精选优质产地，确保每一颗都达到最佳成熟度。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #e74c3c, #c0392b);">
                        <div class="fruit-badge">当季</div>
                        <i class="fa fa-heart" style="color: #e74c3c;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">智利车厘子</div>
                        <div class="fruit-desc">智利进口车厘子，果实饱满，甜度极高，被誉为"水果中的钻石"</div>
                        <div class="fruit-features">
                            <span class="feature-tag">进口</span>
                            <span class="feature-tag">超甜</span>
                            <span class="feature-tag">饱满</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥128.80</span>
                            <span class="price-unit">/1斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 瓜果类 -->
    <div id="melon" class="category-section">
        <div class="container">
            <h2 class="section-title">🍉 瓜果类水果</h2>
            <div class="category-intro">
                <div class="intro-icon" style="color: #27ae60;">
                    <i class="fa fa-leaf"></i>
                </div>
                <div class="intro-text">
                    瓜果类水果水分充足，清甜解腻，是夏日消暑的最佳选择。我们的瓜果新鲜采摘，保证最佳的口感和营养。
                </div>
            </div>
            <div class="fruit-grid">
                <div class="fruit-card">
                    <div class="fruit-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">
                        <div class="fruit-badge">夏季</div>
                        <i class="fa fa-circle" style="color: #27ae60;"></i>
                    </div>
                    <div class="fruit-info">
                        <div class="fruit-name">西瓜</div>
                        <div class="fruit-desc">新疆西瓜，汁水丰富，清甜解腻，富含番茄红素，夏日消暑佳品</div>
                        <div class="fruit-features">
                            <span class="feature-tag">消暑</span>
                            <span class="feature-tag">汁水丰富</span>
                            <span class="feature-tag">番茄红素</span>
                        </div>
                        <div class="fruit-price">
                            <span class="price-current">¥15.80</span>
                            <span class="price-unit">/5斤装</span>
                        </div>
                        <div class="fruit-actions">
                            <button class="btn btn-add-cart">
                                <i class="fa fa-cart-plus"></i> 加入购物车
                            </button>
                            <button class="btn btn-quick-view">
                                <i class="fa fa-eye"></i>
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

        // 全局配置变量
        window.contextPath = '${ctx}';
        window.isUserLoggedIn = <%= session.getAttribute("loginName") != null %>;
    </script>
    
    <!-- 引入分类页面JS模块 -->
    <script src="${ctx}/web/js/category.js"></script>
</body>
</html>