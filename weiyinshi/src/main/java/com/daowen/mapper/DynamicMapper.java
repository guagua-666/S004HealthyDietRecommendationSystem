package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  动态
**/
@Repository
public interface DynamicMapper  extends SimpleMapper<Dynamic> {

          List<Dynamic>   getEntityPlus(HashMap map);
          
           Dynamic   loadPlus(HashMap map);

}