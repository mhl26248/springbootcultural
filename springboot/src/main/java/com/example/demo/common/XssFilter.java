package com.example.demo.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


/**
 * xss过滤
 */
public class XssFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request =(HttpServletRequest)req;
        HttpServletResponse response =(HttpServletResponse)res;

        String contentType = request.getContentType();//获取contentType请求头
        String method = request.getMethod();//获取请求方法  post/get
        //1 处理get请求  get请求的Content-Type一般为application/x-www-form-urlencoded  或者  text/html
        if(method.trim().equalsIgnoreCase(HttpConst.GET_METHOD)){
            HttpServletRequestNormalWrapper wrapperRequest = new HttpServletRequestNormalWrapper(request);
            Map<String, String[]> parameterMap = wrapperRequest.getParameterMap();
            parameterMap =cleanXSSForNormalRequest(parameterMap);
            wrapperRequest.setParameterMap(parameterMap);
            chain.doFilter(wrapperRequest, response);
            return;
        }
        //2 处理post请求  只处理application/x-www-form-urlencoded  application/json,对于multipart/form-data，直接放行
        if(method.trim().equalsIgnoreCase(HttpConst.POST_METHOD)){
            if(contentType.trim().toLowerCase().contains(HttpConst.MULTIPART_CONTENT_TYPE)){
                chain.doFilter(request, response);
                return;
            }
            //处理application/x-www-form-urlencoded
            if(contentType.trim().toLowerCase().contains(HttpConst.FORM_URLENCODED_CONTENT_TYPE)){
                HttpServletRequestNormalWrapper wrapperRequest = new HttpServletRequestNormalWrapper(request);
                Map<String, String[]> parameterMap = wrapperRequest.getParameterMap();
                parameterMap =cleanXSSForNormalRequest(parameterMap);
                wrapperRequest.setParameterMap(parameterMap);
                chain.doFilter(wrapperRequest, response);
                return;
            }
            //处理application/json
            if(contentType.trim().toLowerCase().contains(HttpConst.JSON_CONTENT_TYPE)){
                HttpServletRequestBodyReaderWrapper requestWrapper = new HttpServletRequestBodyReaderWrapper(request);
                String body = requestWrapper.getBody();
                body =cleanXSSForPostJsonRequest(body);
                requestWrapper.setBody(body);
                chain.doFilter(requestWrapper, response);
                return;
            }
        }
        chain.doFilter(request, response);
        return;

    }

    public String cleanXSS(String value) {
        if(value==null||value.trim().isEmpty()){
            return null;
        }
        value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
        value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
        value = value.replaceAll("'", "& #39;");
        value = value.replaceAll("\"", "& #34;");
        value = value.replaceAll("`", "");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("script", "");
        return value;
    }

    /**
     * 普通的post/get请求
     * @param parameterMap
     */
    public Map<String,String[]> cleanXSSForNormalRequest(Map<String,String[]> parameterMap){
        Map<String,String[]> cleanMap = new HashMap<>();
        if(parameterMap==null||parameterMap.size()==0){
            return cleanMap;
        }
        for (Map.Entry<String,String[]> entry : parameterMap.entrySet()) {
            String key = entry.getKey();
            String[] value = entry.getValue();
            String cleanKey = cleanXSS(key);
            String[] cleanValue = null;
            if(value!=null&&value.length>0){
                cleanValue = new String[value.length];
                for(int i=0;i<value.length;i++){
                    cleanValue[i]=cleanXSS(value[i]);
                }
            }
            cleanMap.put(cleanKey,cleanValue);
        }
        //打印用
        StringBuffer printStr = new StringBuffer();
        for (Map.Entry<String,String[]> entry1 : cleanMap.entrySet()) {
            printStr.append(entry1.getKey()).append("=").append(Arrays.asList(entry1.getValue())).append("&");
        }
        System.out.println("XssFilter:发送的请求参数:"+JSON.toJSONString(printStr));
        return cleanMap;
    }

    /**
     * post的application/json请求
     * @param body
     */
    public String cleanXSSForPostJsonRequest(String body){
        String cleanBody = "{}";
        if(body==null||body.trim().isEmpty()||body.trim().equalsIgnoreCase("{}")||!body.trim().contains(":")){
            return cleanBody;
        }
        Map<String,Object> map = JSON.parseObject(body,new TypeReference<Map<String,Object>>(){});
        if(map==null||map.size()==0){
            return cleanBody;
        }
        Map<String,Object> cleanMap = new HashMap<>();
        for (Map.Entry<String,Object> entry : map.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            String valueStr = String.valueOf(value);
            if(valueStr==null||valueStr.trim().isEmpty()||valueStr.trim().equalsIgnoreCase("null")){
                valueStr = null;
            }
            cleanMap.put(cleanXSS(key),cleanXSS(valueStr));
        }
        cleanBody = JSON.toJSONString(cleanMap);
        System.out.println("XssFilter:发送的请求参数:"+cleanBody);
        return cleanBody;
    }


    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig arg0) {
    }

}
