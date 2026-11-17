package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  SportlogService extends  SimpleBizservice<SportlogMapper>{

      @Autowired
      private  SportlogMapper  sportlogMapper;



          public  List<Sportlog>   getEntityPlus(HashMap map){
               return  sportlogMapper.getEntityPlus(map);
          }
          
          public  Sportlog   loadPlus(HashMap map){
              return sportlogMapper.loadPlus(map);
          }
          
           public  Sportlog   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}