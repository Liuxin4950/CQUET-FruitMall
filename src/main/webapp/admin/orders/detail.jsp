<%@ page import="org.example.emarketmall.entity.Orders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>订单管理-详情</title>
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
    <form class="form-horizontal m">
        <h4 class="form-header h4">基本信息</h4>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">订单号：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.orderNum}" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">用户ID：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.userId}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">订单状态：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${
                            order.orderStatus == 1 ? '待支付' :
                            order.orderStatus == 2 ? '已支付' :
                            order.orderStatus == 3 ? '已发货' :
                            order.orderStatus == 4 ? '已完成' :
                            order.orderStatus == 5 ? '已取消' : '未知'
                        }" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">支付方式：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.paymentMethod == 1 ? '支付宝' : order.paymentMethod == 2 ? '微信支付' : order.paymentMethod == 3 ? '银行卡' : order.paymentMethod == 4 ? '货到付款' : '未知'}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        
        <h4 class="form-header h4">金额信息</h4>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">订单金额：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="￥${order.orderMoney}" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">运费：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="￥${order.shippingMoney}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">优惠金额：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="￥${order.districtMoney}" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">实付金额：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="￥${order.orderMoney + order.shippingMoney - order.districtMoney}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        
        <h4 class="form-header h4">收货信息</h4>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">收货人：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.shippingUser}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label">收货地址：</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="2" readonly>${order.address}</textarea>
                    </div>
                </div>
            </div>
        </div>
        
        <h4 class="form-header h4">时间信息</h4>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">下单时间：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.createdTime}" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">支付时间：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.payTime}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">发货时间：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.shipTime}" type="text" readonly>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">完成时间：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.receiveTime}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        
        <h4 class="form-header h4">支付信息</h4>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">支付交易号：</label>
                    <div class="col-sm-8">
                        <input class="form-control" value="${order.paymentTransactionId}" type="text" readonly>
                    </div>
                </div>
            </div>
        </div>
        
        <h4 class="form-header h4">其他信息</h4>
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label">备注：</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="3" readonly>${order.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 订单详情商品列表 -->
        <h4 class="form-header h4">商品详情</h4>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>商品ID</th>
                                <th>商品名称</th>
                                <th>商品价格</th>
                                <th>购买数量</th>
                                <th>小计</th>
                            </tr>
                        </thead>
                        <tbody id="orderDetailsList">
                            <!-- 这里可以通过AJAX加载订单详情数据 -->
                        </tbody>
                    </table>
                </div>
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
    $(function() {
        // 加载订单详情商品列表
        loadOrderDetails();
    });
    
    function loadOrderDetails() {
        var orderId = '${order.id}';
        if (orderId) {
            $.ajax({
                url: '/mall/orderDetail?opt=list',
                type: 'POST',
                data: { orderId: orderId },
                success: function(result) {
                    if (result.code == 200 && result.data) {
                        var html = '';
                        var totalAmount = 0;
                        $.each(result.data, function(index, item) {
                            var subtotal = item.productPrice * item.productNum;
                            totalAmount += subtotal;
                            html += '<tr>';
                            html += '<td>' + item.productId + '</td>';
                            html += '<td>' + (item.productName || '未知商品') + '</td>';
                            html += '<td>￥' + item.productPrice.toFixed(2) + '</td>';
                            html += '<td>' + item.productNum + '</td>';
                            html += '<td>￥' + subtotal.toFixed(2) + '</td>';
                            html += '</tr>';
                        });
                        html += '<tr class="info">';
                        html += '<td colspan="4" class="text-right"><strong>合计：</strong></td>';
                        html += '<td><strong>￥' + totalAmount.toFixed(2) + '</strong></td>';
                        html += '</tr>';
                        $('#orderDetailsList').html(html);
                    } else {
                        $('#orderDetailsList').html('<tr><td colspan="5" class="text-center">暂无商品详情</td></tr>');
                    }
                },
                error: function() {
                    $('#orderDetailsList').html('<tr><td colspan="5" class="text-center">加载商品详情失败</td></tr>');
                }
            });
        }
    }
</script>
</body>
</html>