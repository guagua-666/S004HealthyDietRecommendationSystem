package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 运动报名
 */
@Entity
public class Actjoin {


    //编码

    @Id
    private int id;


    //报名人

    private int hyid;


    //运动

    private int actid;




    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

    public int getActid() {
        return actid;
    }

    public void setActid(int actid) {
        this.actid = actid;
    }



    private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }


    private Date createtime;

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    private String spdes;

    public String getSpdes() {
        return spdes;
    }

    public void setSpdes(String spdes) {
        this.spdes = spdes;
    }

    private Double score;

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }
}