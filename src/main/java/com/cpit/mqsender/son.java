package com.cpit.mqsender;

import org.springframework.stereotype.Service;

@Service
public class son extends p{
    @Override
    public void ok() {
        try{
            dxx();
        }catch (Exception e){
            logger.error("{}",e);
        }

    }

    public static void main(String[] args) {
        son s = new son();
        s.ok();
    }

}
