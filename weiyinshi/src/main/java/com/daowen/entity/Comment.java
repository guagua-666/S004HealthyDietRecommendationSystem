package com.daowen.entity;
import java.util.Date;
import javax.persistence.*;
@Entity
public class Comment
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
   private String commentor ;
   public String getCommentor() 
   {
      return commentor;
  }
   public void setCommentor(String commentor) 
   {
      this.commentor= commentor;
  }
   private Date commenttime ;
   public Date getCommenttime() 
   {
      return commenttime;
  }
   public void setCommenttime(Date commenttime) 
   {
      this.commenttime= commenttime;
  }
   private String dcontent ;
   public String getDcontent() 
   {
      return dcontent;
  }
   public void setDcontent(String dcontent) 
   {
      this.dcontent= dcontent;
  }
   private String tablename ;
   public String getTablename() 
   {
      return tablename;
  }
   public void setTablename(String tablename) 
   {
      this.tablename= tablename;
  }
   private int belongid ;
   public int getBelongid() 
   {
      return belongid;
  }
   public void setBelongid(int belongid) 
   {
      this.belongid= belongid;
  }
   private String pics ;
   public String getPics() 
   {
      return pics;
  }
   public void setPics(String pics) 
   {
      this.pics= pics;
  }
}
