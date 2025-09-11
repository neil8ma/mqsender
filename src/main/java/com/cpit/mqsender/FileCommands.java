package com.cpit.mqsender;

/**
 * Copyright (c) 2025 中石油昆仑网联电能科技有限公司. All rights reserved.
 *
 * @projectName: icp
 * @PackageName com.cpit.mqsender
 * @ClassName FileCommands
 * @author: 马明
 * @Description TODO: 类描述
 * @create 2025/02/10 15:14:42
 * @version: 1.0
 */
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import com.cpit.icp.dto.collect.MonRechargeRecordProcessDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

@ShellComponent
public class FileCommands {
    private final static Logger logger = LoggerFactory.getLogger(FileCommands.class);

    @Autowired
    Sender sender;
    @Autowired
    ThreadPoolWork threadPoolWork;
    private static final Pattern PROCESS_PATTERN = Pattern.compile("MonRechargeRecordProcessDto \\[(.*?)\\]]");
    private static final Pattern SETTLE_PATTERN = Pattern.compile("MonRechargeRecordDto \\[(.*?)\\]]");

    List<MonRechargeRecordProcessDto> processDtos = new ArrayList<>();
    List<MonRechargeRecordDto> settleDtos = new ArrayList<>();



    public static void main(String[] args) throws IOException {
        String filePath = "gcxx.txt";
        List<MonRechargeRecordProcessDto> processDtos = new ArrayList<>();
        List<MonRechargeRecordDto> settleDtos = new ArrayList<>();

        // 读取日志文件
        List<String> lines = Files.readAllLines(Paths.get(filePath));

        for (String line : lines) {
            Matcher processMatcher = PROCESS_PATTERN.matcher(line);
            Matcher settleMatcher = SETTLE_PATTERN.matcher(line);

            if (processMatcher.find()) {
                processDtos.add(parseProcessDto(processMatcher.group(1)));
            } else if (settleMatcher.find()) {
                settleDtos.add(parseSettleDto(settleMatcher.group(1)));
            }
        }

        // 使用 Jackson 输出 JSON
        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println("过程消息 DTOs:");
        System.out.println(objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(processDtos));

        System.out.println("\n结算消息 DTOs:");
        System.out.println(objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(settleDtos));
    }
    @ShellMethod("由初始化")
    public void sxx() throws IOException{
        String filePath = "c:\\gcxx2.txt";
        // 读取日志文件
        List<String> lines = Files.readAllLines(Paths.get(filePath));

        for (String line : lines) {
            Matcher processMatcher = PROCESS_PATTERN.matcher(line);
            Matcher settleMatcher = SETTLE_PATTERN.matcher(line);

            if (processMatcher.find()) {
                processDtos = new ArrayList<>();
                processDtos.add(parseProcessDto(processMatcher.group(1)));
            } else if (settleMatcher.find()) {
                settleDtos = new ArrayList<>();
                settleDtos.add(parseSettleDto(settleMatcher.group(1)));
            }
        }
    }

    @ShellMethod("由文件发消息")
    public void sxxx(int i) throws IOException{

        sender.sendprocess(processDtos.get(i-1));
        sender.send79process(settleDtos);
    }

    @ShellMethod("由文件发过程消息")
    public void gcxx(int i) throws IOException{
        sxx();
        for(int k= 0;k< 1000;k++)
        sender.sendprocess(processDtos.get(0));
    }

    @ShellMethod("由文件发消息")
    public void k() throws IOException{
        sxx();
//        for (int i = 0;i<processDtos.size();i++)
//            sender.sendprocess(processDtos.get(i));
        sender.send79kafka(settleDtos);
//        sender.send79process(settleDtos);
    }

