<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>注册向日葵水果商城</title>
    <meta name="description" content="向日葵水果商城">
    <!-- 引入统一资源管理 -->
    <%@ include file="common/resources.jsp" %>
    <link href="${ctx}/static/css/fruit-login.css" rel="stylesheet"/>
    <link href="${ctx}/static/ajax/easy-ui/easy-ui.css" rel="stylesheet"/>
</head>
<body class="fruit-signin">
<div class="fruit-signinpanel">
    <div class="row">
        <div class="col-sm-7">
            <div class="fruit-signin-info">
                <div class="m-b"></div>
                <h4>加入 <strong class="brand-name">向日葵</strong> 水果商城</h4>
                <ul class="m-b">
                    <li>新鲜水果，每日直达</li>
                    <li>品质保证，源头直供</li>
                    <li>营养健康，美味生活</li>
                    <li>便捷购物，贴心服务</li>
                    <li>绿色环保，自然之选</li>
                </ul>
                <strong>已经注册过? <a href="${ctx}/login.jsp">直接登录，开始购物&raquo;</a></strong>
            </div>
        </div>
        <div class="col-sm-5">
            <div class="fruit-form-container">
                <form id="registerForm" autocomplete="off" method="post">
                    <h4 class="no-margins">用户注册</h4>
                    <p class="m-t-md">🌻 注册成为会员，享受更多优惠 🌻
                    </p>
                    <input type="text" name="loginName" class="fruit-form-control uname" placeholder="请输入登录名" maxlength="20"/>
                    <input type="password" name="password" class="fruit-form-control pword" placeholder="请输入密码" maxlength="20" value="123456"/>
                    <input type="password" name="confirmPassword" class="fruit-form-control pword" placeholder="请确认密码"
                           maxlength="20" value="123456"/>
                    <input type="text" name="phone" class="fruit-form-control phone" placeholder="请输入手机号" maxlength="20"
                           value="13912345678"/>
                    <br/>
                    <div class="fruit-checkbox">
                        <input type="checkbox" id="acceptTerm" name="acceptTerm"> <label
                            for="acceptTerm">我已阅读并同意用户协议</label>
                    </div>
                    <button class="fruit-btn" id="btnSubmit" type="button" onclick="register()"
                            data-loading="正在验证注册，请稍后...">立即注册
                    </button>
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
<!-- layer弹窗组件 -->
<script src="${ctx}/static/ajax/layer/layer.min.js"></script>
<script src="${ctx}/static/ajax/easy-ui/easy-ui.js"></script>
<script src="${ctx}/static/ajax/easy-ui/common.js"></script>

<script type="text/javascript">
    function register() {
        let loginName = $("input[name='loginName']").val();
        let password = $("input[name='password']").val();
        let phone = $("input[name='phone']").val();
        if(loginName == "" || password == "" || phone == "") {
            $.modal.alertWarning("请填写完整的注册信息！");
            return;
        }
        $.ajax({
            type: "post",
            url: "/register",
            data: {
                "loginName": loginName,
                "password": password,
                "phone": phone
            },
            dataType: "json",
            success: function(res) {
                // 检查返回数据
                console.log("返回数据:", res);
                if(res.code == 0) {
                    $.modal.alertSuccess("恭喜你，您的账号 " + loginName + " 注册成功！");
                    setTimeout(function() {
                        // 延时跳转到登录页面
                        location.href = '/login.jsp';
                    }, 1000);
                } else {
                    // 注册失败
                    $.modal.alertError(res.msg || "注册失败，请重试!");
                }
            },
            error: function(xhr, status, error) {
                // 请求出错
                $.modal.alertError(res.msg || "注册请求失败");
                alert("注册请求失败，请检查网络连接!");
            }
        });

     
    }
    function validateRule() {
        var icon = "<i class='fa fa-times-circle'></i> ";
        $("#registerForm").validate({
                rules: {
                    username: {
                        required: true,
                        minlength: 2
                    },
                    password: {
                        required: true,
                        minlength: 5
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "[name='password']"
                    },
                    phone: {
                        required: true,
                        isPhone: true
                    }
                },
                messages: {
                    username: {
                        required: icon + "请输入您的用户名",
                        minlength: icon + "用户名不能小于2个字符"
                    },
                    password: {
                        required: icon + "请输入您的密码",
                        minlength: icon + "密码不能小于5个字符",
                    },
                    confirmPassword: {
                        required: icon + "请再次输入您的密码",
                        equalTo: icon + "两次密码输入不一致"
                    },
                    phone: {
                        required: icon + "请输入手机号",
                        isPhone: icon + "请填写正确的11位手机号"
                    }
                }
            }
        )
    }
</script>
</body>
</html>
