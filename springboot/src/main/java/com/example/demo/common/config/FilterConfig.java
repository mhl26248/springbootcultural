package com.example.demo.common.config;

import com.example.demo.common.XssFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * Filter配置
 */
@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean xssFilterRegistration() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(new XssFilter());
        registration.addUrlPatterns("/*");//过滤所有路径
        registration.setName("xssFilter");//过滤器名称
        registration.setOrder(Integer.MAX_VALUE);//优先级，越低越优先
        return registration;
    }
}
