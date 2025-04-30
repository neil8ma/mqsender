package com.cpit.mqsender;

/**
 * Copyright (c) 2024 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.mqsender
 * @ClassName MonRechargeProducer
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2024/12/11 12:21:47
 * @version: 1.0
 */
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageBuilder;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MonRechargeProducer {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void sendMessage(MonRechargeRecordDto dto) {
        // 设置消息头属性
        MessageProperties properties = new MessageProperties();
        properties.setHeader("chargerCode", dto.getChargerCode());
        properties.setHeader("cardId", dto.getCardId());
        properties.setHeader("startTime", dto.getStartTime());
        properties.setHeader("gunNum", dto.getGunNum());

        // 生成唯一标识
        String uniqueId = String.format("%s-%s-%s-%s",
                dto.getChargerCode(),
                dto.getCardId(),
                dto.getStartTime(),
                dto.getGunNum()
        );
        properties.setHeader("messageId", uniqueId);

        // 构建消息
        Message message = MessageBuilder
                .withBody(dto.toString().getBytes()) // 转换为字节数组
                .andProperties(properties)
                .build();

        // 发送消息
        rabbitTemplate.send("exchangeName", "routingKey", message);
    }
}

