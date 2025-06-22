<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>订单管理-新增</title>
    <meta name="description" content="EmarketMall系统">
    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <script type="text/javascript" src="../../static/js/common/common-css.js"></script>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico"/>
</head>
<body class="white-bg">
<div class="wrapper wrapper-content animated fadeInRight ibox-content">
    <form class="form-horizontal m" id="form-orders-add">
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">用户ID：</label>
            <div class="col-sm-8">
                <input name="userId" class="form-control" type="number" required>
            </div>
        </div> 
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">收货人：</label>
            <div class="col-sm-8">
                <input name="shippingUser" class="form-control" type="text" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">收货地址：</label>
            <div class="col-sm-8">
                <textarea name="address" class="form-control" rows="3" required></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">订单金额：</label>
            <div class="col-sm-8">
                <input name="orderMoney" class="form-control" type="number" step="0.01" min="0" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">运费：</label>
            <div class="col-sm-8">
                <input name="shippingMoney" class="form-control" type="number" step="0.01" min="0" value="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">优惠金额：</label>
            <div class="col-sm-8">
                <input name="districtMoney" class="form-control" type="number" step="0.01" min="0" value="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">支付方式：</label>
            <div class="col-sm-8">
                <select name="paymentMethod" class="form-control" required>
                    <option value="">请选择支付方式</option>
                    <option value="1">支付宝</option>
                    <option value="2">微信支付</option>
                    <option value="3">银行卡</option>
                    <option value="4">货到付款</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">备注：</label>
            <div class="col-sm-8">
                <textarea name="remark" class="form-control" rows="3" placeholder="订单备注信息"></textarea>
            </div>
        </div>
    </form>
</div>

<!-- 全局js -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>
<!-- bootstrap-table 表格插件 -->
<script src="${ctx}/static/ajax/bootstrap-table/bootstrap-table.min.js?v=20200727"></script>
<script src="${ctx}/static/ajax/bootstrap-table/locale/bootstrap-table-zh-CN.min.js?v=20200727"></script>
<script src="${ctx}/static/ajax/bootstrap-table/extensions/mobile/bootstrap-table-mobile.js?v=20200727"></script>
<!-- 遮罩层 -->
<script src="${ctx}/static/ajax/blockUI/jquery.blockUI.js"></script>
<script src="${ctx}/static/ajax/iCheck/icheck.min.js"></script>
<script src="${ctx}/static/ajax/layer/layer.min.js"></script>
<script src="${ctx}/static/ajax/layui/layui.js"></script>
<script src="${ctx}/static/ajax/easy-ui/common.js?v=4.5.1"></script>
<script src="${ctx}/static/ajax/easy-ui/easy-ui.js?v=4.5.1"></script>

<script type="text/javascript">
    let prefix = "/mall/orders";
    $("#form-orders-add").validate({
        focusCleanup: true
    });

    function submitHandler() {
        if ($.validate.form()) {
            $.operate.save(prefix, $('#form-orders-add').serialize());
        }
    }
</script>
</body>
</html>