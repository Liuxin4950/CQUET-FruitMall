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
            'citrus': { id: '1', name: '🍊 柑橘类' },
            'berry': { id: '2', name: '🍓 浆果类' },
            'tropical': { id: '3', name: '🥭 热带水果' },
            'stone': { id: '1', name: '🍑 核果类' },
            'melon': { id: '1', name: '🍉 瓜果类' },
            'all': { id: '', name: '🍎 全部分类' }
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
        currentCategory: 'citrus',
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
        
        if (categoryId) {
            // 根据categoryId找到对应的分类
            var category = this.findCategoryById(categoryId);
            this.showCategory(category);
        } else {
            // 默认显示柑橘类
            this.showCategory('citrus');
        }
    },
    
    // 根据ID查找分类
    findCategoryById: function(categoryId) {
        for (var key in this.config.categoryMap) {
            if (this.config.categoryMap[key].id === categoryId) {
                return key;
            }
        }
        return 'citrus'; // 默认返回柑橘类
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
        // 如果已经加载过该分类的数据，直接返回
        if (this.state.categoryProducts[category]) {
            return;
        }
        
        if (this.state.isLoading) {
            return;
        }
        
        this.state.isLoading = true;
        showLoading('正在加载商品数据...');
        
        var categoryId = this.config.categoryMap[category].id;
        var self = this;
        
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
                
                if (response.code === 0) {
                    var products = response.data.records || response.data || [];
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
        return '<div class="fruit-card" data-product-id="' + product.id + '">' +
            '<div class="fruit-image" style="background: linear-gradient(45deg, #27ae60, #2ecc71);">' +
            (product.sales > 100 ? '<div class="fruit-badge">热销</div>' : '') +
            '<i class="fa ' + icon + '" style="color: white;"></i>' +
            '</div>' +
            '<div class="fruit-info">' +
            '<div class="fruit-name">' + (product.productName || '商品名称') + '</div>' +
            '<div class="fruit-desc">' + (product.description || '新鲜美味，营养丰富') + '</div>' +
            '<div class="fruit-features">' + featuresHtml + '</div>' +
            '<div class="fruit-price">' +
            '<span class="price-current">¥' + (product.price || 0).toFixed(2) + '</span>' +
            '<span class="price-unit">/份</span>' +
            '</div>' +
            '<div class="fruit-actions">' +
            '<button class="btn btn-add-cart" onclick="CategoryManager.addToCart(' + product.id + ')">' +
            '<i class="fa fa-cart-plus"></i> 加入购物车' +
            '</button>' +
            '<button class="btn btn-quick-view" onclick="CategoryManager.viewProductDetail(' + product.id + ')">' +
            '<i class="fa fa-eye"></i>' +
            '</button>' +
            '</div>' +
            '</div>' +
            '</div>';
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
    addToCart: function(productId) {
        // 检查登录状态
        if (!window.isUserLoggedIn) {
            alert('请先登录后再购买商品');
            window.location.href = window.contextPath + '/login.jsp';
            return;
        }
        
        showLoading('正在添加到购物车...');
        
        $.ajax({
            url: window.contextPath + '/web/cart/add',
            type: 'POST',
            data: {
                productId: productId,
                quantity: 1
            },
            dataType: 'json',
            success: function(response) {
                hideLoading();
                if (response.code === 0) {
                    showMessage('商品已成功加入购物车！', 'success');
                } else {
                    showMessage(response.msg || '添加购物车失败', 'error');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('添加购物车失败:', error);
                showMessage('网络错误，请稍后重试', 'error');
            }
        });
    },
    
    // 查看商品详情
    viewProductDetail: function(productId) {
        window.location.href = window.contextPath + '/web/product-detail.jsp?id=' + productId;
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