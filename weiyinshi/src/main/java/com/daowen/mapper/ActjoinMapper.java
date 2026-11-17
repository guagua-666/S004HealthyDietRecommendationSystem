package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.ActjoinVo;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  运动报名
**/
@Repository
public interface ActjoinMapper  extends SimpleMapper<Actjoin> {

          List<ActjoinVo>   getEntityPlus(HashMap map);
          
           ActjoinVo   loadPlus(HashMap map);

}