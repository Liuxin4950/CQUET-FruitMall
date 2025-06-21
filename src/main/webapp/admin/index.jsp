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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>EmarketMall数据监控大屏</title>
    <meta name="description" content="EmarketMall系统">
    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <link href="${ctx}/static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${ctx}/static/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/static/css/style.css" rel="stylesheet"/>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico"/>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Microsoft YaHei', Arial, sans-serif;
        }
        .dashboard-container {
            padding: 20px;
            min-height: 100vh;
        }
        .dashboard-header {
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .dashboard-header .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
        }
        .stats-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .stats-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #4a90e2;
            margin-bottom: 5px;
        }
        .stats-label {
            color: #666;
            font-size: 1.1em;
        }
        .chart-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .chart-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            text-align: center;
        }
        .online-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            background: #52c41a;
            border-radius: 50%;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        .loading {
            text-align: center;
            color: #666;
            padding: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="${ctx}/common/menu.jsp"/>

<div class="mcw">
    <div class="col-md-12">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1><i class="fa fa-dashboard"></i> EmarketMall数据监控大屏</h1>
                <div class="subtitle">实时监控系统运营数据</div>
            </div>

            <!-- 统计卡片 -->
            <div class="row">
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="onlineUsers">--</div>
                        <div class="stats-label">
                            <span class="online-indicator"></span>在线用户
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="totalUsers">--</div>
                        <div class="stats-label">总用户数</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="todayNewUsers">--</div>
                        <div class="stats-label">今日新增</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="totalOrders">--</div>
                        <div class="stats-label">总订单数</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="todayOrders">--</div>
                        <div class="stats-label">今日订单</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stats-card text-center">
                        <div class="stats-number" id="todaySales">--</div>
                        <div class="stats-label">今日销售额</div>
                    </div>
                </div>
            </div>

            <!-- 图表区域 -->
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-container">
                        <div class="chart-title">最近7天订单趋势</div>
                        <div id="orderTrendChart" style="height: 300px;"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-container">
                        <div class="chart-title">最近7天用户注册趋势</div>
                        <div id="userTrendChart" style="height: 300px;"></div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="chart-container">
                        <div class="chart-title">订单状态分布</div>
                        <div id="orderStatusChart" style="height: 300px;"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-container">
                        <div class="chart-title">实时数据监控</div>
                        <div id="realTimeChart" style="height: 300px;"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>


<script src="${ctx}/static/js/echarts.min.js"></script>
<script src="${ctx}/static/js/jquery.min.js"></script>
<script>
$(document).ready(function() {


});

</script>
</body>
</html>
