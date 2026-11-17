package com.daowen.service;

import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class ActivityService extends SimpleBizservice<ActivityMapper> {

    @Autowired
    private ActivityMapper activityMapper;


    public List<Activity> getEntityPlus(HashMap map) {
        return activityMapper.getEntityPlus(map);
    }

    public Activity loadPlus(HashMap map) {
        return activityMapper.loadPlus(map);
    }

    public Activity loadPlus(int id) {
        HashMap map = new HashMap();
        map.put("id", id);
        return this.loadPlus(map);
    }

    public List<HashMap<String, Object>> getJoined(Integer id) {

        return getMapper().getJoined(id);
    }

    public long getDiffMintues(int actId) {

        Activity activity = this.load(actId);

        Date now = new Date();
        //开始时间
        long startDiff = now.getTime() - activity.getBegindate().getTime();

        long endDiff = activity.getEnddate().getTime() - now.getTime();

        if (startDiff > 0 && endDiff > 0)

            return endDiff / (1000 * 60);

        return 0;

    }


}