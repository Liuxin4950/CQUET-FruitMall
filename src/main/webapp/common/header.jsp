<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("ctx", request.getContextPath());%>

<!-- Meta标签 -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="${ctx}/static/favicon.ico"/>

<!-- CSS框架 -->
<link href="${ctx}/static/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx}/static/css/font-awesome.min.css" rel="stylesheet"/>
<link href="${ctx}/static/css/style.css" rel="stylesheet"/>

<!-- 通用样式 -->
<style>
    body {
        background-color: #f5f5f5;
        font-family: 'Microsoft YaHei', Arial, sans-serif;
    }
    
    .navbar-custom .navbar-brand {
        color: #fff;
        font-size: 24px;
        font-weight: bold;
        padding: 15px;
    }
    
    .navbar-custom .navbar-brand:hover {
        color: #3498db;
    }
    
    .navbar-custom .navbar-nav > li > a {
        color: #ecf0f1;
        font-size: 16px;
        padding: 20px 15px;
    }
    
    .navbar-custom .navbar-nav > li > a:hover {
        color: #3498db;
        background-color: transparent;
    }

    
    /* 页脚样式 */
    .footer {
        background-color: #2c3e50;
        color: #ecf0f1;
        padding: 40px 0;
        margin-top: 50px;
    }
    
    .footer h4 {
        color: #3498db;
        margin-bottom: 20px;
    }
    
    .footer a {
        color: #bdc3c7;
        text-decoration: none;
    }
    
    .footer a:hover {
        color: #3498db;
        text-decoration: none;
    }
    
    /* 响应式调整 */
    @media (max-width: 768px) {

    }
</style>