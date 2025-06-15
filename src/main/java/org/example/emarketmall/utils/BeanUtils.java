package org.example.emarketmall.utils;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Bean 工具类
 */
public class BeanUtils extends org.apache.commons.beanutils.BeanUtils {
    /**
     * Bean方法名中属性名开始的下标
     */
    private static final int BEAN_METHOD_PROP_INDEX = 3;

    /**
     * 匹配getter方法的正则表达式
     */
    private static final Pattern GET_PATTERN = Pattern.compile("get(\\p{javaUpperCase}\\w*)");

    /**
     * 匹配setter方法的正则表达式
     */
    private static final Pattern SET_PATTERN = Pattern.compile("set(\\p{javaUpperCase}\\w*)");

    /**
     * Bean属性复制工具方法。
     *
     * @param dest 目标对象
     * @param src  源对象
     */
    public static void copyBeanProp(Object dest, Object src) {
        try {
            copyProperties(src, dest);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 把map的内容拷贝给Java对象
     *
     * @param src
     * @param target
     * @param <T>
     * @return
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public static <T> T copyMap2Object(Map src, Class<T> target) throws IllegalAccessException, InstantiationException {
        Class<?> clazz = target;
        Field[] fields = new Field[0];
        while (clazz != Object.class) {
            fields = ArrayUtils.addAll(fields, clazz.getDeclaredFields());
            clazz = clazz.getSuperclass();
        }
        T ret = target.newInstance();
        for (Field field : fields) {
            Object value ;
            if ((value = src.get(field.getName())) != null) {
//                field.setAccessible(true);
//                field.set(ret, value);
                //设置对象的访问权限，保证对private的属性的访问
                field.setAccessible(true);
                field.set(ret, convert(value, field.getType()));
            }
        }
        return ret;
    }

    /**
     * 判断Bean是否只被实例化，未被赋值
     *
     * @param obj
     * @param <T>
     * @return
     */
    public static <T> boolean isEmpty(T obj) {
        if (obj == null) {
            return true;
        }
        List<String> props = getBeanProperties(obj);
        int count = 0;
        for (String prop : props) {
            if (StringUtils.isEmpty(getFieldValueByName(prop, obj))) {
                count++;
            }
        }
        //排除delFlag属性
        return count >= props.size() - 1;
    }

    /**
     * 获取对象的setter方法。
     *
     * @param obj 对象
     * @return 对象的setter方法列表
     */
    public static List<Method> getSetterMethods(Object obj) {
        // setter方法列表
        List<Method> setterMethods = new ArrayList<Method>();

        // 获取所有方法
        Method[] methods = obj.getClass().getMethods();

        // 查找setter方法

        for (Method method : methods) {
            Matcher m = SET_PATTERN.matcher(method.getName());
            if (m.matches() && (method.getParameterTypes().length == 1)) {
                setterMethods.add(method);
            }
        }
        // 返回setter方法列表
        return setterMethods;
    }

    /**
     * 获取对象的getter方法。
     *
     * @param obj 对象
     * @return 对象的getter方法列表
     */

    public static List<Method> getGetterMethods(Object obj) {
        // getter方法列表
        List<Method> getterMethods = new ArrayList<Method>();
        // 获取所有方法
        Method[] methods = obj.getClass().getMethods();
        // 查找getter方法
        for (Method method : methods) {
            Matcher m = GET_PATTERN.matcher(method.getName());
            if (m.matches() && (method.getParameterTypes().length == 0)) {
                getterMethods.add(method);
            }
        }
        // 返回getter方法列表
        return getterMethods;
    }

    /**
     * 检查Bean方法名中的属性名是否相等。<br>
     * 如getName()和setName()属性名一样，getName()和setAge()属性名不一样。
     *
     * @param m1 方法名1
     * @param m2 方法名2
     * @return 属性名一样返回true，否则返回false
     */

    public static boolean isMethodPropEquals(String m1, String m2) {
        return m1.substring(BEAN_METHOD_PROP_INDEX).equals(m2.substring(BEAN_METHOD_PROP_INDEX));
    }

    /**
     * 返回对象的属性名
     *
     * @param obj
     * @return
     */
    public static List<String> getBeanProperties(Object obj) {
        List<Method> methods = getGetterMethods(obj);
        List<String> properties = new ArrayList<>(methods.size());
        String prop = "";
        String firstLetter = "";
        for (Method method : methods) {
            prop = method.getName().substring(BEAN_METHOD_PROP_INDEX);
            firstLetter = prop.substring(0, 1);
            prop = prop.replaceFirst(firstLetter, firstLetter.toLowerCase());
            properties.add(prop);
        }
        return properties;
    }

    /**
     * 根据属性名获取属性元素，包括各种安全范围和所有父类
     *
     * @param fieldName 属性名
     * @param object    属性所属类
     * @return 属性值
     */
    public static String getFieldValueByName(String fieldName, Object object) {
        String ret = null;
        try {
            ret = PropertyUtils.getProperty(object, fieldName).toString();
        } catch (Exception e) {

        }
        return ret;

    }

    /**
     * Field类型转换
     */
    private static <T> T convert(Object obj, Class<T> type) {
        if (type.equals(Integer.class)) {
            return (T) (StringUtils.isEmpty(obj.toString())?null:new Integer(obj.toString()));
        } else if (type.equals(Long.class)) {
            return (T) (StringUtils.isEmpty(obj.toString())?null:new Long(obj.toString()));
        } else if (type.equals(Float.class)) {
            return (T) (StringUtils.isEmpty(obj.toString())?null:new Float(obj.toString()));
        } else if (type.equals(Double.class)) {
            return (T) (StringUtils.isEmpty(obj.toString())?null:new Double(obj.toString()));
        } else if (type.equals(BigDecimal.class)) {
            return (T) (StringUtils.isEmpty(obj.toString())?null:new BigDecimal(obj.toString()));
        } else{
            return (T) obj.toString();
        }
    }

}
