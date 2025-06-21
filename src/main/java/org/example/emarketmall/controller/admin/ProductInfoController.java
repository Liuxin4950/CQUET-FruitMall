package org.example.emarketmall.controller.admin;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.entity.ProductInfo;
import org.example.emarketmall.entity.StaffInfo;
import org.example.emarketmall.service.ProductInfoService;
import org.example.emarketmall.service.impl.ProductInfoServiceImpl;
import org.example.emarketmall.utils.BeanUtils;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Description: 商品信息控制器
 * @author: april
 * @date: 2022年06月13日 18:33
 */
@WebServlet("/mall/product")
public class ProductInfoController extends HttpServlet {
    private ProductInfoService productInfoService = new ProductInfoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    private void doProcessRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String referer = req.getHeader("Referer");
        if (referer != null && referer.contains("index")) {
            resp.sendRedirect("/admin/product.jsp");
            return;
        }
        
        String opt = req.getParameter("opt");
        //id可能为null
        String id = req.getParameter("id");
        String ids = req.getParameter("ids");
        System.out.println("opt: " + opt + ", id: " + id + ", ids: " + ids);

        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }

        ProductInfo productInfo = null;
        
        // 添加调试信息
        System.out.println("Content-Type: " + req.getContentType());
        System.out.println("Request Method: " + req.getMethod());
        
        productInfo = ServletUtils.getObjectFromPayload(req, ProductInfo.class);
        System.out.println("productInfo: " + productInfo);
        // 修复BeanUtils.isEmpty的逻辑错误，直接检查对象是否为null
        if (productInfo == null) {
            productInfo = null;
        }

        try {
            switch (opt) {
                case "add":
                    // 跳转到add.jsp页面或处理新增请求
                    if ("GET".equalsIgnoreCase(req.getMethod())) {
                        resp.sendRedirect("/admin/product/add.jsp");
                        return;
                    }
                    if ("POST".equalsIgnoreCase(req.getMethod())) {
                        if (productInfo != null) {
                            ServletUtils.renderString(resp, JSON.toJSONString(addProduct(productInfo)));
                        } else {
                            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("新增商品信息对象内容异常")));
                        }
                    }
                    break;
                case "edit":
                    // 处理编辑请求
                    if ("GET".equalsIgnoreCase(req.getMethod())) {
                        if (StringUtils.isEmpty(id)) {
                            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑ID内容异常")));
                            return;
                        } else {
                            ProductInfo product = productInfoService.selectProductInfoById(Integer.parseInt(id));
                            req.setAttribute("product", product);
                            req.getRequestDispatcher("/admin/product/edit.jsp").forward(req, resp);
                            return;
                        }
                    }
                    if ("POST".equalsIgnoreCase(req.getMethod())) {
                        if (productInfo != null) {
                            ServletUtils.renderString(resp, JSON.toJSONString(editProduct(id, productInfo, req)));
                        } else {
                            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑商品信息对象内容异常")));
                        }
                    }
                    break;
                case "remove":
                    if (StringUtils.isNotEmpty(ids)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(removeProducts(ids)));
                    } else if (StringUtils.isNotEmpty(id)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(removeProduct(id)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("删除ID内容异常")));
                    }
                    break;
                case "list":
                    ServletUtils.renderString(resp, JSON.toJSONString(list(productInfo) != null ? list(productInfo) : AjaxResult.error("商品信息查询异常")));
                    break;
                case "detail":
                    if (StringUtils.isEmpty(id)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("详情ID内容异常")));
                        return;
                    } else {
                        ProductInfo product = productInfoService.selectProductInfoById(Integer.parseInt(id));
                        req.setAttribute("product", product);
                        req.getRequestDispatcher("/admin/product/detail.jsp").forward(req, resp);
                        return;
                    }
                case "updateStatus":
                    System.out.println("productInfo: " + productInfo);
                    if (productInfo != null && productInfo.getId() != null && productInfo.getPublishStatus() != null) {
                        String publishStatus = String.valueOf(productInfo.getPublishStatus());
                        String statusId = String.valueOf(productInfo.getId());
                        ServletUtils.renderString(resp, JSON.toJSONString(updateProductStatus(statusId, publishStatus)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数不完整")));
                    }
                    break;
                case "updateStock":
                    String stock = req.getParameter("stock");
                    ServletUtils.renderString(resp, JSON.toJSONString(updateProductStock(id, stock)));
                    break;
                default:
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常：" + e.getMessage())));
        }
    }

    /**
     * 新增商品
     */
    private AjaxResult addProduct(ProductInfo productInfo) {
        try {
            if (productInfo != null) {
                // 设置创建时间和更新时间

                
                if (productInfoService.insertProductInfo(productInfo) > 0) {
                    return AjaxResult.success("新增商品信息成功");
                }
            }
            return AjaxResult.error("新增商品信息失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("新增商品信息异常：" + e.getMessage());
        }
    }

    /**
     * 修改商品
     */
    private AjaxResult editProduct(String id, ProductInfo productInfo, HttpServletRequest req) {
        try {
            if (StringUtils.isNotEmpty(id) && productInfo != null) {
                // 获取当前登录的管理员信息
                StaffInfo staffInfo = (StaffInfo) req.getSession().getAttribute("staffInfo");
                String currentAdmin = staffInfo != null ? staffInfo.getLoginName() : "system";
                
                ProductInfo destProduct = productInfoService.selectProductInfoById(Integer.parseInt(id));
                if (destProduct != null) {
                    // 更新商品信息
                    destProduct.setProductName(productInfo.getProductName());
                    destProduct.setOneCategoryId(productInfo.getOneCategoryId());
                    destProduct.setTwoCategoryId(productInfo.getTwoCategoryId());
                    destProduct.setPrice(productInfo.getPrice());
                    destProduct.setPublishStatus(productInfo.getPublishStatus());
                    destProduct.setProductionDate(productInfo.getProductionDate());
                    destProduct.setShelfLife(productInfo.getShelfLife());
                    destProduct.setDescription(productInfo.getDescription());
                    destProduct.setOriginPlace(productInfo.getOriginPlace());
                    destProduct.setStorageMethod(productInfo.getStorageMethod());
                    destProduct.setNutritionInfo(productInfo.getNutritionInfo());
                    destProduct.setWeightUnit(productInfo.getWeightUnit());
                    destProduct.setIsOrganic(productInfo.getIsOrganic());
                    destProduct.setIsSeasonal(productInfo.getIsSeasonal());
                    destProduct.setDiscountPrice(productInfo.getDiscountPrice());
                    destProduct.setStock(productInfo.getStock());
                    destProduct.setUpdatedTime(DateUtils.getTime());
                    
                    // 调用带更新人参数的方法
                    if (productInfoService.updateProductInfo(destProduct, currentAdmin) > 0) {
                        return AjaxResult.success("修改商品信息成功");
                    }
                }
            }
            return AjaxResult.error("修改商品信息失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("修改商品信息异常：" + e.getMessage());
        }
    }

    /**
     * 删除单个商品
     */
    private AjaxResult removeProduct(String id) {
        try {
            if (StringUtils.isNotEmpty(id)) {
                if (productInfoService.deleteProductInfoById(Integer.parseInt(id)) > 0) {
                    return AjaxResult.success("删除商品信息成功");
                }
            }
            return AjaxResult.error("删除商品信息失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("删除商品信息异常：" + e.getMessage());
        }
    }

    /**
     * 批量删除商品
     */
    private AjaxResult removeProducts(String ids) {
        try {
            if (StringUtils.isNotEmpty(ids)) {
                String[] idArray = ids.split(",");
                Integer[] idIntArray = new Integer[idArray.length];
                for (int i = 0; i < idArray.length; i++) {
                    idIntArray[i] = Integer.parseInt(idArray[i].trim());
                }
                
                if (productInfoService.deleteProductInfoByIds(idIntArray) > 0) {
                    return AjaxResult.success("批量删除商品信息成功");
                }
            }
            return AjaxResult.error("批量删除商品信息失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("批量删除商品信息异常：" + e.getMessage());
        }
    }

    /**
     * 更新商品发布状态
     */
    private AjaxResult updateProductStatus(String id, String publishStatus) {
        try {
            if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(publishStatus)) {
                if (productInfoService.updateProductStatus(Integer.parseInt(id), Integer.parseInt(publishStatus)) > 0) {
                    return AjaxResult.success("更新商品状态成功");
                }
            }
            return AjaxResult.error("更新商品状态失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("更新商品状态异常：" + e.getMessage());
        }
    }

    /**
     * 更新商品库存
     */
    private AjaxResult updateProductStock(String id, String stock) {
        try {
            if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(stock)) {
                if (productInfoService.updateProductStock(Integer.parseInt(id), Integer.parseInt(stock)) > 0) {
                    return AjaxResult.success("更新商品库存成功");
                }
            }
            return AjaxResult.error("更商品库存失败");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("更新商品库存异常：" + e.getMessage());
        }
    }

    /**
     * 查询商品列表
     */
    private TableDataInfo list(ProductInfo productInfo) {
        System.out.println("查询参数: " + productInfo);
        try {
            List<ProductInfo> productInfoList = productInfoService.selectProductInfoList(productInfo);
            if (productInfoList != null) {
//                // 添加调试信息
//                System.out.println("查询到的商品数量: " + productInfoList.size());
//                if (!productInfoList.isEmpty()) {
//                    ProductInfo firstProduct = productInfoList.get(0);
//                    System.out.println("第一个商品信息:");
//                    System.out.println("ID: " + firstProduct.getId());
//                    System.out.println("商品名称: " + firstProduct.getProductName());
//                    System.out.println("商品编码: " + firstProduct.getProductCode());
//                    System.out.println("价格: " + firstProduct.getPrice());
//                    System.out.println("库存: " + firstProduct.getStock());
//                    System.out.println("描述: " + firstProduct.getDescription());
//                    System.out.println("JSON序列化结果: " + JSON.toJSONString(firstProduct));
//                }
                return TableDataInfo.getDataTable(productInfoList);
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
