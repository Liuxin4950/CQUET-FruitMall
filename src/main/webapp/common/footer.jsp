<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("ctx", request.getContextPath());%>

<!-- 页脚 -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h4><i class="fa fa-shopping-cart"></i> EmarketMall</h4>
                <p>您的购物首选平台，为您提供优质的商品和服务。我们致力于打造最好的购物体验。</p>
                <div style="margin-top: 20px;">
                    <p><i class="fa fa-map-marker"></i> 地址：北京市朝阳区购物街123号</p>
                    <p><i class="fa fa-phone"></i> 电话：400-888-8888</p>
                    <p><i class="fa fa-envelope"></i> 邮箱：service@emarketmall.com</p>
                </div>
            </div>
            <div class="col-md-3">
                <h4>购物指南</h4>
                <ul class="list-unstyled">
                    <li><a href="${ctx}/web/help/shopping-guide.jsp">购物流程</a></li>
                    <li><a href="${ctx}/web/help/payment.jsp">支付方式</a></li>
                    <li><a href="${ctx}/web/help/delivery.jsp">配送说明</a></li>
                    <li><a href="${ctx}/web/help/return.jsp">退换货政策</a></li>
                    <li><a href="${ctx}/web/help/warranty.jsp">售后服务</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h4>用户服务</h4>
                <ul class="list-unstyled">
                    <li><a href="${ctx}/web/help/account.jsp">账户管理</a></li>
                    <li><a href="${ctx}/web/help/order.jsp">订单查询</a></li>
                    <li><a href="${ctx}/web/help/points.jsp">积分说明</a></li>
                    <li><a href="${ctx}/web/help/coupon.jsp">优惠券使用</a></li>
                    <li><a href="${ctx}/web/help/membership.jsp">会员权益</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h4>关注我们</h4>
                <div style="font-size: 24px; margin-bottom: 20px;">
                    <a href="#" title="微信公众号"><i class="fa fa-weixin"></i></a>
                    <a href="#" title="新浪微博" style="margin-left: 15px;"><i class="fa fa-weibo"></i></a>
                    <a href="#" title="QQ群" style="margin-left: 15px;"><i class="fa fa-qq"></i></a>
                    <a href="#" title="抖音" style="margin-left: 15px;"><i class="fa fa-video-camera"></i></a>
                </div>
                <div class="panel panel-default" style="background-color: #34495e; border-color: #34495e;">
                    <div class="panel-body" style="color: #ecf0f1; text-align: center;">
                        <h5><i class="fa fa-phone"></i> 客服热线</h5>
                        <h4 style="color: #3498db;">400-888-8888</h4>
                        <p style="margin: 0; font-size: 12px;">服务时间：9:00-21:00</p>
                    </div>
                </div>
            </div>
        </div>
        <hr style="border-color: #34495e; margin: 30px 0;">
        <div class="row">
            <div class="col-md-6">
                <p>&copy; 2024 EmarketMall购物商城. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-right">
                <p>
                    <a href="${ctx}/web/help/privacy.jsp">隐私政策</a> |
                    <a href="${ctx}/web/help/terms.jsp">服务条款</a> |
                    <a href="${ctx}/web/help/contact.jsp">联系我们</a> |
                    <a href="${ctx}/web/sitemap.jsp">网站地图</a>
                </p>
            </div>
        </div>
    </div>
</footer>

<!-- JavaScript框架 -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>

<!-- 通用JavaScript函数 -->
<script>
    // 退出登录
    function logout() {
        if (confirm('确定要退出登录吗？')) {
            $.ajax({
                url: '${ctx}/logout',
                type: 'POST',
                success: function(response) {
                    if (response.success) {
                        alert('退出成功！');
                        window.location.href = '${ctx}/web/index.jsp';
                    } else {
                        alert('退出失败：' + response.message);
                    }
                },
                error: function() {
                    // 即使AJAX失败，也直接跳转到登录页面
                    window.location.href = '${ctx}/login.jsp';
                }
            });
        }
    }
    
    // 通用AJAX错误处理
    $(document).ajaxError(function(event, xhr, settings, thrownError) {
        if (xhr.status === 401) {
            alert('登录已过期，请重新登录');
            window.location.href = '${ctx}/login.jsp';
        } else if (xhr.status === 403) {
            alert('没有权限访问该资源');
        } else if (xhr.status >= 500) {
            alert('服务器错误，请稍后重试');
        }
    });
    
    // 页面加载完成后的通用初始化
    $(document).ready(function() {
        // 工具提示初始化
        $('[data-toggle="tooltip"]').tooltip();
        
        // 弹出框初始化
        $('[data-toggle="popover"]').popover();
        
        // Bootstrap导航栏已有原生响应式处理，无需额外代码
        
        // 返回顶部按钮
        if ($('#back-to-top').length === 0) {
            $('body').append('<div id="back-to-top" style="position: fixed; bottom: 20px; right: 20px; z-index: 1000; display: none;"><button class="btn btn-primary btn-sm" onclick="scrollToTop()"><i class="fa fa-arrow-up"></i></button></div>');
        }
        
        $(window).scroll(function() {
            if ($(this).scrollTop() > 200) {
                $('#back-to-top').fadeIn();
            } else {
                $('#back-to-top').fadeOut();
            }
        });
    });
    
    // 返回顶部
    function scrollToTop() {
        $('html, body').animate({scrollTop: 0}, 500);
    }
    
    // 格式化价格显示
    function formatPrice(price) {
        return '¥' + parseFloat(price).toFixed(2);
    }
    
    // 显示加载中状态
    function showLoading(message) {
        message = message || '加载中...';
        if ($('#loading-modal').length === 0) {
            $('body').append('<div id="loading-modal" class="modal fade" data-backdrop="static" data-keyboard="false"><div class="modal-dialog modal-sm"><div class="modal-content"><div class="modal-body text-center"><i class="fa fa-spinner fa-spin fa-2x"></i><p style="margin-top: 10px;">' + message + '</p></div></div></div></div>');
        }
        $('#loading-modal').modal('show');
    }
    
    // 隐藏加载中状态
    function hideLoading() {
        $('#loading-modal').modal('hide');
    }
</script>