package com.cpit.mqsender;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class Data {
    public static List<String> allCard = new ArrayList<String>(0);
    public static List<String> allBatteryCharge = new ArrayList<String>(0);
}
