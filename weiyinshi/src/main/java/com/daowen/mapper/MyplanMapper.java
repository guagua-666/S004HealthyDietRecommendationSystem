package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  我的计划
**/
@Repository
public interface MyplanMapper  extends SimpleMapper<Myplan> {

          List<Myplan>   getEntityPlus(HashMap map);
          
           Myplan   loadPlus(HashMap map);

}