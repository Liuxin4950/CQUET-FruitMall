<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>商品管理</title>
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
                                    <label>商品名称：</label>
                                    <input type="text" name="productName" id="productName"/>
                                </li>
                                <li>
                                    <label>商品编码：</label>
                                    <input type="text" name="productCode" id="productCode"/>
                                </li>
                                <li>
                                    <label>发布状态：</label>
                                    <select name="publishStatus" id="publishStatus">
                                        <option value="">所有</option>
                                        <option value="0">未发布</option>
                                        <option value="1">已发布</option>
                                    </select>
                                </li>
                                <li>
                                    <label>价格范围：</label>
                                    <input type="number" name="minPrice" id="minPrice" placeholder="最低价" style="width: 80px;"/>
                                    -
                                    <input type="number" name="maxPrice" id="maxPrice" placeholder="最高价" style="width: 80px;"/>
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
                    <a class="btn btn-danger multiple disabled" onclick="$.operate.removeAll()">
                        <i class="fa fa-remove"></i> 删除
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
        // 获取所有输入框的值
        let productNameVal = $("#productName").val().trim();
        let productCodeVal = $("#productCode").val().trim();
        let publishStatusVal = $("#publishStatus").val();
        let minPriceVal = $("#minPrice").val();
        let maxPriceVal = $("#maxPrice").val();

        var customParams = {};
        if (productNameVal) customParams.productName = productNameVal;
        if (productCodeVal) customParams.productCode = productCodeVal;
        if (publishStatusVal) customParams.publishStatus = publishStatusVal;
        if (minPriceVal) customParams.minPrice = minPriceVal;
        if (maxPriceVal) customParams.maxPrice = maxPriceVal;

        // 通过表格刷新触发 queryParams
        $('#bootstrap-table').bootstrapTable('refresh', {
            query: customParams // 传递自定义参数
        });
    }
    
    let route = "/mall/product";
    let total;
    
    //使用集成的bootstrap-table显示和查询
    $(function () {
        let options = {
            id: "bootstrap-table",
            url: route + "?opt=list",
            createUrl: route + "?opt=add",
            removeUrl: route + "?opt=remove&id={id}",
            updateUrl: route + "?opt=edit&id={id}",
            detailUrl: route + "?opt=detail&id={id}",
            toolbar: "toolbar",
            //分页
            sidePagination: "client",
            pagination: true,
            paginationLoop: false,
            pageSize: 20,
            pageList: [10, 25, 50],
            modalName: "商品信息",
            columns: [{
                checkbox: true
            },
                {
                    field: 'id',
                    title: 'ID',
                    visible: false
                },
                {
                    field: 'productCode',
                    title: '商品编码'
                },
                {
                    field: 'productName',
                    title: '商品名称'
                },
                {
                    field: 'price',
                    title: '价格',
                    formatter: function (value) {
                        return '￥' + (value || 0).toFixed(2);
                    }
                },
                {
                    field: 'discountPrice',
                    title: '折扣价',
                    formatter: function (value) {
                        return value ? '￥' + value.toFixed(2) : '-';
                    }
                },
                {
                    field: 'stock',
                    title: '库存'
                },
                {
                    field: 'imageUrl',
                    title: '商品图片',
                    formatter: function (value) {
                        if (value) {
                            return '<img src="' + value + '" alt="商品图片" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;" onerror="this.src=\'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjUwIiBoZWlnaHQ9IjUwIiBmaWxsPSIjRjVGNUY1Ii8+CjxwYXRoIGQ9Ik0yNSAyMEMyNi4zODA3IDIwIDI3LjUgMTguODgwNyAyNy41IDE3LjVDMjcuNSAxNi4xMTkzIDI2LjM4MDcgMTUgMjUgMTVDMjMuNjE5MyAxNSAyMi41IDE2LjExOTMgMjIuNSAxNy41QzIyLjUgMTguODgwNyAyMy42MTkzIDIwIDI1IDIwWiIgZmlsbD0iIzk5OTk5OSIvPgo8cGF0aCBkPSJNMzUgMTBIMTVDMTMuMzQzMSAxMCAxMiAxMS4zNDMxIDEyIDEzVjM3QzEyIDM4LjY1NjkgMTMuMzQzMSA0MCAxNSA0MEgzNUMzNi42NTY5IDQwIDM4IDM4LjY1NjkgMzggMzdWMTNDMzggMTEuMzQzMSAzNi42NTY5IDEwIDM1IDEwWk0zNSAzN0wxNSAzN1YxM0gzNVYzN1oiIGZpbGw9IiM5OTk5OTkiLz4KPC9zdmc+Cg==\'">';
                        } else {
                            return '<span class="text-muted">无图片</span>';
                        }
                    }
                },
                {
                    field: 'publishStatus',
                    title: '发布状态',
                    formatter: function (value) {
                        if (value == 1) {
                            return '<span class="label label-success">已发布</span>';
                        } else {
                            return '<span class="label label-danger">未发布</span>';
                        }
                    }
                },
                {
                    field: 'isOrganic',
                    title: '有机食品',
                    formatter: function (value) {
                        return value == 1 ? '<span class="label label-info">是</span>' : '<span class="label label-default">否</span>';
                    }
                },
                {
                    field: 'originPlace',
                    title: '产地'
                },
                {
                    field: 'createdTime',
                    title: '创建时间',
                    formatter: function (value) {
                        if (value) {
                            return new Date(value).toLocaleString();
                        }
                        return '-';
                    }
                },
                {
                    title: '操作',
                    align: 'center',
                    formatter: function (value, row, index) {
                        var actions = [];
                        actions.push('<a class="btn btn-success btn-xs" href="#" onclick="$.operate.detail(\'' + row.id + '\')" title="详情">详情<i class="fa fa-search"></i></a> ');
                        actions.push('<a class="btn btn-warning btn-xs" href="#" onclick="$.operate.edit(\'' + row.id + '\')" title="编辑">编辑<i class="fa fa-edit"></i></a> ');
                        
                        // 发布状态切换按钮
                        if (row.publishStatus == 1) {
                            actions.push('<a class="btn btn-info btn-xs" href="#" onclick="updateStatus(\'' + row.id + '\', 0)" title="下架">下架<i class="fa fa-arrow-down"></i></a> ');
                        } else {
                            actions.push('<a class="btn btn-primary btn-xs" href="#" onclick="updateStatus(\'' + row.id + '\', 1)" title="上架">上架<i class="fa fa-arrow-up"></i></a> ');
                        }
                        
                        actions.push('<a class="btn btn-danger btn-xs" href="#" onclick="$.operate.remove(\'' + row.id + '\')" title="删除">删除<i class="fa fa-remove"></i></a>');
                        return actions.join('');
                    }
                }]
        };
        $.table.init(options);
    });
    
    // 更新商品状态
    function updateStatus(id, status) {
        $.ajax({
            url: route + "?opt=updateStatus",
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                publishStatus: status
            }),
            success: function(result) {
                if (result.code == 0) {
                    $.modal.msgSuccess(result.msg);
                    $('#bootstrap-table').bootstrapTable('refresh');
                } else {
                    $.modal.alertError(result.msg);
                }
            },
            error: function() {
                $.modal.alertError("操作失败");
            }
        });
    }
</script>
</body>
</html>