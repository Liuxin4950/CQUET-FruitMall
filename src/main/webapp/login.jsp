<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>登录向日葵水果商城</title>
    <meta name="description" content="向日葵水果商城">
    <!-- 引入统一资源管理 -->
    <%@ include file="common/resources.jsp" %>
    <link href="${ctx}/static/css/fruit-login.css" rel="stylesheet"/>

    <script>
        if (window.top !== window.self) {
            alert('未登录或登录超时。请重新登录');
            window.top.location = window.location
        }
    </script>
</head>
<body class="fruit-signin">
<div class="fruit-signinpanel">
    <div class="row">
        <div class="col-sm-7">
            <div class="fruit-signin-info">
                <div class="m-b"></div>
                <h4>欢迎来到 <strong class="brand-name">向日葵</strong> 水果商城</h4>
                <ul class="m-b">
                    <li>新鲜水果，每日直达</li>
                    <li>品质保证，源头直供</li>
                    <li>营养健康，美味生活</li>
                    <li>便捷购物，贴心服务</li>
                    <li>绿色环保，自然之选</li>
                </ul>
                <strong>还没有账号？<a href="${ctx}/register.jsp">立即注册，享受新鲜&raquo;</a></strong>
            </div>
        </div>
        <div class="col-sm-5">
            <div class="fruit-form-container">
                <form id="signupForm" autocomplete="off" >
                    <h4 class="no-margins">用户登录</h4>
                    <p class="m-t-md">🌻 享受新鲜水果，品味健康生活 🌻</p>
                    <input type="text" name="loginName" class="fruit-form-control uname" placeholder="请输入用户名" value="san"/>
                    <input type="password" name="password" class="fruit-form-control pword" placeholder="请输入密码" value="123456"/>
                    <br/>
                    <div class="fruit-checkbox">
                        <input type="checkbox" id="rememberme" name="rememberme"> <label for="rememberme">记住我的登录状态</label>
                    </div>
                    <button class="fruit-btn" id="btnSubmit" onclick="login()" data-loading="正在验证登录，请稍后...">立即登录</button>
                </form>
            </div>
        </div>
    </div>
    <div class="fruit-footer">
        <div class="pull-left">
            &copy; 2024 向日葵水果商城 All Rights Reserved. <br>
        </div>
    </div>
</div>
<!-- 全局js -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>
<!-- 验证插件 -->
<script src="${ctx}/static/js/validate/jquery.validate.min.js"></script>
<script src="${ctx}/static/js/validate/messages_zh.min.js"></script>
<script src="${ctx}/static/js/login.js"></script>
<script src="${ctx}/static/ajax/easy-ui/easy-ui.js"></script>

<script type="text/javascript">
    function login() {
        var loginName = $("input[name='loginName']").val();
        var password = $("input[name='password']").val();
        var rememberMe = $("input[name='rememberme']").is(':checked');
        
        // 参数验证
        if (!loginName || loginName.trim() === '') {
            alert('请输入登录名');
            return;
        }
        if (!password || password.trim() === '') {
            alert('请输入密码');
            return;
        }
        
        $.ajax({
            type: "post",
            url: "/login",
            data: {
                "loginName": loginName,
                "password": password,
                "rememberMe": rememberMe
            },
            dataType: "json",
            success: function (ret) {
                console.log("登录返回结果:", ret);
                if (ret.code == 0) {
                    // 根据用户类型跳转到不同页面
                    if (ret.data && ret.data.userType === 'admin') {
                        // 管理员跳转到管理员界面
                        location.href = 'admin/index.jsp';
                    } else {
                        // 普通用户跳转到用户界面
                        location.href = 'web/index.jsp';
                    }
                } else {
                    // 显示错误信息
                    if (typeof $.modal !== 'undefined' && $.modal.alertWarning) {
                        $.modal.alertWarning(ret.msg);
                    } else {
                        alert(ret.msg || '登录失败');
                    }
                }
            },
            error: function(xhr, status, error) {
                alert('登录请求失败，请检查网络连接');
            }
        });
    }
</script>
</body>
</html>
