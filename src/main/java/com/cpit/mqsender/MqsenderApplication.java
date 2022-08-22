package com.cpit.mqsender;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = { "com.cpit" })
@MapperScan(basePackages = "com.cpit.dao", annotationClass = com.cpit.common.MyBatisDao.class)
public class MqsenderApplication {
    public static void main(String[] args) {
        SpringApplication.run(MqsenderApplication.class, args);
    }

}
