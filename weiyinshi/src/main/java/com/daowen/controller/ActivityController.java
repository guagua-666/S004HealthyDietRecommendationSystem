package com.daowen.controller;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

//##{{import}}
@RestController
public class ActivityController extends SimpleController {

    @Autowired
    private ActivityService activitySrv = null;


    //
    @PostMapping("/admin/activity/save")
    public JsonResult save() {

        String title = request.getParameter("title");
        String begindate = request.getParameter("begindate");
        String enddate = request.getParameter("enddate");
        String tupian = request.getParameter("tupian");
        String pubren = request.getParameter("pubren");
        String typeid = request.getParameter("typeid");
        String maxcount=request.getParameter("maxcount");
        String des = request.getParameter("des");

        SimpleDateFormat sdfactivity = new SimpleDateFormat("yyyy-MM-dd");
        Activity activity = new Activity();
        activity.setTitle(title == null ? "" : title);
        if (begindate != null) {
            try {
                activity.setBegindate(sdfactivity.parse(begindate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            activity.setBegindate(new Date());
        }
        if (enddate != null) {
            try {
                activity.setEnddate(sdfactivity.parse(enddate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            activity.setEnddate(new Date());
        }
        activity.setTupian(tupian == null ? "" : tupian);
        activity.setPubren(pubren == null ? 0 : new Integer(pubren));
        activity.setState(1);
        activity.setMaxcount(maxcount==null?0:Integer.parseInt(maxcount));
        activity.setTypeid(typeid == null ? 0 : new Integer(typeid));
        activity.setDes(des == null ? "" : des);
        //end forEach

        Boolean validateresult = activitySrv.isExist("  where  title='" + title + "'");
        if (validateresult)
            return JsonResult.error(-1, "已存在的记录");

        activitySrv.save(activity);
        return JsonResult.success(1, "成功", activity);
    }

    @PostMapping("/admin/activity/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Activity activity = activitySrv.load("where id=" + id);
        if (activity == null)
            return JsonResult.error(-2, "非法数据");

        String title = request.getParameter("title");
        String maxcount=request.getParameter("maxcount");
        String begindate = request.getParameter("begindate");

        String enddate = request.getParameter("enddate");

        String tupian = request.getParameter("tupian");

        String typeid = request.getParameter("typeid");
        String des = request.getParameter("des");

        SimpleDateFormat sdfactivity = new SimpleDateFormat("yyyy-MM-dd");


        activity.setTitle(title == null ? "" : title);


        if (begindate != null) {
            try {
                activity.setBegindate(sdfactivity.parse(begindate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            activity.setBegindate(new Date());
        }
        if (enddate != null) {
            try {
                activity.setEnddate(sdfactivity.parse(enddate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            activity.setEnddate(new Date());
        }
        activity.setTupian(tupian == null ? "" : tupian);
        activity.setMaxcount(maxcount==null?0:Integer.parseInt(maxcount));
        activity.setTypeid(typeid == null ? 0 : new Integer(typeid));
        activity.setDes(des == null ? "" : des);
        activitySrv.update(activity);
        return JsonResult.success(1, "成功", activity);

    }

    @PostMapping("/admin/activity/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        activitySrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @RequestMapping("/admin/activity/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Activity activity = activitySrv.loadPlus(new Integer(id));
        if (activity == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", activity);

    }

    @RequestMapping("/admin/activity/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Activity activity = activitySrv.loadPlus(new Integer(id));
        if (activity == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", activity);

    }

    @ResponseBody
    @PostMapping("/admin/activity/joinlist")
    public JsonResult joinlist(){

        String sql="select a.* from activity a ,actjoin aj where aj.actid=a.id ";
        String hyid=request.getParameter("hyid");
        String typeid=request.getParameter("typeid");
        HashMap map = new HashMap();
        if(typeid!=null)
            sql+=" and typeid="+typeid;
        if(hyid!=null)
            sql+=" and hyid="+hyid;
        List<Activity> listActivity = activitySrv.query(sql);
        return JsonResult.success(1,"获取比赛信息",listActivity);
    }


    @RequestMapping("/admin/activity/over")
    public JsonResult over() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Activity activity = activitySrv.loadPlus(new Integer(id));
        if (activity == null)
            return JsonResult.error(-2, "非法数据");
        activity.setState(2);
        activitySrv.update(activity);
        return JsonResult.success(1, "成功");

    }

    @PostMapping("/admin/activity/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String title = request.getParameter("title");
        String tid=request.getParameter("tid");
        String typeid=request.getParameter("typeid");
        String state=request.getParameter("state");
        if (title != null)
            map.put("title", title);
        if(tid!=null)
            map.put("tid",tid);
        if(typeid!=null)
            map.put("typeid",typeid);
        if(state!=null)
            map.put("state",state);

        int pageindex = 1;
        int pagesize = 10;
        // 获取当前分页
        String currentpageindex = request.getParameter("currentpageindex");
        // 当前页面尺寸
        String currentpagesize = request.getParameter("pagesize");
        // 设置当前页
        if (currentpageindex != null)
            pageindex = new Integer(currentpageindex);
        // 设置当前页尺寸
        if (currentpagesize != null)
            pagesize = new Integer(currentpagesize);
        if (!"-1".equals(ispaged)) {
            PageHelper.startPage(pageindex, pagesize);
            List<Activity> listActivity = activitySrv.getEntityPlus(map);
            PageInfo<Activity> pageInfo = new PageInfo<Activity>(listActivity);
            return JsonResult.success(1, "成功", pageInfo);
        }

        return JsonResult.success(1, "获取成功", activitySrv.getEntityPlus(map));


    }

    //##{{methods}}


}
