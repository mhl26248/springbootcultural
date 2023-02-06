package com.example.demo.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

/**
 * 适用于普通get post请求  不包含multipart/form-data   application/json等请求
 * 缓存请求参数   重写获取参数的方法
 */
public class HttpServletRequestNormalWrapper extends HttpServletRequestWrapper {

    private Map<String, String[]> parameterMap = new HashMap<>(); // 所有参数的Map集合

    public HttpServletRequestNormalWrapper(HttpServletRequest request){
        super(request);
        Enumeration params = request.getParameterNames();//获得所有请求参数名
        StringBuffer paramsValue = new StringBuffer("");
        while (params.hasMoreElements()) {
            String name = params.nextElement().toString(); //得到参数名
            String[] value = request.getParameterValues(name);//得到参数对应值
            parameterMap.put(name,value);
        }
    }

    /**
     * 获取所有参数名
     *
     * @return 返回所有参数名
     */
    @Override
    public Enumeration<String> getParameterNames() {
        Vector<String> vector = new Vector<String>(parameterMap.keySet());
        return vector.elements();
    }

    /**
     * 获取指定参数名的值，如果有重复的参数名，则返回第一个的值 接收一般变量 ，如text类型
     *
     * @param name 指定参数名
     * @return 指定参数名的值
     */
    @Override
    public String getParameter(String name) {
        String[] values = parameterMap.get(name);
        if(values==null||values.length==0){
            return null;
        }
        return values[0];
        //如果有多个参数值的，请放开该注释  我这里没有做这么细致
        /*StringBuffer sb = new StringBuffer();
        for(int i=0;i<values.length;i++){
            if(i==values.length-1){
                sb.append(values[i]);
            }else{
                sb.append(values[i]).append(",");
            }
        }
        return sb.toString();*/
    }
    /**
     * 获取指定参数名的所有值的数组，如：checkbox的所有数据
     * 接收数组变量 ，如checkobx类型
     */
    @Override
    public String[] getParameterValues(String name) {
        return parameterMap.get(name);
    }

    @Override
    public Map<String, String[]> getParameterMap() {
        return parameterMap;
    }

    public void setParameterMap(Map<String, String[]> parameterMap) {
        this.parameterMap = parameterMap;
    }
}
