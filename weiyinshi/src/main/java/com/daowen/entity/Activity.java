package com.daowen.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

import javax.persistence.*;

/**
 * 健康食谱活动
 */
@Entity
public class Activity {


    //编码

    @Id
    private int id;


    //标题

    private String title;


    //开始时间
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date begindate;


    //结束日期

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date enddate;


    //图片

    private String tupian;


    //发布人

    private int pubren;


    //状态

    private int state;


    //类别

    private int typeid;


    private  int maxcount;

    public int getMaxcount() {
        return maxcount;
    }

    public void setMaxcount(int maxcount) {
        this.maxcount = maxcount;
    }


    //介绍

    private String des;


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

    public Date getBegindate() {
        return begindate;
    }

    public void setBegindate(Date begindate) {
        this.begindate = begindate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }

    public String getTupian() {
        return tupian;
    }

    public void setTupian(String tupian) {
        this.tupian = tupian;
    }

    public int getPubren() {
        return pubren;
    }

    public void setPubren(int pubren) {
        this.pubren = pubren;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    @Transient
    private String typename;

    public String getTypename() {
        return typename;
    }

    @Transient
    private String pbraccount;
    @Transient
    private String pbrname;



    public void setTypename(String typename) {
        this.typename = typename;
    }


    public String getPbraccount() {
        return pbraccount;
    }

    public void setPbraccount(String pbraccount) {
        this.pbraccount = pbraccount;
    }

    public String getPbrname() {
        return pbrname;
    }

    public void setPbrname(String pbrname) {
        this.pbrname = pbrname;
    }


}