package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  饮食
**/
@Repository
public interface EatlogMapper  extends SimpleMapper<Eatlog> {

          List<Eatlog>   getEntityPlus(HashMap map);
          
           Eatlog   loadPlus(HashMap map);

           List<Eatlog> warningRec(HashMap map);

}