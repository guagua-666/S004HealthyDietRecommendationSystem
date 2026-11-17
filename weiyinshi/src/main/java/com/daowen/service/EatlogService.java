package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  EatlogService extends  SimpleBizservice<EatlogMapper>{

      @Autowired
      private  EatlogMapper  eatlogMapper;



          public  List<Eatlog>   getEntityPlus(HashMap map){
               return  eatlogMapper.getEntityPlus(map);
          }
          
          public  Eatlog   loadPlus(HashMap map){
              return eatlogMapper.loadPlus(map);
          }
          
           public  Eatlog   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }

        public List<Eatlog> getWarningRec(HashMap map){
             return eatlogMapper.warningRec(map);
        }
     
}