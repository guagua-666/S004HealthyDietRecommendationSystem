package com.daowen.controller;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.ResponseBody;

//##{{import}}
@Controller
public class SleeplogController extends SimpleController {

    @Autowired
    private SleeplogService sleeplogSrv = null;


    @Autowired
    private HuiyuanService huiyuanSrv=null;
    //
    @ResponseBody
    @PostMapping("/admin/sleeplog/save")
    public JsonResult save() {

        String createtime = request.getParameter("createtime");

        String sleeptime = request.getParameter("sleeptime");

        String hyid = request.getParameter("hyid");
        
        String content = request.getParameter("content");

        SimpleDateFormat sdfsleeplog = new SimpleDateFormat("yyyy-MM-dd");
        Sleeplog sleeplog = new Sleeplog();


        if (createtime != null) {
            try {
                sleeplog.setCreatetime(sdfsleeplog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            sleeplog.setCreatetime(new Date());
        }


        sleeplog.setSleeptime(sleeptime == null ? 0 : new Double(sleeptime));


        sleeplog.setHyid(hyid == null ? 0 : new Integer(hyid));

        sleeplog.setContent(content);

        //end forEach

        Boolean validateresult = sleeplogSrv.isExist(MessageFormat.format("where hyid={0} and createtime=''{1}'' ", hyid, createtime));
        if (validateresult)
            return JsonResult.error(-1, "今日已经记录过");

        sleeplogSrv.save(sleeplog);
        if(sleeplog.getSleeptime()>=8){
            huiyuanSrv.executeUpdate(MessageFormat.format("update huiyuan set yue=yue+5 where id={0}",hyid));
        }
        return JsonResult.success(1, "成功", sleeplog);
    }

    @ResponseBody
    @PostMapping("/admin/sleeplog/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sleeplog sleeplog = sleeplogSrv.load("where id=" + id);
        if (sleeplog == null)
            return JsonResult.error(-2, "非法数据");

        String createtime = request.getParameter("createtime");

        String sleeptime = request.getParameter("sleeptime");

        String hyid = request.getParameter("hyid");
        String content = request.getParameter("content");

        SimpleDateFormat sdfsleeplog = new SimpleDateFormat("yyyy-MM-dd");


        if (createtime != null) {
            try {
                sleeplog.setCreatetime(sdfsleeplog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            sleeplog.setCreatetime(new Date());
        }


        sleeplog.setSleeptime(sleeptime == null ? 0 : new Double(sleeptime));


        sleeplog.setHyid(hyid == null ? 0 : new Integer(hyid));
        sleeplog.setContent(content);

        sleeplogSrv.update(sleeplog);
        return JsonResult.success(1, "成功", sleeplog);

    }

    @ResponseBody
    @PostMapping("/admin/sleeplog/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        sleeplogSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @RequestMapping("/admin/sleeplog/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sleeplog sleeplog = sleeplogSrv.loadPlus(new Integer(id));
        if (sleeplog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", sleeplog);

    }

    @ResponseBody
    @RequestMapping("/admin/sleeplog/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sleeplog sleeplog = sleeplogSrv.loadPlus(new Integer(id));
        if (sleeplog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", sleeplog);

    }

    @ResponseBody
    @PostMapping("/admin/sleeplog/warningrec")
    public JsonResult warningrec(){
        HashMap<String, Object> map = new HashMap<>();

        String hyid = request.getParameter("hyid");

        if(hyid!=null)
            map.put("hyid",hyid);

        return JsonResult.success(1, "获取成功", sleeplogSrv.getWarningRec(map));

    }


    @ResponseBody
    @PostMapping("/admin/sleeplog/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String createtime = request.getParameter("createtime");
        String hyid = request.getParameter("hyid");
        if (createtime != null)
            map.put("createtime", createtime);
        if(hyid!=null)
            map.put("hyid",hyid);

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
            List<Sleeplog> listSleeplog = sleeplogSrv.getEntityPlus(map);
            PageInfo<Sleeplog> pageInfo = new PageInfo<Sleeplog>(listSleeplog);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", sleeplogSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
