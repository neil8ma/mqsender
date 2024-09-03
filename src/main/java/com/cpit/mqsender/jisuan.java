package com.cpit.mqsender;

import java.util.HashMap;

public class jisuan {
    //人员数据集合，假设已经从数据库加载到data里，无关属性不关心
    HashMap<String,person> data = new HashMap<>();
    ResultP result = null;
    //结果类
    class ResultP{
        public ResultP(String id,String name,int level){
            this.id = id;
            this.name = name;
            this.level = level;
        }
        public String id;
        public String name;
        public int level;//级别
    }
    class person{
        public String id;
        public String name;
        public String [] below = new String[] {};//下属人员id集合
    }
    public int calc(person p){
        if(p.below == null || p.below.length == 0){
            return 0;
        }else {
            int max = 0;
            for (int i = 0;i<p.below.length;i++){
                int current = 1+calc(data.get(i));
                if(current> max)
                    max = current;
            }
            if(result == null || result.level < max ){
                result = new ResultP(p.id,p.name,max);
            }
            return max;
        }
    }

    public ResultP entrance(){
        for (String id: data.keySet()) {
            calc(data.get(id));
        }
        return result;
    }

}
