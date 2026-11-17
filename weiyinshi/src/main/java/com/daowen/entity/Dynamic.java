package com.daowen.entity;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

/**
 * 动态
 */
@Entity
public class Dynamic {


    //编码

    @Id
    private int id;


    //标题

    private String title;


    //发布时间

    private Date pubtime;


    //发布人

    private int hyid;


    //图片

    private String tupian;


    //点击次数

    private int clickcount;


    //内容

    private String dcontent;

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


    public List<String> getImages(){
        if(getTupian()==null)
            return null;
        return Arrays.asList(getTupian().split("\\$;"));

    }

    //隐私

    private int xshow;

    public int getXshow() {
        return xshow;
    }

    public void setXshow(int xshow) {
        this.xshow = xshow;
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

    public Date getPubtime() {
        return pubtime;
    }

    public void setPubtime(Date pubtime) {
        this.pubtime = pubtime;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

    public String getTupian() {
        return tupian;
    }

    public void setTupian(String tupian) {
        this.tupian = tupian;
    }

    public int getClickcount() {
        return clickcount;
    }

    public void setClickcount(int clickcount) {
        this.clickcount = clickcount;
    }

    public String getDcontent() {
        return dcontent;
    }

    public void setDcontent(String dcontent) {
        this.dcontent = dcontent;
    }



}