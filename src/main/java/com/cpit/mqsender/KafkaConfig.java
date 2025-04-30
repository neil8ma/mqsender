package com.cpit.mqsender;

/**
 * Copyright (c) 2025 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.mqsender
 * @ClassName KafkaConfig
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2025/03/11 10:10:02
 * @version: 1.0
 */
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import org.apache.kafka.clients.admin.AdminClientConfig;
import org.apache.kafka.clients.admin.NewTopic;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;
import org.springframework.kafka.support.serializer.JsonSerializer;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class KafkaConfig {
    @Value("${spring.kafka.bootstrap-servers}")
    private String bootstrapServers;

    @Bean
    public KafkaAdmin kafkaAdmin() {
        return new KafkaAdmin(new HashMap<String, Object>() {{
            put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        }});
    }

    @Bean
    public NewTopic myTopic() {
        return new NewTopic("my-topic", 3, (short) 1); // 主题名、分区数、副本数
    }

    @Bean
    public ProducerFactory<String, MonRechargeRecordDto> producerFactory() {
        Map<String, Object> configProps = new HashMap<>();
        configProps.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        configProps.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        configProps.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, JsonSerializer.class);
        return new DefaultKafkaProducerFactory<>(configProps);
    }

    @Bean
    public KafkaTemplate<String, MonRechargeRecordDto> kafkaTemplate() {
        return new KafkaTemplate<>(producerFactory());
    }
}
