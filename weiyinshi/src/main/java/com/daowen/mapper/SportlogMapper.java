package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  体检记录
**/
@Repository
public interface SportlogMapper  extends SimpleMapper<Sportlog> {

          List<Sportlog>   getEntityPlus(HashMap map);
          
           Sportlog   loadPlus(HashMap map);

}