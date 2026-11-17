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
public class SportlogController extends SimpleController {

    @Autowired
    private SportlogService sportlogSrv = null;


    @Autowired
    private HuiyuanService huiyuanSrv=null;
    //
    @ResponseBody
    @PostMapping("/admin/sportlog/save")
    public JsonResult save() {

        String createtime = request.getParameter("createtime");

        String shour = request.getParameter("shour");

        String calorie = request.getParameter("calorie");
        
        String tijiancontent = request.getParameter("tijiancontent");

        String hyid = request.getParameter("hyid");

        SimpleDateFormat sdfsportlog = new SimpleDateFormat("yyyy-MM-dd");
        Sportlog sportlog = new Sportlog();


        if (createtime != null) {
            try {
                sportlog.setCreatetime(sdfsportlog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            sportlog.setCreatetime(new Date());
        }


        sportlog.setShour(shour == null ? 0 : new Double(shour));


        sportlog.setCalorie(calorie == null ? 0 : new Integer(calorie));


        sportlog.setHyid(hyid == null ? 0 : new Integer(hyid));
        
        sportlog.setTijiancontent(tijiancontent);

        //end forEach

        Boolean validateresult = sportlogSrv.isExist(MessageFormat.format("where hyid={0} and createtime=''{1}'' ",hyid,createtime));
        if (validateresult)
            return JsonResult.error(-1, "今日已经体检过");

        sportlogSrv.save(sportlog);
        if(sportlog.getCalorie()>=300){
            huiyuanSrv.executeUpdate(MessageFormat.format("update huiyuan set yue=yue+5 where id={0}",hyid));
        }
        return JsonResult.success(1, "成功", sportlog);
    }

    @ResponseBody
    @PostMapping("/admin/sportlog/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sportlog sportlog = sportlogSrv.load("where id=" + id);
        if (sportlog == null)
            return JsonResult.error(-2, "非法数据");

        String createtime = request.getParameter("createtime");

        String shour = request.getParameter("shour");

        String calorie = request.getParameter("calorie");

        String hyid = request.getParameter("hyid");
        
        String tijiancontent = request.getParameter("tijiancontent");

        SimpleDateFormat sdfsportlog = new SimpleDateFormat("yyyy-MM-dd");


        if (createtime != null) {
            try {
                sportlog.setCreatetime(sdfsportlog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            sportlog.setCreatetime(new Date());
        }


        sportlog.setShour(shour == null ? 0 : new Double(shour));


        sportlog.setCalorie(calorie == null ? 0 : new Integer(calorie));


        sportlog.setHyid(hyid == null ? 0 : new Integer(hyid));
        
        sportlog.setTijiancontent(tijiancontent);

        sportlogSrv.update(sportlog);
        return JsonResult.success(1, "成功", sportlog);

    }

    @ResponseBody
    @PostMapping("/admin/sportlog/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        sportlogSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @RequestMapping("/admin/sportlog/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sportlog sportlog = sportlogSrv.loadPlus(new Integer(id));
        if (sportlog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", sportlog);

    }

    @ResponseBody
    @RequestMapping("/admin/sportlog/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Sportlog sportlog = sportlogSrv.loadPlus(new Integer(id));
        if (sportlog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", sportlog);

    }



    @ResponseBody
    @PostMapping("/admin/sportlog/list")
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
            List<Sportlog> listSportlog = sportlogSrv.getEntityPlus(map);
            PageInfo<Sportlog> pageInfo = new PageInfo<Sportlog>(listSportlog);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", sportlogSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
