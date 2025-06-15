<%@ page import="org.example.emarketmall.entity.Orders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>订单管理-编辑</title>
    <script type="text/javascript" src="../../static/js/common/common-css.js"></script>

    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <%-- 建议使用EL方式或者把变量保存到pageContext中的方式读取保存在request和session中的变量 --%>
    <% pageContext.setAttribute("order", request.getAttribute("order")); %>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body class="white-bg">
<div class="wrapper wrapper-content animated fadeInRight ibox-content">
    <form class="form-horizontal m" id="form-orders-edit">
        <input name="id" type="hidden" value="${order.id}">
        <div class="form-group">
            <label class="col-sm-3 control-label">订单号：</label>
            <div class="col-sm-8">
                <input name="orderNum" class="form-control" value="${order.orderNum}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">用户ID：</label>
            <div class="col-sm-8">
                <input name="userId" class="form-control" value="${order.userId}" type="number" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">收货人：</label>
            <div class="col-sm-8">
                <input name="shippingUser" class="form-control" value="${order.shippingUser}" type="text" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">收货地址：</label>
            <div class="col-sm-8">
                <textarea name="address" class="form-control" rows="3" required>${order.address}</textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">订单金额：</label>
            <div class="col-sm-8">
                <input name="orderMoney" class="form-control" value="${order.orderMoney}" type="number" step="0.01" min="0" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">运费：</label>
            <div class="col-sm-8">
                <input name="shippingMoney" class="form-control" value="${order.shippingMoney}" type="number" step="0.01" min="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">优惠金额：</label>
            <div class="col-sm-8">
                <input name="districtMoney" class="form-control" value="${order.districtMoney}" type="number" step="0.01" min="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">支付方式：</label>
            <div class="col-sm-8">
                <select name="paymentMethod" class="form-control" required>
                    <option value="">请选择支付方式</option>
                    <option value="1" ${order.paymentMethod == 1 ? 'selected' : ''}>支付宝</option>
                    <option value="2" ${order.paymentMethod == 2 ? 'selected' : ''}>微信支付</option>
                    <option value="3" ${order.paymentMethod == 3 ? 'selected' : ''}>银行卡</option>
                    <option value="4" ${order.paymentMethod == 4 ? 'selected' : ''}>货到付款</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">订单状态：</label>
            <div class="col-sm-8">
                <select name="orderStatus" class="form-control">
                    <option value="1" ${order.orderStatus == 1 ? 'selected' : ''}>待支付</option>
                    <option value="2" ${order.orderStatus == 2 ? 'selected' : ''}>已支付</option>
                    <option value="3" ${order.orderStatus == 3 ? 'selected' : ''}>已发货</option>
                    <option value="4" ${order.orderStatus == 4 ? 'selected' : ''}>已完成</option>
                    <option value="5" ${order.orderStatus == 5 ? 'selected' : ''}>已取消</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">支付交易号：</label>
            <div class="col-sm-8">
                <input name="paymentTransactionId" class="form-control" value="${order.paymentTransactionId}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">下单时间：</label>
            <div class="col-sm-8">
                <input name="orderTime" class="form-control" value="${order.createdTime}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">支付时间：</label>
            <div class="col-sm-8">
                <input name="paymentTime" class="form-control" value="${order.payTime}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">发货时间：</label>
            <div class="col-sm-8">
                <input name="shippingTime" class="form-control" value="${order.shipTime}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">完成时间：</label>
            <div class="col-sm-8">
                <input name="completeTime" class="form-control" value="${order.receiveTime}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">备注：</label>
            <div class="col-sm-8">
                <textarea name="remark" class="form-control" rows="3">${order.remark}</textarea>
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
    $("#form-orders-edit").validate({
        focusCleanup: true
    });

    function submitHandler() {
        if ($.validate.form()) {
            $.operate.save(prefix, $('#form-orders-edit').serialize());
        }
    }
</script>
</body>
</html>