package com.cpit.mqsender;

/**
 * Copyright (c) 2025 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.mqsender
 * @ClassName TaskExecutePool
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2025/06/13 15:50:32
 * @version: 1.0
 */

import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@Configuration
public class TaskExecutePool {

    @Bean(name ="threadPoolA")

    public ThreadPoolTaskExecutor myTaskAsyncPool() {

        ThreadPoolTaskExecutor executor =new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(4);

        executor.setMaxPoolSize(8);

        executor.setQueueCapacity(100);

        executor.setKeepAliveSeconds(60);

        executor.setThreadNamePrefix("Pool-A");

        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());

        executor.initialize();

        return executor;

    }
}

