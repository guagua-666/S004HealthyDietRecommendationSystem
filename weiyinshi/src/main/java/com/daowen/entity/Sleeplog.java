package com.daowen.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

import javax.persistence.*;

/**
 * 健康贴士
 */
@Entity
public class Sleeplog {


    //编码

    @Id
    private int id;


    //日期
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createtime;


    //睡眠时长

    private Double sleeptime;

    private String content;

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

    public Double getSleeptime() {
        return sleeptime;
    }

    public void setSleeptime(Double sleeptime) {
        this.sleeptime = sleeptime;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}