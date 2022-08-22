package com.cpit.mqsender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

@ShellComponent
public class BaseCommands {
    @Autowired
    Sender sender;

    @ShellMethod("普天桩发消息")
    public void p() {
        sender.sendp();
    }
    @ShellMethod("英飞源桩发消息")
    public void y() {

    }
    @ShellMethod("亿联桩发消息")
    public void l() {

    }

}
