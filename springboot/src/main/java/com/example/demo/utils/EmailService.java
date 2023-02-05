package com.example.demo.utils;

import com.example.demo.entity.Email;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class EmailService {
    @Resource
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String senderName;

    public void sendMail(Email email){
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(senderName);
        // 邮件接收人
        mailMessage.setTo(email.getUser());
        // 邮件主题
        mailMessage.setSubject(email.getSubject());
        // 邮件内容
        mailMessage.setText(email.getContent());
        mailSender.send(mailMessage);
    }
}
