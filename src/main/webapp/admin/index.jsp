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

<script src="${ctx}/static/js/echarts.min.js"></script>
<script src="${ctx}/static/js/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 初始化图表
    var orderTrendChart = echarts.init(document.getElementById('orderTrendChart'));
    var userTrendChart = echarts.init(document.getElementById('userTrendChart'));
    var orderStatusChart = echarts.init(document.getElementById('orderStatusChart'));
    var realTimeChart = echarts.init(document.getElementById('realTimeChart'));
    
    // 加载数据
    loadDashboardData();
    
    // 定时刷新数据（每30秒）
    setInterval(loadDashboardData, 30000);
    
    function loadDashboardData() {
        $.ajax({
            url: '${ctx}/dashboard/data',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.code === 200) {
                    updateStats(response.data);
                    updateCharts(response.data);
                } else {
                    console.error('获取数据失败:', response.msg);
                }
            },
            error: function(xhr, status, error) {
                console.error('请求失败:', error);
            }
        });
    }
    
    function updateStats(data) {
        var basicStats = data.basicStats;
        $('#onlineUsers').text(data.onlineUsers || 0);
        $('#totalUsers').text(basicStats.totalUsers || 0);
        $('#todayNewUsers').text(basicStats.todayNewUsers || 0);
        $('#totalOrders').text(basicStats.totalOrders || 0);
        $('#todayOrders').text(basicStats.todayOrders || 0);
        $('#todaySales').text('¥' + (basicStats.todaySales || 0).toFixed(2));
    }
    
    function updateCharts(data) {
        // 订单趋势图
        var orderDates = [];
        var orderCounts = [];
        if (data.recentOrderStats) {
            data.recentOrderStats.forEach(function(item) {
                orderDates.push(item.date);
                orderCounts.push(item.count);
            });
        }
        
        orderTrendChart.setOption({
            tooltip: { trigger: 'axis' },
            xAxis: {
                type: 'category',
                data: orderDates
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: orderCounts,
                type: 'line',
                smooth: true,
                itemStyle: { color: '#4a90e2' },
                areaStyle: {
                    color: {
                        type: 'linear',
                        x: 0, y: 0, x2: 0, y2: 1,
                        colorStops: [
                            { offset: 0, color: 'rgba(74, 144, 226, 0.3)' },
                            { offset: 1, color: 'rgba(74, 144, 226, 0.1)' }
                        ]
                    }
                }
            }]
        });
        
        // 用户注册趋势图
        var userDates = [];
        var userCounts = [];
        if (data.recentUserStats) {
            data.recentUserStats.forEach(function(item) {
                userDates.push(item.date);
                userCounts.push(item.count);
            });
        }
        
        userTrendChart.setOption({
            tooltip: { trigger: 'axis' },
            xAxis: {
                type: 'category',
                data: userDates
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: userCounts,
                type: 'bar',
                itemStyle: { color: '#52c41a' }
            }]
        });
        
        // 订单状态分布饼图
        var statusData = [];
        if (data.orderStatusDistribution) {
            data.orderStatusDistribution.forEach(function(item) {
                statusData.push({
                    name: item.status_name,
                    value: item.count
                });
            });
        }
        
        orderStatusChart.setOption({
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            series: [{
                name: '订单状态',
                type: 'pie',
                radius: '70%',
                data: statusData,
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        });
        
        // 实时监控图（模拟实时数据）
        updateRealTimeChart();
    }
    
    function updateRealTimeChart() {
        var now = new Date();
        var timeData = [];
        var valueData = [];
        
        for (var i = 9; i >= 0; i--) {
            var time = new Date(now.getTime() - i * 60000);
            timeData.push(time.getHours() + ':' + (time.getMinutes() < 10 ? '0' : '') + time.getMinutes());
            valueData.push(Math.floor(Math.random() * 50) + 10);
        }
        
        realTimeChart.setOption({
            tooltip: { trigger: 'axis' },
            xAxis: {
                type: 'category',
                data: timeData
            },
            yAxis: {
                type: 'value',
                name: '访问量'
            },
            series: [{
                data: valueData,
                type: 'line',
                smooth: true,
                itemStyle: { color: '#ff7875' },
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                }
            }]
        });
    }
    
    // 窗口大小改变时重新调整图表
    window.addEventListener('resize', function() {
        orderTrendChart.resize();
        userTrendChart.resize();
        orderStatusChart.resize();
        realTimeChart.resize();
    });
});
</script>
</body>
</html>
