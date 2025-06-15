<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>订单管理</title>
    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <link href="${ctx}/static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${ctx}/static/css/style.css" rel="stylesheet"/>
    <!-- bootstrap-table 表格插件样式 -->
    <link href="${ctx}/static/ajax/bootstrap-table/bootstrap-table.min.css?v=20200727" rel="stylesheet"/>
    <link href="${ctx}/static/css/animate.css" rel="stylesheet"/>
    <link href="${ctx}/static/css/style.css?v=20200903" rel="stylesheet"/>
    <link href="${ctx}/static/ajax/easy-ui/easy-ui.css?v=4.5.1" rel="stylesheet"/>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>

<body class="gray-bg">
<jsp:include page="${ctx}/common/menu.jsp"/>
<div class="mcw">
    <div class="col-md-12">
        <div class="container-div">
            <div class="row">
                <div class="col-sm-12 search-collapse">
                    <form id="formId">
                        <div class="select-list">
                            <ul>
                                <li>
                                    <label>订单号：</label>
                                    <input type="text" name="orderNum" id="orderNum"/>
                                </li>
                                <li>
                                    <label>用户ID：</label>
                                    <input type="text" name="userId" id="userId"/>
                                </li>
                                <li>
                                    <label>订单状态：</label>
                                    <select name="orderStatus" id="orderStatus">
                                        <option value="">全部</option>
                                        <option value="1">待支付</option>
                                        <option value="2">已支付</option>
                                        <option value="3">已发货</option>
                                        <option value="4">已完成</option>
                                        <option value="5">已取消</option>
                                    </select>
                                </li>
                                <li>
                                    <label>支付方式：</label>
                                    <select name="paymentMethod" id="paymentMethod">
                                        <option value="">全部</option>
                                        <option value="1">支付宝</option>
                                        <option value="2">微信支付</option>
                                        <option value="3">银行卡</option>
                                        <option value="4">货到付款</option>
                                    </select>
                                </li>
                                <li>
                                    <a class="btn btn-primary btn-rounded btn-sm" onclick="$.table.search()">
                                        <i class="fa fa-search"></i>&nbsp;搜索</a>
                                    <a class="btn btn-warning btn-rounded btn-sm" onclick="$.form.reset()">
                                        <i class="fa fa-refresh"></i>&nbsp;重置</a>
                                </li>
                            </ul>
                        </div>
                    </form>
                </div>

                <div class="btn-group-sm" id="toolbar" role="group">
                    <a class="btn btn-success" onclick="$.operate.add()">
                        <i class="fa fa-plus"></i> 新增
                    </a>
                    <a class="btn btn-primary single disabled" onclick="$.operate.edit()">
                        <i class="fa fa-edit"></i> 修改
                    </a>
                    <a class="btn btn-info single disabled" onclick="updateOrderStatus()">
                        <i class="fa fa-refresh"></i> 更新状态
                    </a>
                </div>

                <div class="col-sm-12 select-table table-striped">
                    <table id="bootstrap-table"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>
<!-- bootstrap-table 表格插件 -->
<script src="${ctx}/static/ajax/bootstrap-table/bootstrap-table.min.js?v=20200727"></script>
<script src="${ctx}/static/ajax/bootstrap-table/locale/bootstrap-table-zh-CN.min.js?v=20200727"></script>
<script src="${ctx}/static/ajax/bootstrap-table/extensions/mobile/bootstrap-table-mobile.js?v=20200727"></script>
<!-- 验证插件 -->
<script src="${ctx}/static/js/validate/jquery.validate.min.js"></script>
<script src="${ctx}/static/js/validate/messages_zh.min.js"></script>
<script src="${ctx}/static/js/login.js"></script>
<!-- 遮罩层 -->
<script src="${ctx}/static/ajax/blockUI/jquery.blockUI.js"></script>
<script src="${ctx}/static/ajax/iCheck/icheck.min.js"></script>
<script src="${ctx}/static/ajax/layer/layer.min.js"></script>
<script src="${ctx}/static/ajax/layui/layui.js"></script>
<script src="${ctx}/static/ajax/easy-ui/common.js?v=4.5.1"></script>
<script src="${ctx}/static/ajax/easy-ui/easy-ui.js?v=4.5.1"></script>

