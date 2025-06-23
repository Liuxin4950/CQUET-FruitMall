# 购物车API测试文档

## 简化版加入购物车接口

### 接口地址
```
POST /web/cart/add
```

### 请求方式1：简化参数（推荐）
只需要传入商品ID和数量，其他信息（价格、商品名称、图片）会自动从商品表获取。

#### 请求参数
```json
{
    "productId": "1",
    "amount": 2
}
```

#### 或者使用表单参数
```
productId=1&amount=2
```

### 请求方式2：完整参数（兼容旧版本）
```json
{
    "productId": "1",
    "amount": 2,
    "price": 15.80,
    "productName": "红富士苹果",
    "productPic": "/images/apple.jpg"
}
```

### 响应格式
#### 成功响应
```json
{
    "code": 200,
    "msg": "添加成功",
    "data": null
}
```

#### 失败响应
```json
{
    "code": 500,
    "msg": "添加失败，请检查商品是否存在",
    "data": null
}
```

### 错误码说明
- `参数异常：需要productId和amount` - 缺少必要参数
- `商品数量必须大于0` - 数量参数无效
- `数量格式错误` - 数量不是有效数字
- `用户未登录` - 需要先登录
- `添加失败，请检查商品是否存在` - 商品ID不存在或其他业务错误

### 优势
1. **简化调用**：前端只需要传入商品ID和数量
2. **数据一致性**：商品信息直接从数据库获取，避免数据不一致
3. **向下兼容**：仍然支持传入完整参数的旧版本调用方式
4. **自动验证**：自动验证商品是否存在

### 使用示例

#### JavaScript调用示例
```javascript
// 简化版本调用
fetch('/web/cart/add', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        productId: '1',
        amount: 2
    })
})
.then(response => response.json())
.then(data => {
    if (data.code === 200) {
        alert('添加成功');
    } else {
        alert(data.msg);
    }
});
```

#### jQuery调用示例
```javascript
$.ajax({
    url: '/web/cart/add',
    type: 'POST',
    data: {
        productId: '1',
        amount: 2
    },
    success: function(data) {
        if (data.code === 200) {
            alert('添加成功');
        } else {
            alert(data.msg);
        }
    }
});
```