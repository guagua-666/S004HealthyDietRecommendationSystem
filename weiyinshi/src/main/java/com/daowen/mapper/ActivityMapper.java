package com.daowen.mapper;

import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.*;

/*
 *  健康食谱活动
 **/
@Repository
public interface ActivityMapper extends SimpleMapper<Activity> {

    List<Activity> getEntityPlus(HashMap map);

    Activity loadPlus(HashMap map);

    public List<HashMap<String, Object>> getJoined(@Param("id") int id);

}