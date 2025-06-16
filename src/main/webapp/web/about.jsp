<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>关于我们 - 向日葵水果</title>
    <meta name="description" content="向日葵水果 - 专业的水果电商平台，为您提供新鲜优质的水果">
    
    <!-- 引入通用头部 -->
    <%@ include file="../common/header.jsp" %>
    
    <style>
        .about-container {
            padding: 40px 0;
        }
        
        .about-header {
            background: linear-gradient(135deg, #ff9a56 0%, #ffad56 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .about-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="%23ffffff" opacity="0.1"/><circle cx="80" cy="40" r="3" fill="%23ffffff" opacity="0.1"/><circle cx="40" cy="80" r="2" fill="%23ffffff" opacity="0.1"/></svg>') repeat;
        }
        
        .about-header h1 {
            font-size: 3.5rem;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }
        
        .about-header p {
            font-size: 1.3rem;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
            opacity: 0.9;
        }
        
        .section {
            padding: 60px 0;
        }
        
        .section:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .section-title h2 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
        }
        
        .section-title h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, #ff9a56, #ffad56);
            border-radius: 2px;
        }
        
        .section-title p {
            font-size: 1.1rem;
            color: #7f8c8d;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .story-content {
            display: flex;
            align-items: center;
            gap: 50px;
        }
        
        .story-text {
            flex: 1;
        }
        
        .story-image {
            flex: 1;
            text-align: center;
        }
        
        .story-image .placeholder {
            width: 100%;
            height: 300px;
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .value-card {
            background: white;
            padding: 40px 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .value-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .value-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 2rem;
        }
        
        .value-card h4 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3rem;
        }
        
        .value-card p {
            color: #7f8c8d;
            line-height: 1.6;
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .team-member {
            text-align: center;
            background: white;
            padding: 30px 20px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .team-member:hover {
            transform: translateY(-5px);
        }
        
        .member-avatar {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 2rem;
        }
        
        .member-name {
            font-size: 1.2rem;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .member-role {
            color: #ff9a56;
            font-weight: 500;
            margin-bottom: 10px;
        }
        
        .member-desc {
            color: #7f8c8d;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .contact-info {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .contact-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #ff9a56, #ffad56);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 20px;
        }
        
        .contact-details h5 {
            margin: 0 0 5px 0;
            color: #2c3e50;
        }
        
        .contact-details p {
            margin: 0;
            color: #7f8c8d;
        }
        
        @media (max-width: 768px) {
            .about-header h1 {
                font-size: 2.5rem;
            }
            
            .story-content {
                flex-direction: column;
                gap: 30px;
            }
            
            .values-grid {
                grid-template-columns: 1fr;
            }
            
            .team-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
        }
    </style>
</head>
<body>
    <!-- 引入通用导航栏 -->
    <%@ include file="../common/navbar.jsp" %>
    
    <!-- 面包屑导航 -->
    <div class="container">
        <ol class="breadcrumb">
            <li><a href="${ctx}/web/index.jsp">首页</a></li>
            <li class="active">关于我们</li>
        </ol>
    </div>
    
    <!-- 关于我们头部 -->
    <div class="about-header">
        <div class="container">
            <h1><i class="fa fa-leaf"></i> 关于向日葵水果</h1>
            <p>新鲜直达，品质生活的选择</p>
        </div>
    </div>
    
    <div class="container about-container">
        <!-- 我们的故事 -->
        <div class="section">
            <div class="section-title">
                <h2>我们的故事</h2>
                <p>从一个小小的水果摊到专业的水果电商平台，我们始终坚持为客户提供最新鲜、最优质的水果</p>
            </div>
            <div class="story-content">
                <div class="story-text">
                    <h4>始于2018年的梦想</h4>
                    <p>向日葵水果成立于2018年，创始人小李怀着对新鲜水果的热爱和对品质生活的追求，开始了这段创业之旅。从最初的线下水果店，到如今的专业水果电商平台，我们始终坚持"新鲜直达，品质第一"的理念。</p>
                    <br>
                    <p>我们与全国各地的优质果园建立了直接合作关系，从源头把控品质，确保每一颗水果都经过严格筛选。通过先进的冷链物流系统，我们能够在最短时间内将新鲜水果送达客户手中。</p>
                    <br>
                    <p>如今，向日葵水果已经服务了超过10万名客户，建立了覆盖全国主要城市的配送网络，成为了客户信赖的水果品牌。</p>
                </div>
                <div class="story-image">
                    <div class="placeholder">
                        <i class="fa fa-apple"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 我们的价值观 -->
        <div class="section">
            <div class="section-title">
                <h2>我们的价值观</h2>
                <p>这些核心价值观指导着我们的每一个决策和行动</p>
            </div>
            <div class="values-grid">
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fa fa-leaf"></i>
                    </div>
                    <h4>新鲜品质</h4>
                    <p>我们承诺提供最新鲜的水果，从采摘到配送，全程冷链保鲜，确保每一颗水果都保持最佳状态。</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fa fa-heart"></i>
                    </div>
                    <h4>用心服务</h4>
                    <p>客户的满意是我们最大的追求，我们用心对待每一位客户，提供贴心周到的服务体验。</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fa fa-shield"></i>
                    </div>
                    <h4>诚信经营</h4>
                    <p>诚信是我们的立身之本，我们坚持透明定价，真实描述，让客户买得放心，吃得安心。</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fa fa-rocket"></i>
                    </div>
                    <h4>持续创新</h4>
                    <p>我们不断探索新的服务模式和技术手段，为客户提供更便捷、更优质的购物体验。</p>
                </div>
            </div>
        </div>
        
        <!-- 我们的团队 -->
        <div class="section">
            <div class="section-title">
                <h2>我们的团队</h2>
                <p>一群热爱水果、专业敬业的小伙伴</p>
            </div>
            <div class="team-grid">
                <div class="team-member">
                    <div class="member-avatar">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="member-name">李明</div>
                    <div class="member-role">创始人 & CEO</div>
                    <div class="member-desc">10年水果行业经验，致力于为客户提供最优质的水果和服务</div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="member-name">王小红</div>
                    <div class="member-role">采购总监</div>
                    <div class="member-desc">负责全国优质果园的开发与合作，确保货源品质</div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="member-name">张技术</div>
                    <div class="member-role">技术总监</div>
                    <div class="member-desc">负责平台技术开发，为客户提供流畅的购物体验</div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="member-name">刘客服</div>
                    <div class="member-role">客服经理</div>
                    <div class="member-desc">7×24小时为客户提供专业贴心的服务支持</div>
                </div>
            </div>
        </div>
        
        <!-- 联系我们 -->
        <div class="section">
            <div class="section-title">
                <h2>联系我们</h2>
                <p>我们随时欢迎您的咨询和建议</p>
            </div>
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="contact-info">
                        <div class="contact-item">
                            <div class="contact-icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="contact-details">
                                <h5>客服热线</h5>
                                <p>400-888-6666 (7×24小时服务)</p>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon">
                                <i class="fa fa-envelope"></i>
                            </div>
                            <div class="contact-details">
                                <h5>邮箱地址</h5>
                                <p>service@sunflower-fruit.com</p>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon">
                                <i class="fa fa-map-marker"></i>
                            </div>
                            <div class="contact-details">
                                <h5>公司地址</h5>
                                <p>北京市朝阳区水果大厦18层</p>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon">
                                <i class="fa fa-clock-o"></i>
                            </div>
                            <div class="contact-details">
                                <h5>营业时间</h5>
                                <p>周一至周日 8:00-22:00</p>
                            </div>
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