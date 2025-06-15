<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>商品管理-新增</title>
    <script type="text/javascript" src="../../static/js/common/common-css.js"></script>

    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body class="white-bg">
<div class="wrapper wrapper-content animated fadeInRight ibox-content">
    <form class="form-horizontal m" id="form-product-add">
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">商品编码：</label>
            <div class="col-sm-8">
                <input name="productCode" class="form-control" type="text" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">商品名称：</label>
            <div class="col-sm-8">
                <input name="productName" class="form-control" type="text" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">一级分类ID：</label>
            <div class="col-sm-8">
                <input name="oneCategoryId" class="form-control" type="number">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">二级分类ID：</label>
            <div class="col-sm-8">
                <input name="twoCategoryId" class="form-control" type="number">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label is-required">价格：</label>
            <div class="col-sm-8">
                <input name="price" class="form-control" type="number" step="0.01" min="0" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">折扣价：</label>
            <div class="col-sm-8">
                <input name="discountPrice" class="form-control" type="number" step="0.01" min="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">库存：</label>
            <div class="col-sm-8">
                <input name="stock" class="form-control" type="number" min="0" value="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">商品图片URL：</label>
            <div class="col-sm-8">
                <input name="imageUrl" class="form-control" type="url" placeholder="请输入图片链接地址">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">发布状态：</label>
            <div class="col-sm-8">
                <select name="publishStatus" class="form-control">
                    <option value="0">未发布</option>
                    <option value="1">已发布</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">是否有机食品：</label>
            <div class="col-sm-8">
                <select name="isOrganic" class="form-control">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">产地：</label>
            <div class="col-sm-8">
                <input name="originPlace" class="form-control" type="text">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">生产日期：</label>
            <div class="col-sm-8">
                <input name="productionDate" class="form-control" type="text" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">保质期（天）：</label>
            <div class="col-sm-8">
                <input name="shelfLife" class="form-control" type="number" min="0">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">商品描述：</label>
            <div class="col-sm-8">
                <textarea name="description" class="form-control" rows="4"></textarea>
            </div>
        </div>

    </form>
</div>
<!-- 全局js -->
<script src="${ctx}/static/js/jquery.min.js"></script>
<script src="${ctx}/static/js/bootstrap.min.js"></script>
<!-- 验证插件 -->
<script src="${ctx}/static/js/validate/jquery.validate.min.js"></script>
<script src="${ctx}/static/js/validate/messages_zh.min.js"></script>
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
    let prefix = "/mall/product";
    $("#form-product-add").validate({
        focusCleanup: true,
        rules: {
            productCode: {
                required: true,
                minlength: 2
            },
            productName: {
                required: true,
                minlength: 2
            },
            price: {
                required: true,
                min: 0
            }
        },
        messages: {
            productCode: {
                required: "请输入商品编码",
                minlength: "商品编码长度不能小于2个字符"
            },
            productName: {
                required: "请输入商品名称",
                minlength: "商品名称长度不能小于2个字符"
            },
            price: {
                required: "请输入商品价格",
                min: "价格不能小于0"
            }
        }
    });
    //表单提交商品信息,post请求
    function submitHandler() {
        if ($.validate.form()) {
            $.operate.save(prefix + "?opt=add", $('#form-product-add').serialize());
        }
    }
</script>
</body>
</html>