package com.example.demo.entity;

import lombok.Data;

@Data
public class Email {
    private String[] user;
    private String subject;
    private String content;
}
