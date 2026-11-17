package com.daowen.vo;

import com.daowen.entity.Actjoin;

public class ActjoinVo extends Actjoin {
    /**
     * 运动名称
     */
    private String actname;

    private String joinaccount;

    private String joinname;

    private String photo;
    private String mobile;


    private String tupian;


    public String getJoinaccount() {
        return joinaccount;
    }

    public void setJoinaccount(String joinaccount) {
        this.joinaccount = joinaccount;
    }

    public String getJoinname() {
        return joinname;
    }

    public void setJoinname(String joinname) {
        this.joinname = joinname;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getActname() {
        return actname;
    }

    public void setActname(String actname) {
        this.actname = actname;
    }


    public String getTupian() {
        return tupian;
    }

    public void setTupian(String tupian) {
        this.tupian = tupian;
    }
}
