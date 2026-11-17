package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  DynamicService extends  SimpleBizservice<DynamicMapper>{

      @Autowired
      private  DynamicMapper  dynamicMapper;



          public  List<Dynamic>   getEntityPlus(HashMap map){
               return  dynamicMapper.getEntityPlus(map);
          }
          
          public  Dynamic   loadPlus(HashMap map){
              return dynamicMapper.loadPlus(map);
          }
          
           public  Dynamic   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}