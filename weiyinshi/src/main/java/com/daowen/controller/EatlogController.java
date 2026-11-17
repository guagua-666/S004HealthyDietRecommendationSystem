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
public class EatlogController extends SimpleController {

    @Autowired
    private EatlogService eatlogSrv = null;
    @Autowired
    private HuiyuanService huiyuanSrv=null;


    //
    @ResponseBody
    @PostMapping("/admin/eatlog/save")
    public JsonResult save() {

        String createtime = request.getParameter("createtime");
        String calorie = request.getParameter("calorie");
        String hyid = request.getParameter("hyid");
        SimpleDateFormat sdfeatlog = new SimpleDateFormat("yyyy-MM-dd");
        Eatlog eatlog = new Eatlog();
        if (createtime != null) {
            try {
                eatlog.setCreatetime(sdfeatlog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            eatlog.setCreatetime(new Date());
        }
        eatlog.setCalorie(calorie == null ? 0 : new Integer(calorie));
        eatlog.setHyid(hyid == null ? 0 : new Integer(hyid));
        //end forEach
        Boolean validateresult = eatlogSrv.isExist(MessageFormat.format("where hyid={0} and createtime=''{1}'' ",hyid,createtime));
        if (validateresult)
            return JsonResult.error(-1, "今日已经打过卡");
        eatlogSrv.save(eatlog);
        if(eatlog.getCalorie()<600){
            huiyuanSrv.executeUpdate(MessageFormat.format("update huiyuan set yue=yue+5 where id={0}",hyid));
        }
        return JsonResult.success(1, "成功", eatlog);
    }

    @ResponseBody
    @PostMapping("/admin/eatlog/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Eatlog eatlog = eatlogSrv.load("where id=" + id);
        if (eatlog == null)
            return JsonResult.error(-2, "非法数据");

        String createtime = request.getParameter("createtime");
        String calorie = request.getParameter("calorie");
        String hyid = request.getParameter("hyid");
        SimpleDateFormat sdfeatlog = new SimpleDateFormat("yyyy-MM-dd");
        if (createtime != null) {
            try {
                eatlog.setCreatetime(sdfeatlog.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            eatlog.setCreatetime(new Date());
        }
        eatlog.setCalorie(calorie == null ? 0 : new Integer(calorie));
        eatlog.setHyid(hyid == null ? 0 : new Integer(hyid));
        eatlogSrv.update(eatlog);

        return JsonResult.success(1, "成功", eatlog);

    }

    @ResponseBody
    @PostMapping("/admin/eatlog/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        eatlogSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @RequestMapping("/admin/eatlog/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Eatlog eatlog = eatlogSrv.loadPlus(new Integer(id));
        if (eatlog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", eatlog);

    }

    @ResponseBody
    @RequestMapping("/admin/eatlog/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Eatlog eatlog = eatlogSrv.loadPlus(new Integer(id));
        if (eatlog == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", eatlog);

    }


    @ResponseBody
    @PostMapping("/admin/eatlog/warningrec")
    public JsonResult warningrec(){
        HashMap<String, Object> map = new HashMap<>();

        String hyid = request.getParameter("hyid");

        if(hyid!=null)
            map.put("hyid",hyid);

        return JsonResult.success(1, "获取成功", eatlogSrv.getWarningRec(map));

    }

    @ResponseBody
    @PostMapping("/admin/eatlog/list")
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
            List<Eatlog> listEatlog = eatlogSrv.getEntityPlus(map);
            PageInfo<Eatlog> pageInfo = new PageInfo<Eatlog>(listEatlog);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", eatlogSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
