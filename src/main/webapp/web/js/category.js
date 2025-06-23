/**
 * 分类页面JavaScript模块
 * 负责分类展示、商品加载、购物车操作等功能
 */

// 分类页面管理器
var CategoryManager = {
    // 配置项
    config: {
        // 分类映射
        categoryMap: {
            'apple': { id: 11, name: '🍎 苹果类' },
            'banana': { id: 12, name: '🍌 香蕉类' },
            'citrus': { id: 54, name: '🍊 柑橘类' },
            'berry': { id: 55, name: '🍓 浆果类' },
            'tropical': { id: 56, name: '🥭 热带水果' },
            'stone': { id: 57, name: '🍑 核果类' },
            'melon': { id: 58, name: '🍉 瓜果类' }
        },
        // 商品图标映射
        iconMap: {
            '苹果': 'fa-apple', 'apple': 'fa-apple',
            '香蕉': 'fa-pagelines', 'banana': 'fa-pagelines',
            '橙': 'fa-circle', 'orange': 'fa-circle',
            '葡萄': 'fa-circle-o', 'grape': 'fa-circle-o',
            '草莓': 'fa-heart', 'strawberry': 'fa-heart',
            '西瓜': 'fa-circle', 'watermelon': 'fa-circle',
            '菠萝': 'fa-star', 'pineapple': 'fa-star',
            '芒果': 'fa-leaf', 'mango': 'fa-leaf',
            '樱桃': 'fa-circle', 'cherry': 'fa-circle',
            '桃': 'fa-heart-o', 'peach': 'fa-heart-o',
            '梨': 'fa-lightbulb-o', 'pear': 'fa-lightbulb-o',
            '柠檬': 'fa-sun-o', 'lemon': 'fa-sun-o'
        }
    },
    
    // 状态管理
    state: {
        currentCategory: 'apple',
        categoryProducts: {},
        isLoading: false
    },
    
    // 初始化
    init: function() {
        this.bindEvents();
        this.initializePage();
        this.addCategoryCardAnimation();
    },
    
    // 绑定事件
    bindEvents: function() {
        var self = this;
        
        // 分类标签点击事件
        $('.category-tab').on('click', function() {
            var category = $(this).data('category');
            if (category) {
                self.showCategory(category);
            }
        });
    },
    
    // 初始化页面
    initializePage: function() {
        // 获取URL参数
        var urlParams = new URLSearchParams(window.location.search);
        var categoryId = urlParams.get('categoryId');
        var categoryType = urlParams.get('type');
        
        if (categoryType && this.config.categoryMap[categoryType]) {
            // 根据type参数直接显示分类
            this.showCategory(categoryType);
        } else if (categoryId) {
            // 根据categoryId找到对应的分类
            var category = this.findCategoryById(categoryId);
            this.showCategory(category);
        } else {
            // 默认显示苹果类
            this.showCategory('apple');
        }
    },
    
    // 根据ID查找分类
    findCategoryById: function(categoryId) {
        for (var key in this.config.categoryMap) {
            if (this.config.categoryMap[key].id === categoryId) {
                return key;
            }
        }
        return 'apple'; // 默认返回苹果类
    },
    
    // 显示分类
    showCategory: function(category) {
        if (!this.config.categoryMap[category]) {
            console.error('未知的分类:', category);
            return;
        }
        
        this.state.currentCategory = category;
        
        // 更新UI状态
        this.updateCategoryUI(category);
        
        // 加载商品数据
        this.loadCategoryProducts(category);
        
        // 滚动到顶部
        this.scrollToTop();
    },
    
    // 更新分类UI状态
    updateCategoryUI: function(category) {
        // 隐藏所有分类区域
        $('.category-section').removeClass('active');
        
        // 显示选中的分类区域
        $('#' + category).addClass('active');
        
        // 更新导航标签状态
        $('.category-tab').removeClass('active');
        
        // 激活对应的标签
        var categoryName = this.config.categoryMap[category].name;
        $('.category-tab').each(function() {
            if ($(this).text().trim() === categoryName) {
                $(this).addClass('active');
            }
        });
    },
    
    // 加载分类商品数据
    loadCategoryProducts: function(category) {
        // 如果已经加载过该分类的数据，直接渲染
        if (this.state.categoryProducts[category]) {
            this.renderCategoryProducts(category, this.state.categoryProducts[category]);
            return;
        }
        
        if (this.state.isLoading) {
            return;
        }
        
        this.state.isLoading = true;
        showLoading('正在加载商品数据...');
        
        var categoryId = this.config.categoryMap[category].id;
        var self = this;
        
        console.log('正在加载分类商品，分类:', category, '分类ID:', categoryId);
        
        $.ajax({
            url: window.contextPath + '/web/product',
            type: 'GET',
            data: {
                opt: 'category',
                categoryId: categoryId,
                limit: 20
            },
            dataType: 'json',
            success: function(response) {
                self.state.isLoading = false;
                hideLoading();
                
                console.log('分类商品加载响应:', response);
                
                if (response.code === 0) {
                    var products = response.data || [];
                    self.state.categoryProducts[category] = products;
                    self.renderCategoryProducts(category, products);
                } else {
                    console.error('获取分类商品失败:', response.msg);
                    self.showErrorMessage('获取商品数据失败: ' + (response.msg || '未知错误'));
                }
            },
            error: function(xhr, status, error) {
                self.state.isLoading = false;
                hideLoading();
                console.error('获取分类商品失败:', error);
                self.showErrorMessage('网络错误，请稍后重试');
            }
        });
    },
    
    // 渲染分类商品
    renderCategoryProducts: function(category, products) {
        if (!products || products.length === 0) {
            return; // 保持静态商品显示
        }
        
        var $grid = $('#' + category + ' .fruit-grid');
        var html = '';
        var self = this;
        
        products.forEach(function(product) {
            var icon = self.getProductIcon(product.productName || '');
            var features = self.getProductFeatures(product);
            
            var featuresHtml = features.map(function(feature) {
                return '<span class="feature-tag">' + feature + '</span>';
            }).join('');
            
            html += self.generateProductCardHTML(product, icon, featuresHtml);
        });
        
        // 只有当有商品数据时才替换HTML
        if (html) {
            $grid.html(html);
        }
    },
    
    // 生成商品卡片HTML
    generateProductCardHTML: function(product, icon, featuresHtml) {
        var imageHtml = '';
        
        // 如果有商品图片，显示图片；否则显示图标
        if (product.imageUrl && product.imageUrl.trim() !== '') {
            imageHtml = '<img src="' + product.imageUrl + '" ' +
                       'alt="' + (product.productName || '商品图片') + '" ' +
                       'style="width: 100%; height: 100%; object-fit: cover;" ' +
                       'onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'flex\';">' +
                       '<div style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: linear-gradient(45deg, #27ae60, #2ecc71);">' +
                       '<i class="fa ' + icon + '" style="color: white; font-size: 60px;"></i>' +
                       '</div>';
        } else {
            imageHtml = '<div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: linear-gradient(45deg, #27ae60, #2ecc71);">' +
                       '<i class="fa ' + icon + '" style="color: white; font-size: 60px;"></i>' +
                       '</div>';
        }
        
        // 生成星级评分
        var rating = product.rating ? parseFloat(product.rating) : 0;
        var starsHtml = this.generateStarsHTML(rating);
        
        // 生成标签
        var tags = [];
        if (product.isOrganic) tags.push('有机');
        if (product.isSeasonal) tags.push('时令');
        var tagsHtml = tags.length > 0 ? '<span style="color: #27ae60; font-size: 10px;">' + tags.join(' ') + '</span>' : '';
        
        return '<div class="fruit-card" data-product-id="' + product.id + '">' +
            '<div class="fruit-image" style="position: relative; height: 200px; overflow: hidden;">' +
            (product.salesCount > 100 ? '<div class="fruit-badge">热销</div>' : '') +
            imageHtml +
            '</div>' +
            '<div class="fruit-info">' +
            '<div class="fruit-name">' + (product.productName || '商品名称') + ' ' + tagsHtml + '</div>' +
            '<div class="product-rating" style="display: flex; align-items: center; justify-content: center; margin-bottom: 8px;">' +
            '<span class="stars" style="color: #f39c12; margin-right: 5px;">' + starsHtml + '</span>' +
            '<span style="font-size: 12px; color: #7f8c8d;">' + rating.toFixed(1) + '</span>' +
            '</div>' +
            '<div class="fruit-desc" style="font-size: 12px; color: #7f8c8d; margin-bottom: 8px;">' + (product.description || '新鲜美味，营养丰富') + '</div>' +
            '<div class="product-meta" style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 11px; color: #95a5a6;">' +
            '<span>销量: ' + (product.salesCount || 0) + '</span>' +
            '<span>' + (product.originPlace || '优质产地') + '</span>' +
            '</div>' +
            '<div class="fruit-price">' +
            '<span class="price-current">¥' + (product.price || 0).toFixed(2) + '</span>' +
            '<span class="price-unit">' + (product.weightUnit || '/份') + '</span>' +
            '</div>' +
            '<div class="fruit-actions" style="display: flex; gap: 4px; justify-content: center; flex-wrap: wrap;">' +
            '<button class="btn btn-detail" onclick="CategoryManager.viewProductDetail(' + product.id + ')" ' +
            'style="background-color: #3498db; border: none; color: white; padding: 6px 12px; border-radius: 15px; font-size: 11px; flex: 1; min-width: 60px; transition: all 0.3s ease;">' +
            '<i class="fa fa-eye"></i> 详情' +
            '</button>' +
            '<button class="btn btn-add-cart" onclick="CategoryManager.addToCart(' + product.id + ')" ' +
            'style="background-color: #27ae60; border: none; color: white; padding: 6px 12px; border-radius: 15px; font-size: 11px; flex: 1; min-width: 60px; transition: all 0.3s ease;">' +
            '<i class="fa fa-cart-plus"></i> 加购物车' +
            '</button>' +
            '<button class="btn btn-buy" onclick="CategoryManager.buyNow(' + product.id + ')" ' +
            'style="background-color: #e74c3c; border: none; color: white; padding: 6px 12px; border-radius: 15px; font-size: 11px; flex: 1; min-width: 60px; transition: all 0.3s ease;">' +
            '<i class="fa fa-shopping-cart"></i> 立即购买' +
            '</button>' +
            '</div>' +
            '</div>' +
            '</div>';
    },
    
    // 生成星级评分HTML
    generateStarsHTML: function(rating) {
        var starsHtml = '';
        var fullStars = Math.floor(rating);
        var hasHalfStar = (rating - fullStars) >= 0.5;
        
        for (var i = 0; i < fullStars; i++) {
            starsHtml += '<i class="fa fa-star"></i>';
        }
        if (hasHalfStar) {
            starsHtml += '<i class="fa fa-star-half-o"></i>';
        }
        for (var i = fullStars + (hasHalfStar ? 1 : 0); i < 5; i++) {
            starsHtml += '<i class="fa fa-star-o"></i>';
        }
        
        return starsHtml;
    },
    
    // 获取商品特性
    getProductFeatures: function(product) {
        var features = [];
        
        if (product.isOrganic) features.push('有机');
        if (product.isSeasonal) features.push('时令');
        if (product.originPlace) features.push(product.originPlace);
        
        return features;
    },
    
    // 根据商品名称获取图标
    getProductIcon: function(productName) {
        var name = productName.toLowerCase();
        
        for (var key in this.config.iconMap) {
            if (name.includes(key.toLowerCase())) {
                return this.config.iconMap[key];
            }
        }
        
        return 'fa-leaf'; // 默认图标
    },
    
    // 添加到购物车
    addToCart: function(productId, quantity) {
        quantity = quantity || 1; // 默认数量为1
        
        // 检查登录状态
        if (!window.isUserLoggedIn) {
            alert('请先登录后再购买商品');
            window.location.href = window.contextPath + '/login.jsp';
            return;
        }
        
        // 验证数量
        if (quantity < 1) {
            alert('购买数量不能小于1');
            return;
        }
        
        showLoading('正在添加到购物车...');
        
        $.ajax({
            url:window.contextPath+'/web/cart/add',
            type: 'POST',
            data: {
                productId: productId,
                amount: quantity.toString()
            },
            dataType: 'json',
            success: function(response) {
                console.log('添加购物车响应:', response);
                hideLoading();
                if (response.code === 0) {
                    alert("购物车添加成功");
                } else {
                    alert('购买失败: ' + response.msg);
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('添加购物车失败:', error);
                alert('网络错误，请稍后重试: ' + error);
            }
        });
    },
    
    // 查看商品详情
    viewProductDetail: function(productId) {
        if (!productId) {
            alert('商品ID无效');
            return;
        }
        
        // 使用模态框显示详情
        this.loadProductDetailModal(productId);
    },
    
    // 加载商品详情模态框
    loadProductDetailModal: function(productId) {
        var self = this;
        showLoading('正在加载商品详情...');
        
        $.ajax({
            url: window.contextPath + '/web/product',
            type: 'GET',
            data: {
                opt: 'detail',
                id: productId
            },
            dataType: 'json',
            success: function(response) {
                hideLoading();
                if (response.code === 0 && response.data) {
                    self.showProductDetailModal(response.data);
                } else {
                    alert('获取商品详情失败: ' + (response.msg || '未知错误'));
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('获取商品详情失败:', error);
                alert('网络错误，请稍后重试');
            }
        });
    },
    
    // 显示商品详情模态框
    showProductDetailModal: function(product) {
        var rating = product.rating ? parseFloat(product.rating) : 0;
        var starsHtml = this.generateStarsHTML(rating);
        
        var modalHtml = '<div class="modal fade" id="productDetailModal" tabindex="-1">' +
                       '<div class="modal-dialog modal-lg">' +
                       '<div class="modal-content">' +
                       '<div class="modal-header">' +
                       '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
                       '<h4 class="modal-title">' + (product.productName || '商品详情') + '</h4>' +
                       '</div>' +
                       '<div class="modal-body">' +
                       '<div class="row">' +
                       '<div class="col-md-6">' +
                       (product.imageUrl ? 
                           '<img src="' + product.imageUrl + '" class="img-responsive" style="width: 100%; border-radius: 8px;">' :
                           '<div style="height: 300px; background: linear-gradient(45deg, #3498db, #2980b9); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; border-radius: 8px;"><i class="fa fa-image"></i></div>'
                       ) +
                       '</div>' +
                       '<div class="col-md-6">' +
                       '<h3 style="color: #e74c3c;">¥' + parseFloat(product.price || 0).toFixed(2) + (product.weightUnit || '/份') + '</h3>' +
                       '<div style="margin-bottom: 15px;">' +
                       '<span class="stars" style="color: #f39c12; margin-right: 5px;">' + starsHtml + '</span>' +
                       '<span>' + rating.toFixed(1) + ' 分</span>' +
                       '</div>' +
                       '<p><strong>商品编码:</strong> ' + (product.productCode || '无') + '</p>' +
                       '<p><strong>产地:</strong> ' + (product.originPlace || '未知') + '</p>' +
                       '<p><strong>销量:</strong> ' + (product.salesCount || 0) + ' 件</p>' +
                       '<p><strong>库存:</strong> ' + (product.stock || 0) + ' 件</p>' +
                       '<p><strong>保质期:</strong> ' + (product.shelfLife || '未知') + ' 天</p>' +
                       '<p><strong>储存方式:</strong> ' + (product.storageMethod || '常温保存') + '</p>' +
                       '<p><strong>营养信息:</strong> ' + (product.nutritionInfo || '无') + '</p>' +
                       '<p><strong>商品描述:</strong> ' + (product.description || '暂无描述') + '</p>' +
                       '<div style="margin-top: 20px;">' +
                       '<div class="form-group" style="margin-bottom: 15px;">' +
                       '<label for="productQuantity"><strong>购买数量:</strong></label>' +
                       '<div class="input-group" style="width: 150px;">' +
                       '<span class="input-group-btn">' +
                       '<button class="btn btn-default" type="button" onclick="decreaseQuantity()"><i class="fa fa-minus"></i></button>' +
                       '</span>' +
                       '<input type="number" id="productQuantity" class="form-control text-center" value="1" min="1" max="' + (product.stock || 999) + '" style="width: 80px;">' +
                       '<span class="input-group-btn">' +
                       '<button class="btn btn-default" type="button" onclick="increaseQuantity(' + (product.stock || 999) + ')"><i class="fa fa-plus"></i></button>' +
                       '</span>' +
                       '</div>' +
                       '</div>' +
                       '<button class="btn btn-success btn-lg" onclick="addToCartWithQuantity(' + product.id + ');" style="margin-right: 10px;">' +
                       '<i class="fa fa-cart-plus"></i> 加入购物车' +
                       '</button>' +
                       '<button class="btn btn-danger btn-lg" onclick="buyNowWithQuantity(' + product.id + ')">' +
                       '<i class="fa fa-shopping-cart"></i> 立即购买' +
                       '</button>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>' +
                       '</div>';
        
        // 移除已存在的模态框
        $('#productDetailModal').remove();
        
        // 添加新的模态框并显示
        $('body').append(modalHtml);
        $('#productDetailModal').modal('show');
    },
    
    // 立即购买
    buyNow: function(productId, quantity) {
        quantity = quantity || 1; // 默认数量为1
        
        // 检查登录状态
        if (!window.isUserLoggedIn) {
            alert('请先登录后再购买商品');
            window.location.href = window.contextPath + '/login.jsp';
            return;
        }
        
        // 验证数量
        if (quantity < 1) {
            alert('购买数量不能小于1');
            return;
        }
        
        showLoading('正在处理订单...');
        $.ajax({
            url: window.contextPath+'/web/order/createOrder',
            type: 'POST',
            data: {
                productId: productId,
                quantity: quantity
            },
            success: function(response) {
                console.log('创建订单响应:', response);
                if (typeof hideLoading === 'function') {
                    hideLoading();
                }
                if (response.code === 0) {
                    alert('购买成功！订单号：' + response.data);
                } else {

                    alert('订单创建失败：' + response.msg);
                }
            },
            error: function(xhr, status, error) {
                if (typeof hideLoading === 'function') {
                    hideLoading();
                }
                console.error('创建订单出错:', error);
                alert('网络错误，请稍后重试');
            }
        });
    },
    
    // 添加分类卡片动画效果
    addCategoryCardAnimation: function() {
        $('.category-card').each(function(index) {
            $(this).delay(index * 100).animate({
                opacity: 1
            }, 500);
        });
    },
    
    // 滚动到顶部
    scrollToTop: function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    },
    
    // 显示错误消息
    showErrorMessage: function(message) {
        if (typeof showMessage === 'function') {
            showMessage(message, 'error');
        } else {
            alert(message);
        }
    },
    
    // 确保全局函数可用
    ensureGlobalFunctions: function() {
        // 如果全局函数不存在，创建简单的替代版本
        if (typeof window.showLoading !== 'function') {
            window.showLoading = function(message) {
                if (!$('#category-loading').length) {
                    $('body').append(
                        '<div id="category-loading" style="' +
                            'position: fixed; top: 0; left: 0; width: 100%; height: 100%;' +
                            'background: rgba(0,0,0,0.5); z-index: 9999; display: flex;' +
                            'align-items: center; justify-content: center; color: white;">' +
                            '<div style="text-align: center;">' +
                                '<i class="fa fa-spinner fa-spin fa-2x"></i>' +
                                '<div style="margin-top: 10px;">' + (message || '加载中...') + '</div>' +
                            '</div>' +
                        '</div>'
                    );
                } else {
                    $('#category-loading').show().find('div').last().text(message || '加载中...');
                }
            };
        }
        
        if (typeof window.hideLoading !== 'function') {
            window.hideLoading = function() {
                $('#category-loading').hide();
            };
        }
        
        if (typeof window.showMessage !== 'function') {
            window.showMessage = function(message, type) {
                if (type === 'success') {
                    alert('✓ ' + message);
                } else if (type === 'error') {
                    alert('✗ ' + message);
                } else {
                    alert(message);
                }
            };
        }
    }
};

// 页面加载完成后初始化
$(document).ready(function() {
    // 确保全局函数可用
    CategoryManager.ensureGlobalFunctions();
    
    // 初始化分类管理器
    CategoryManager.init();
});

// 全局函数，保持向后兼容
function showCategory(category) {
    CategoryManager.showCategory(category);
}

function addToCartFromCategory(productId) {
    CategoryManager.addToCart(productId);
}

function viewProductDetail(productId) {
    CategoryManager.viewProductDetail(productId);
}

function buyNow(productId) {
    CategoryManager.buyNow(productId);
}

// 数量控制函数
function increaseQuantity(maxStock) {
    var quantityInput = document.getElementById('productQuantity');
    var currentValue = parseInt(quantityInput.value) || 1;
    if (currentValue < maxStock) {
        quantityInput.value = currentValue + 1;
    }
}

function decreaseQuantity() {
    var quantityInput = document.getElementById('productQuantity');
    var currentValue = parseInt(quantityInput.value) || 1;
    if (currentValue > 1) {
        quantityInput.value = currentValue - 1;
    }
}

// 带数量的购物车和购买函数
function addToCartWithQuantity(productId) {
    var quantity = parseInt(document.getElementById('productQuantity').value) || 1;
    CategoryManager.addToCart(productId, quantity);
}

function buyNowWithQuantity(productId) {
    var quantity = parseInt(document.getElementById('productQuantity').value) || 1;
    CategoryManager.buyNow(productId, quantity);
}