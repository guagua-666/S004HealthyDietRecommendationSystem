package com.daowen.service;
import com.daowen.entity.*;
import com.daowen.vo.ActjoinVo;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  ActjoinService extends  SimpleBizservice<ActjoinMapper>{

      @Autowired
      private  ActjoinMapper  actjoinMapper;



          public  List<ActjoinVo>   getEntityPlus(HashMap map){
               return  actjoinMapper.getEntityPlus(map);
          }
          
          public  ActjoinVo   loadPlus(HashMap map){
              return actjoinMapper.loadPlus(map);
          }
          
           public  ActjoinVo   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}