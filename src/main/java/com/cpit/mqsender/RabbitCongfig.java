package com.cpit.mqsender;

/**
 * 项目名：新能源智能云平台
 * 包名：com.cpit.icp.billing.impl.grantprice.main
 * 文件名：RabbitCongfig.java
 * 版本信息：1.0.0
 * 日期：2018年10月24日
 * Copyright (c) 2018普天信息技术有限公司-版权所有
 */
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.config.SimpleRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.amqp.SimpleRabbitListenerContainerFactoryConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 类名称：RabbitCongfig
 * 类描述：
 * 创建人：maming
 * 创建时间：2018年10月24日 上午10:58:34
 * 修改人： 修改时间：
 * 修改备注：
 *
 * @version 1.0.0
 */
@Configuration
public class RabbitCongfig {

    private final static Logger logger = LoggerFactory.getLogger(RabbitCongfig.class);

//    @Value("${spring.rabbitmq.listener.simple.concurrency}")
    private String concurrency = "1";

    @Bean
    public Queue Queue() {
        return new Queue("dealMsg");
    }

    @Bean
    public Queue reBillQueue() {
        return new Queue("reBill");
    }

    @Bean
    public Queue replyBillMsgQueue() {
        return new Queue("replyBillMsg");
    }

    @Bean
    public Queue insertBillMsgQueue() {
        return new Queue("insertBillMsg");
    }

    @Bean("BillTaskContainerFactory")
    public SimpleRabbitListenerContainerFactory pointTaskContainerFactory(SimpleRabbitListenerContainerFactoryConfigurer configurer, ConnectionFactory connectionFactory) {
        SimpleRabbitListenerContainerFactory factory = new SimpleRabbitListenerContainerFactory();
        factory.setPrefetchCount(1);
        factory.setConcurrentConsumers(Integer.valueOf(concurrency));
        configurer.configure(factory, connectionFactory);
        return factory;
    }
}

