<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 统一资源引入文件 --%>
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

<!-- JavaScript库 - 按依赖顺序加载 -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>

<!-- 通用工具函数 -->
<script>
// 全局配置
window.ctx = '${ctx}';

// 通用工具函数
function showMessage(message, type) {
    type = type || 'info';
    var alertClass = 'alert-' + (type === 'error' ? 'danger' : type);
    var alertHtml = '<div class="alert ' + alertClass + ' alert-dismissible" role="alert">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button>' + message + '</div>';
    
    // 移除现有的提示
    $('.alert').remove();
    
    // 添加新提示到页面顶部
    $('body').prepend(alertHtml);
    
    // 3秒后自动消失
    setTimeout(function() {
        $('.alert').fadeOut();
    }, 3000);
}

// 加载状态管理
function showLoading(message) {
    message = message || '加载中...';
    if (!$('#global-loading').length) {
        var loadingHtml = '<div id="global-loading" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; display: flex; align-items: center; justify-content: center;">' +
            '<div style="background: white; padding: 20px; border-radius: 5px; text-align: center;">' +
            '<i class="fa fa-spinner fa-spin fa-2x"></i>' +
            '<div style="margin-top: 10px;">' + message + '</div>' +
            '</div>' +
            '</div>';
        $('body').append(loadingHtml);
    } else {
        $('#global-loading').show().find('div').last().text(message);
    }
}

function hideLoading() {
    $('#global-loading').hide();
}

// AJAX错误处理
$(document).ajaxError(function(event, xhr, settings, thrownError) {
    hideLoading();
    console.error('AJAX请求失败:', settings.url, xhr.status, thrownError);
    showMessage('网络请求失败，请稍后重试', 'error');
});

// 页面加载完成后的通用初始化
$(document).ready(function() {
    // 为所有带有data-toggle="tooltip"的元素启用提示
    $('[data-toggle="tooltip"]').tooltip();
    
    // 为所有带有data-toggle="popover"的元素启用弹出框
    $('[data-toggle="popover"]').popover();
    
    console.log('页面资源加载完成');
});
</script>