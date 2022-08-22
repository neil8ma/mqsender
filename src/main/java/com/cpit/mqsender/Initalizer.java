package com.cpit.mqsender;

import com.cpit.dao.BillCacheMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Service;

/**
 * Copyright (c) 2020-2022 普天新能源有限责任公司. All rights reserved.
 *
 * @projectName: icp
 * @package: com.cpit.icp.bill.startup
 * @className: Initalizer
 * @author: 马明
 * @description: 工程启动数据初始化器
 * @create: 2022/6/7 18:30
 * @version: 1.0
 */
@Service
public class Initalizer implements ApplicationRunner {

    @Autowired
    BillCacheMapper billCacheMapper;

    @Override
    public void run(ApplicationArguments args){
        Data.allCard = billCacheMapper.getAllCard();
        System.gc();
    }
}
