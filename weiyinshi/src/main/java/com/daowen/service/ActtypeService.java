package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  ActtypeService extends  SimpleBizservice<ActtypeMapper>{

      @Autowired
      private  ActtypeMapper  acttypeMapper;



          public  List<Acttype>   getEntityPlus(HashMap map){
               return  acttypeMapper.getEntityPlus(map);
          }
          
          public  Acttype   loadPlus(HashMap map){
              return acttypeMapper.loadPlus(map);
          }
          
           public  Acttype   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}