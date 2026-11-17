package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  运动类型
**/
@Repository
public interface ActtypeMapper  extends SimpleMapper<Acttype> {

          List<Acttype>   getEntityPlus(HashMap map);
          
           Acttype   loadPlus(HashMap map);

}