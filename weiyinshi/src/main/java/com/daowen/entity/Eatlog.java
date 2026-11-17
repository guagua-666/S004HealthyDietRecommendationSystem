package com.daowen.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

import javax.persistence.*;

/**
 * 饮食
 */
@Entity
public class Eatlog {


    //编码

    @Id
    private int id;


    //日期
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createtime;


    //摄入量

    private int calorie;


    //发布人

    private int hyid;

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

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public int getCalorie() {
        return calorie;
    }

    public void setCalorie(int calorie) {
        this.calorie = calorie;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

}