    @ShellMethod("测试线程")
    public void csxc() throws IOException{
        threadPoolWork.doWork(new Runnable() {
            @Override
            public void run() {
                logger.info("睡眠1分钟");
                try {
                    Thread.sleep(1000*60);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                logger.info("睡眠结束");
            }
        });
    }

    @ShellMethod("由文件发消息sdfsdf")
    public void sxxxallp() throws IOException{
        for (int i = 0;i<processDtos.size();i++)
            sender.sendprocess(processDtos.get(i));
        sender.send79process(settleDtos);
    }
    @ShellMethod("发送kafka")
    public void kafka() throws IOException{
        sender.kafkaSend();
    }
    @ShellMethod("由文件发消息sdfsdsdfd")
    public void sxxxallj() throws IOException{
        sender.send79process(settleDtos);
    }

    @ShellMethod("由文件发消息")
    public void msg() throws IOException{
        sender.sendOfferMsg();
    }

    private static MonRechargeRecordProcessDto parseProcessDto(String rawData) {
        Map<String, String> fields = parseFields(rawData);
        MonRechargeRecordProcessDto dto = new MonRechargeRecordProcessDto();
        dto.setDeviceNo(fields.get("deviceNo"));
        dto.setRechargeType(fields.get("rechargeType"));
        dto.setGunNum(fields.get("gunNum"));
        dto.setCardId(fields.get("cardId"));
        dto.setAccumulatedKwh(fields.get("accumulatedKwh"));
        dto.setAccumulatedAh(fields.get("accumulatedAh"));
        dto.setStartSOC(fields.get("startSOC"));
        dto.setCurrentSOC(fields.get("currentSOC"));
        dto.setAmmeterKwh(fields.get("ammeterKwh"));
        dto.setAccumulatedMinutes(fields.get("accumulatedMinutes"));
        dto.setStartTime(fields.get("startTime"));
        dto.setCurrentTime(fields.get("currentTime"));
        dto.setFlowNumber(fields.get("flowNumber"));
        return dto;
    }

    private static MonRechargeRecordDto parseSettleDto(String rawData) {
        Map<String, String> fields = parseFields(rawData);
        MonRechargeRecordDto dto = new MonRechargeRecordDto();
        dto.setDeviceNo(fields.get("deviceNo"));
        dto.setVer(fields.get("ver"));
        dto.setRechargeType(fields.get("rechargeType"));
        dto.setRechargeType34a(fields.get("rechargeType34a"));
        dto.setCardId(fields.get("cardId"));
        dto.setChargerCode(fields.get("chargerCode"));
        dto.setVin(fields.get("vin"));
        dto.setPlateNumber(fields.get("plateNumber").trim());
        dto.setStartSoc(fields.get("startSoc"));
        dto.setEndSoc(fields.get("endSoc"));
        dto.setAh(fields.get("ah"));
        dto.setKwh(fields.get("kwh"));
        dto.setChargeTime(fields.get("chargeTime"));
        dto.setNormalEnd(fields.get("normalEnd"));
        dto.setStartTime(fields.get("startTime"));
        dto.setTraceTime(fields.get("traceTime"));
        dto.setEndTime(fields.get("endTime"));
        dto.setStartKwh(fields.get("startKwh"));
        dto.setEndKwh(fields.get("endKwh"));
        dto.setPlatTransFlowNum(fields.get("platTransFlowNum"));
        dto.setChargeSource(fields.get("chargeSource"));
        dto.setGunNum(fields.get("gunNum"));
        dto.setMsgCode(fields.get("msgCode"));
        dto.setIsLateDeductionFee(fields.get("isLateDeductionFee"));
        dto.setIsComplementaryBuckle(fields.get("isComplementaryBuckle"));
        dto.setRebill(Boolean.parseBoolean(fields.get("isRebill")));
        dto.setInQuTime(fields.get("inQuTime"));
        return dto;
    }

    private static Map<String, String> parseFields(String rawData) {
        Map<String, String> fields = new HashMap<>();
        String[] pairs = rawData.split(", ");
        for (String pair : pairs) {
            String[] keyValue = pair.split("=", 2);
            fields.put(keyValue[0], keyValue.length > 1 ? keyValue[1] : null);
        }
        return fields;
    }

    private static Integer parseNullableInt(String value) {
        return (value == null || "null".equals(value)) ? null : Integer.parseInt(value);
    }

    private static Double parseNullableDouble(String value) {
        return (value == null || "null".equals(value)) ? null : Double.parseDouble(value);
    }
}

