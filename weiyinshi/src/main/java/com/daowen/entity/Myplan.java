package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 我的计划
 */
@Entity
public class Myplan {


    //编码

    @Id
    private int id;


    //计划

    private String title;


    //日期

    private Date createtime;


    //会员

    private int hyid;


    //状态

    private int state;


    //说明

    private String des;


    @Transient
    private String hyaccount;
    @Transient
    private String hyname;

    public String getHyaccount() {
        return hyaccount;
    }

    public void setHyaccount(String hyaccount) {
        this.hyaccount = hyaccount;
    }

    public String getHyname() {
        return hyname;
    }

    public void setHyname(String hyname) {
        this.hyname = hyname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

}