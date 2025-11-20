package com.cpit.mqsender;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.TimeInterval;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Set;

/**
 * Copyright (c) 2025 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.mqsender
 * @ClassName RedisTest
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2025/11/10 10:19:17
 * @version: 1.0
 */
@ShellComponent
public class RedisTest {
    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private RedisTemplate redisTemplate;
    @ShellMethod("测试redis")
    public void redis() {
        redisTemplate.opsForZSet().add("myzset", "member1", 0.5);
        redisTemplate.opsForZSet().add("myzset", "member2", 0.1);
        redisTemplate.opsForZSet().add("myzset", "member3", 0.8);
        redisTemplate.opsForZSet().add("myzset", "member4", 0.2);
        redisTemplate.opsForZSet().add("myzset", "member5", 0.6);
        redisTemplate.opsForZSet().add("myzset", "member6", 0.9);
        Set oks = redisTemplate.opsForZSet().reverseRangeByScore("myzset",0.0,0.56);
        TimeInterval timer = DateUtil.timer();
        Set ok = redisTemplate.opsForZSet().reverseRangeByScore("myzset",0.0,0.56,0,1);
        System.out.println(timer.interval()+"毫秒");
        System.out.println(new ArrayList<>(ok).get(0));
    }
}
