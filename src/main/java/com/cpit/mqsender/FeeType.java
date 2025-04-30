package com.cpit.mqsender;

import java.util.HashMap;
import java.util.Map;

/**
 * Copyright (c) 2025 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.icp.nextbill.common
 * @ClassName FeeType
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2025/01/13 13:50:22
 * @version: 1.0
 */
public enum FeeType {
    ELE(1),   // 电费
    SVC(2),   // 服务费
    // 电费类型
    ELE_PEAK(11),
    ELE_FLAT(12),
    ELE_VALLEY(13),
    ELE_TOP(14),
    ELE_NO_TIME_SCENE(10),
    ELE_DEEP_VALLEY(15),
    ELE_EXT_FIRST(16),
    ELE_EXT_SECOND(17),
    ELE_EXT_THIRD(18),
    ELE_EXT_FOURTH(19),
    SVC_PEAK(21),
    SVC_FLAT(22),
    SVC_VALLEY(23),
    SVC_TOP(24),
    SVC_NO_TIME_SCENE(20),
    SVC_DEEP_VALLEY(25),
    SVC_EXT_FIRST(26),
    SVC_EXT_SECOND(27),
    SVC_EXT_THIRD(28),
    SVC_EXT_FOURTH(29),
    FEE_TYPE_DEDUCTED_AMOUNT_AFTER_USING_COUPON(30);

    // 根据时间场景ID和配置类型，获取对应的费用类型
    public static FeeType getBySceneTimeId(int sceneTimeId, int configType) {
        switch (sceneTimeId) {
            case 1:
                return (configType == 1) ?
                        ELE_PEAK : SVC_PEAK;
            case 2:
                return (configType == 1) ?
                        ELE_FLAT : SVC_FLAT;
            case 3:
                return (configType == 1) ?
                        ELE_VALLEY : SVC_VALLEY;
            case 4:
                return (configType == 1) ?
                        ELE_TOP : SVC_TOP;
            case 5:
                return (configType == 1) ?
                        ELE_DEEP_VALLEY : SVC_DEEP_VALLEY;
            case 6:
                return (configType == 1) ?
                        ELE_EXT_FIRST : SVC_EXT_FIRST;
            case 7:
                return (configType == 1) ?
                        ELE_EXT_SECOND : SVC_EXT_SECOND;
            case 8:
                return (configType == 1) ?
                        ELE_EXT_THIRD : SVC_EXT_THIRD;
            case 9:
                return (configType == 1) ?
                        ELE_EXT_FOURTH : SVC_EXT_FOURTH;
            default:
                return ELE_NO_TIME_SCENE; // 默认返回无时间场景
        }
    }
    private final int value;
    private static final Map<Integer, FeeType> VALUE_TO_FEE_TYPE_MAP = new HashMap<>(2);

    static {
        for (FeeType feeType : FeeType.values()) {
            VALUE_TO_FEE_TYPE_MAP.put(feeType.getValue(), feeType);
        }
    }

    FeeType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
    public static FeeType of(int value) {
        FeeType feeType = VALUE_TO_FEE_TYPE_MAP.get(value);
        if (feeType == null) {
            throw new IllegalArgumentException("Unexpected value: " + value);
        }
        return feeType;
    }

    public String withMsgId(String messageId) {
        return messageId + "RESULT:" + this.name();
    }

    public static void main(String[] args) {
        System.out.println(FeeType.ELE_DEEP_VALLEY.withMsgId("dfdsdfsdfsd"));
    }
}
