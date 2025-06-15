<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="EmarketMall系统">
    <title>商品管理-详情</title>
    <script type="text/javascript" src="../../static/js/common/common-css.js"></script>

    <% pageContext.setAttribute("ctx", request.getContextPath());%>
    <%-- 建议使用EL方式或者把变量保存到pageContext中的方式读取保存在request和session中的变量 --%>
    <% pageContext.setAttribute("product", request.getAttribute("product")); %>
    <!-- 360浏览器急速模式 -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body class="white-bg">
<div class="wrapper wrapper-content animated fadeInRight ibox-content">
    <form class="form-horizontal m" id="form-product-detail">
        <input name="id" type="hidden" value="${product.id}">
        <div class="form-group">
            <label class="col-sm-3 control-label">商品编码：</label>
            <div class="col-sm-8">
                <input name="productCode" class="form-control" value="${product.productCode}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">商品名称：</label>
            <div class="col-sm-8">
                <input name="productName" class="form-control" value="${product.productName}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">一级分类ID：</label>
            <div class="col-sm-8">
                <input name="oneCategoryId" class="form-control" value="${product.oneCategoryId}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">二级分类ID：</label>
            <div class="col-sm-8">
                <input name="twoCategoryId" class="form-control" value="${product.twoCategoryId}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">价格：</label>
            <div class="col-sm-8">
                <input name="price" class="form-control" value="￥${product.price}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">折扣价：</label>
            <div class="col-sm-8">
                <input name="discountPrice" class="form-control" value="${product.discountPrice != null ? '￥'.concat(product.discountPrice) : '无'}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">库存：</label>
            <div class="col-sm-8">
                <input name="stock" class="form-control" value="${product.stock}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">商品图片URL：</label>
            <div class="col-sm-8">
                <input name="imageUrl" class="form-control" value="${product.imageUrl}" type="text" readonly>
                <c:if test="${not empty product.imageUrl}">
                    <div style="margin-top: 10px;">
                        <img src="${product.imageUrl}" alt="商品图片" style="max-width: 200px; max-height: 200px; border: 1px solid #ddd; border-radius: 4px;">
                    </div>
                </c:if>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">发布状态：</label>
            <div class="col-sm-8">
                <input name="publishStatus" class="form-control" value="${product.publishStatus == 1 ? '已发布' : '未发布'}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">是否有机食品：</label>
            <div class="col-sm-8">
                <input name="isOrganic" class="form-control" value="${product.isOrganic == true ? '是' : '否'}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">产地：</label>
            <div class="col-sm-8">
                <input name="originPlace" class="form-control" value="${product.originPlace}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">生产日期：</label>
            <div class="col-sm-8">
                <input name="productionDate" class="form-control" value="${product.productionDate}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">保质期（天）：</label>
            <div class="col-sm-8">
                <input name="shelfLife" class="form-control" value="${product.shelfLife}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">商品描述：</label>
            <div class="col-sm-8">
                <textarea name="description" class="form-control" rows="4" readonly>${product.description}</textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">创建时间：</label>
            <div class="col-sm-8">
                <input name="createdTime" class="form-control" value="${product.createdTime}" type="text" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">更新时间：</label>
            <div class="col-sm-8">
                <input name="updatedTime" class="form-control" value="${product.updatedTime}" type="text" readonly>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="../../static/js/common/common-js.js"></script>
</body>
</html>