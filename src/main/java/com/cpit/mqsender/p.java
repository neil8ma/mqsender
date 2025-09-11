package com.cpit.mqsender;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import java.math.BigDecimal;

public abstract class p {
    protected final static Logger logger = LoggerFactory.getLogger(p.class);
    @Autowired
    RedisTemplate redisTemplate;
    public abstract void ok();

    public void dxx(){
        BigDecimal ok = (BigDecimal)redisTemplate.opsForValue().get("sdfsdfsd");
    }
}
