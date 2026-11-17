package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  MyplanService extends  SimpleBizservice<MyplanMapper>{

      @Autowired
      private  MyplanMapper  myplanMapper;



          public  List<Myplan>   getEntityPlus(HashMap map){
               return  myplanMapper.getEntityPlus(map);
          }
          
          public  Myplan   loadPlus(HashMap map){
              return myplanMapper.loadPlus(map);
          }
          
           public  Myplan   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}