<script type="text/javascript">
    function searchByParam() {
        let orderNumVal = $("#orderNum").val().trim();
        let userIdVal = $("#userId").val().trim();
        let orderStatusVal = $("#orderStatus").val().trim();
        let paymentMethodVal = $("#paymentMethod").val().trim();

        var customParams = {};
        if (orderNumVal) customParams.orderNum = orderNumVal;
        if (userIdVal) customParams.userId = userIdVal;
        if (orderStatusVal) customParams.orderStatus = orderStatusVal;
        if (paymentMethodVal) customParams.paymentMethod = paymentMethodVal;

        $('#bootstrap-table').bootstrapTable('refresh', {
            query: customParams
        });
    }

    let route = "/mall/orders";
    let total;

    $(function () {
        let options = {
            id: "bootstrap-table",
            url: route + "?opt=list",
            createUrl: route + "?opt=add",
            updateUrl: route + "?opt=edit&id={id}",
            detailUrl: route + "?opt=detail&id={id}",
            removeUrl: route + "?opt=remove&id={id}",
            toolbar: "toolbar",
            sidePagination: "client",
            pagination: true,
            paginationLoop: false,
            pageSize: 20,
            pageList: [10, 25, 50],
            modalName: "订单信息",
            formId: "formId",
            queryParams: function(params) {
                var curParams = {
                    pageSize: params.limit,
                    pageNum: params.offset / params.limit + 1,
                    searchValue: params.search,
                    orderByColumn: params.sort,
                    isAsc: params.order
                };
                return $.extend(curParams, $.common.formToJSON("formId"));
            },
            columns: [{
                checkbox: true
            },
            {
                field: 'id',
                title: 'ID',
                visible: false
            },
            {
                field: 'orderNum',
                title: '订单号'
            },
            {
                field: 'userId',
                title: '用户ID'
            },
            {
                field: 'shippingUser',
                title: '收货人'
            },
            {
                field: 'orderMoney',
                title: '订单金额',
                formatter: function (value) {
                    return '￥' + (value || 0).toFixed(2);
                }
            },
            {
                field: 'orderStatus',
                title: '订单状态',
                formatter: function (value) {
                    switch (value) {
                        case 1: return '<span class="label label-warning">待支付</span>';
                        case 2: return '<span class="label label-info">已支付</span>';
                        case 3: return '<span class="label label-primary">已发货</span>';
                        case 4: return '<span class="label label-success">已完成</span>';
                        case 5: return '<span class="label label-danger">已取消</span>';
                        default: return '<span class="label label-default">未知</span>';
                    }
                }
            },
            {
                field: 'paymentMethod',
                title: '支付方式',
                formatter: function (value) {
                    switch (value) {
                        case 1: return '支付宝';
                        case 2: return '微信支付';
                        case 3: return '银行卡';
                        default: return '未知';
                    }
                }
            },
            {
                field: 'shippingUser',
                title: '收货人'
            },
            {
                field: 'address',
                title: '收货地址'
            },
            {
                field: 'createdTime',
                title: '下单时间'
            },
            {
                title: '操作',
                align: 'center',
                formatter: function (value, row, index) {
                    var actions = [];
                    actions.push('<a class="btn btn-success btn-xs" href="#" onclick="$.operate.detail(\'' + row.id + '\')" title="详情"><i class="fa fa-search"></i>详情</a> ');
                    actions.push('<a class="btn btn-warning btn-xs" href="#" onclick="$.operate.edit(\'' + row.id + '\')" title="编辑"><i class="fa fa-edit"></i>编辑</a> ');
                    
                    // 根据订单状态显示不同的操作按钮
                    if (row.orderStatus == 1) { // 待支付
                        actions.push('<a class="btn btn-primary btn-xs" href="#" onclick="payOrder(\'' + row.id + '\')" title="支付"><i class="fa fa-credit-card"></i>支付</a> ');
                        actions.push('<a class="btn btn-default btn-xs" href="#" onclick="cancelOrder(\'' + row.id + '\')" title="取消"><i class="fa fa-times"></i>取消</a> ');
                    } else if (row.orderStatus == 2) { // 已支付
                        actions.push('<a class="btn btn-info btn-xs" href="#" onclick="shipOrder(\'' + row.id + '\')" title="发货"><i class="fa fa-truck"></i>发货</a> ');
                    } else if (row.orderStatus == 3) { // 已发货
                        actions.push('<a class="btn btn-success btn-xs" href="#" onclick="confirmReceive(\'' + row.id + '\')" title="确认收货"><i class="fa fa-check"></i>确认收货</a> ');
                    }
                    
                    actions.push('<a class="btn btn-danger btn-xs" href="#" onclick="$.operate.remove(\'' + row.id + '\')" title="删除"><i class="fa fa-remove"></i>删除</a>');
                    return actions.join('');
                }
            }]
        };
        $.table.init(options);
    });

    // 支付订单
    function payOrder(orderId) {
        layer.prompt({
            title: '支付订单',
            formType: 0,
            value: '',
            area: ['300px', '100px']
        }, function(value, index, elem){
            if (value.trim() === '') {
                layer.msg('请输入支付交易号');
                return;
            }
            $.ajax({
                url: route + "?opt=pay",
                type: "POST",
                data: {
                    id: orderId,
                    paymentTransactionId: value
                },
                success: function(result) {
                    if (result.code == 200) {
                        layer.msg('支付成功');
                        $('#bootstrap-table').bootstrapTable('refresh');
                    } else {
                        layer.msg(result.msg || '支付失败');
                    }
                }
            });
            layer.close(index);
        });
    }

    // 取消订单
    function cancelOrder(orderId) {
        layer.confirm('确定要取消该订单吗？', function(index){
            $.ajax({
                url: route + "?opt=cancel",
                type: "POST",
                data: { id: orderId },
                success: function(result) {
                    if (result.code == 200) {
                        layer.msg('取消成功');
                        $('#bootstrap-table').bootstrapTable('refresh');
                    } else {
                        layer.msg(result.msg || '取消失败');
                    }
                }
            });
            layer.close(index);
        });
    }

    // 发货
    function shipOrder(orderId) {
        layer.confirm('确定要发货吗？', function(index){
            $.ajax({
                url: route + "?opt=ship",
                type: "POST",
                data: { id: orderId },
                success: function(result) {
                    if (result.code == 200) {
                        layer.msg('发货成功');
                        $('#bootstrap-table').bootstrapTable('refresh');
                    } else {
                        layer.msg(result.msg || '发货失败');
                    }
                }
            });
            layer.close(index);
        });
    }

    // 确认收货
    function confirmReceive(orderId) {
        layer.confirm('确定要确认收货吗？', function(index){
            $.ajax({
                url: route + "?opt=confirm",
                type: "POST",
                data: { id: orderId },
                success: function(result) {
                    if (result.code == 200) {
                        layer.msg('确认收货成功');
                        $('#bootstrap-table').bootstrapTable('refresh');
                    } else {
                        layer.msg(result.msg || '确认收货失败');
                    }
                }
            });
            layer.close(index);
        });
    }

    // 更新订单状态
    function updateOrderStatus() {
        var rows = $('#bootstrap-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            layer.msg('请选择要更新的订单');
            return;
        }
        if (rows.length > 1) {
            layer.msg('只能选择一个订单进行状态更新');
            return;
        }
        
        layer.open({
            type: 1,
            title: '更新订单状态',
            area: ['400px', '200px'],
            content: '<div style="padding: 20px;">' +
                     '<select id="newStatus" style="width: 100%; padding: 5px;">' +
                     '<option value="1">待支付</option>' +
                     '<option value="2">已支付</option>' +
                     '<option value="3">已发货</option>' +
                     '<option value="4">已完成</option>' +
                     '<option value="5">已取消</option>' +
                     '</select>' +
                     '<div style="text-align: center; margin-top: 20px;">' +
                     '<button onclick="doUpdateStatus(' + rows[0].id + ')" class="btn btn-primary">确定</button>' +
                     '<button onclick="layer.closeAll()" class="btn btn-default">取消</button>' +
                     '</div>' +
                     '</div>'
        });
    }

    function doUpdateStatus(orderId) {
        var newStatus = $('#newStatus').val();
        $.ajax({
            url: route + "?opt=updateStatus",
            type: "POST",
            data: { 
                id: orderId,
                orderStatus: newStatus
            },
            success: function(result) {
                if (result.code == 200) {
                    layer.msg('状态更新成功');
                    $('#bootstrap-table').bootstrapTable('refresh');
                    layer.closeAll();
                } else {
                    layer.msg(result.msg || '状态更新失败');
                }
            }
        });
    }
</script>
</body>
</html>