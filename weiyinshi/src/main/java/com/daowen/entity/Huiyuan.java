package com.daowen.entity;
import java.util.Date;
import javax.persistence.*;
@Entity
public class Huiyuan
{
@Id
@GeneratedValue(strategy =GenerationType.AUTO)
   private int id ;
   public int getId() 
   {
      return id;
  }
   public void setId(int id) 
   {
      this.id= id;
  }
   private String accountname ;
   public String getAccountname() 
   {
      return accountname;
  }
   public void setAccountname(String accountname) 
   {
      this.accountname= accountname;
  }
   private String password ;
   public String getPassword() 
   {
      return password;
  }
   public void setPassword(String password) 
   {
      this.password= password;
  }
   private int logtimes ;
   public int getLogtimes() 
   {
      return logtimes;
  }
   public void setLogtimes(int logtimes) 
   {
      this.logtimes= logtimes;
  }
   private String sex ;
   public String getSex() 
   {
      return sex;
  }
   public void setSex(String sex) 
   {
      this.sex= sex;
  }
   private String touxiang ;
   public String getTouxiang() 
   {
      return touxiang;
  }
   public void setTouxiang(String touxiang) 
   {
      this.touxiang= touxiang;
  }
   private Date regdate ;
   public Date getRegdate() 
   {
      return regdate;
  }
   public void setRegdate(Date regdate) 
   {
      this.regdate= regdate;
  }
   private String des ;
   public String getDes() 
   {
      return des;
  }
   public void setDes(String des) 
   {
      this.des= des;
  }
   private String mobile ;
   public String getMobile() 
   {
      return mobile;
  }
   public void setMobile(String mobile) 
   {
      this.mobile= mobile;
  }
   private String name ;
   public String getName() 
   {
      return name;
  }
   public void setName(String name) 
   {
      this.name= name;
  }
   private Double yue ;
   public Double getYue() 
   {
      return yue;
  }
   public void setYue(Double yue) 
   {
      this.yue= yue;
  }


   private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    private String openid;
    private String wxname;

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getWxname() {
        return wxname;
    }

    public void setWxname(String wxname) {
        this.wxname = wxname;
    }

    private int isbind;

    public int getIsbind() {
        return isbind;
    }

    public void setIsbind(int isbind) {
        this.isbind = isbind;
    }

    private String paypwd;

    public String getPaypwd() {
        return paypwd;
    }

    public void setPaypwd(String paypwd) {
        this.paypwd = paypwd;
    }
}
