# 购物车列表查询API文档

## 接口概述
获取当前登录用户的购物车商品列表，包含商品详细信息、库存状态、价格统计等完整信息。

## 接口地址
```
GET /web/cart/list
```

## 请求参数
无需额外参数，用户身份通过Session获取。

## 返回数据结构

### 成功响应
```json
{
    "code": 200,
    "msg": "操作成功",
    "data": {
        "cartList": [
            {
                "id": 1,
                "productId": "1",
                "productCode": "APPLE001",
                "productName": "红富士苹果",
                "amount": 2,
                "price": 15.80,
                "subtotal": 31.60,
                "userId": 1,
                "isSelected": true,
                "productPic": "/images/apple.jpg",
                "description": "新鲜红富士苹果，口感脆甜",
                "weightUnit": "斤",
                "originPlace": "山东烟台",
                "stock": 100,
                "hasStock": true
            }
        ],
        "summary": {
            "totalAmount": 31.60,
            "selectedAmount": 31.60,
            "totalCount": 2,
            "selectedCount": 2,
            "cartSize": 1,
            "allSelected": true,
            "isEmpty": false
        }
    }
}
```

### 失败响应
```json
{
    "code": 500,
    "msg": "获取购物车列表失败: 具体错误信息",
    "data": null
}
```

## 数据字段说明

### cartList 字段说明
| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | Integer | 购物车记录ID |
| productId | String | 商品ID |
| productCode | String | 商品编码 |
| productName | String | 商品名称 |
| amount | Integer | 购买数量 |
| price | BigDecimal | 商品单价 |
| subtotal | BigDecimal | 小计金额 (单价 × 数量) |
| userId | Integer | 用户ID |
| isSelected | Boolean | 是否选中 |
| productPic | String | 商品图片URL |
| description | String | 商品描述 |
| weightUnit | String | 重量单位 |
| originPlace | String | 产地 |
| stock | Integer | 库存数量 |
| hasStock | Boolean | 是否有足够库存 |

### summary 统计信息字段说明
| 字段名 | 类型 | 说明 |
|--------|------|------|
| totalAmount | BigDecimal | 购物车总金额 |
| selectedAmount | BigDecimal | 选中商品总金额 |
| totalCount | Integer | 购物车总商品数量 |
| selectedCount | Integer | 选中商品数量 |
| cartSize | Integer | 购物车商品种类数 |
| allSelected | Boolean | 是否全选 |
| isEmpty | Boolean | 购物车是否为空 |

## 功能特点

### 🔗 自动关联商品信息
- 自动从商品表获取最新的商品详细信息
- 补充购物车中可能缺失的商品信息（名称、图片等）
- 实时获取库存状态，判断是否有足够库存

### 📊 智能统计计算
- **总金额统计**：计算购物车所有商品的总价值
- **选中商品统计**：只计算用户选中商品的金额和数量
- **库存检查**：实时检查每个商品的库存状态
- **全选状态**：自动判断是否所有商品都已选中

### 🛡️ 数据完整性保障
- 即使某个商品信息关联失败，也不影响其他商品的正常显示
- 对空值进行安全处理，避免前端显示异常
- 提供详细的错误信息，便于问题排查

## 使用示例

### JavaScript调用示例
```javascript
fetch('/web/cart/list', {
    method: 'GET',
    credentials: 'include'  // 包含session信息
})
.then(response => response.json())
.then(data => {
    if (data.code === 200) {
        const { cartList, summary } = data.data;
        
        // 显示购物车商品列表
        console.log('购物车商品:', cartList);
        
        // 显示统计信息
        console.log('总金额:', summary.totalAmount);
        console.log('选中金额:', summary.selectedAmount);
        console.log('商品数量:', summary.totalCount);
        console.log('是否全选:', summary.allSelected);
        
        // 检查库存状态
        cartList.forEach(item => {
            if (!item.hasStock) {
                console.warn(`商品 ${item.productName} 库存不足`);
            }
        });
    } else {
        console.error('获取购物车失败:', data.msg);
    }
})
.catch(error => {
    console.error('请求失败:', error);
});
```

### jQuery调用示例
```javascript
$.get('/web/cart/list', function(data) {
    if (data.code === 200) {
        const { cartList, summary } = data.data;
        
        // 更新购物车UI
        updateCartUI(cartList, summary);
        
        // 更新购物车角标
        $('.cart-badge').text(summary.cartSize);
        
        // 更新总价显示
        $('.total-amount').text('¥' + summary.selectedAmount);
        
        // 更新全选状态
        $('#select-all').prop('checked', summary.allSelected);
    } else {
        alert('获取购物车失败: ' + data.msg);
    }
}).fail(function() {
    alert('网络请求失败');
});
```

## 错误处理

### 常见错误码
- `用户未登录` - 需要先登录才能查看购物车
- `获取购物车列表失败` - 数据库查询异常或其他系统错误

### 前端处理建议
1. **登录检查**：如果返回"用户未登录"，引导用户到登录页面
2. **空购物车处理**：当`summary.isEmpty`为true时，显示空购物车提示
3. **库存提醒**：检查`hasStock`字段，对库存不足的商品给予提醒
4. **网络异常**：添加重试机制和友好的错误提示

## 性能优化

### 后端优化
- 使用连接查询减少数据库访问次数
- 对商品信息进行缓存，减少重复查询
- 异步处理商品信息关联，提高响应速度

### 前端优化
- 合理使用缓存，避免频繁请求
- 实现增量更新，只更新变化的数据
- 添加加载状态，提升用户体验