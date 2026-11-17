package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  健康贴士
**/
@Repository
public interface SleeplogMapper  extends SimpleMapper<Sleeplog> {

          List<Sleeplog>   getEntityPlus(HashMap map);
          
           Sleeplog   loadPlus(HashMap map);

           List<Sleeplog> warningRec(HashMap map);



}