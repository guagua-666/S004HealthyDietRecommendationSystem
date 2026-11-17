package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  SleeplogService extends  SimpleBizservice<SleeplogMapper>{

      @Autowired
      private  SleeplogMapper  sleeplogMapper;



          public  List<Sleeplog>   getEntityPlus(HashMap map){
               return  sleeplogMapper.getEntityPlus(map);
          }
          
          public  Sleeplog   loadPlus(HashMap map){
              return sleeplogMapper.loadPlus(map);
          }
          
           public  Sleeplog   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }

    public List<Sleeplog> getWarningRec(HashMap map){
         return sleeplogMapper.warningRec(map);
    }
     
}