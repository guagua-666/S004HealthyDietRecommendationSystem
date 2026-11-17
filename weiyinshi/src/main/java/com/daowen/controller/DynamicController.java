package com.daowen.controller;

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
public class DynamicController extends SimpleController {

    @Autowired
    private DynamicService dynamicSrv = null;


    //
    @ResponseBody
    @PostMapping("/admin/dynamic/save")
    public JsonResult save() {

        String title = request.getParameter("title");



        String hyid = request.getParameter("hyid");

        String tupian = request.getParameter("tupian");

        String clickcount = request.getParameter("clickcount");

        String dcontent = request.getParameter("dcontent");

        String xshow = request.getParameter("xshow");

        SimpleDateFormat sdfdynamic = new SimpleDateFormat("yyyy-MM-dd");
        Dynamic dynamic = new Dynamic();


        dynamic.setTitle(title == null ? "" : title);



        dynamic.setPubtime(new Date());



        dynamic.setHyid(hyid == null ? 0 : new Integer(hyid));


        dynamic.setTupian(tupian == null ? "" : tupian);


        dynamic.setClickcount(clickcount == null ? 0 : new Integer(clickcount));


        dynamic.setDcontent(dcontent == null ? "" : dcontent);


        dynamic.setXshow(xshow == null ? 0 : new Integer(xshow));


        //end forEach

        Boolean validateresult = dynamicSrv.isExist("  where  title='" + title + "'");
        if (validateresult)
            return JsonResult.error(-1, "已存在的记录");

        dynamicSrv.save(dynamic);
        return JsonResult.success(1, "成功", dynamic);
    }

    @ResponseBody
    @PostMapping("/admin/dynamic/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Dynamic dynamic = dynamicSrv.load("where id=" + id);
        if (dynamic == null)
            return JsonResult.error(-2, "非法数据");

        String title = request.getParameter("title");

        String pubtime = request.getParameter("pubtime");

        String hyid = request.getParameter("hyid");

        String tupian = request.getParameter("tupian");

        String clickcount = request.getParameter("clickcount");

        String dcontent = request.getParameter("dcontent");

        String xshow = request.getParameter("xshow");

        SimpleDateFormat sdfdynamic = new SimpleDateFormat("yyyy-MM-dd");


        dynamic.setTitle(title == null ? "" : title);


        if (pubtime != null) {
            try {
                dynamic.setPubtime(sdfdynamic.parse(pubtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            dynamic.setPubtime(new Date());
        }


        dynamic.setHyid(hyid == null ? 0 : new Integer(hyid));


        dynamic.setTupian(tupian == null ? "" : tupian);


        dynamic.setClickcount(clickcount == null ? 0 : new Integer(clickcount));


        dynamic.setDcontent(dcontent == null ? "" : dcontent);


        dynamic.setXshow(xshow == null ? 0 : new Integer(xshow));


        dynamicSrv.update(dynamic);
        return JsonResult.success(1, "成功", dynamic);

    }

    @ResponseBody
    @PostMapping("/admin/dynamic/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        dynamicSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @RequestMapping("/admin/dynamic/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Dynamic dynamic = dynamicSrv.loadPlus(new Integer(id));
        if (dynamic == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", dynamic);

    }

    @ResponseBody
    @RequestMapping("/admin/dynamic/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Dynamic dynamic = dynamicSrv.loadPlus(new Integer(id));
        if (dynamic == null)
            return JsonResult.error(-2, "非法数据");
        dynamicSrv.executeUpdate("update dynamic set clickcount=clickcount+1 where id="+id);
        return JsonResult.success(1, "成功", dynamic);

    }

    @ResponseBody
    @PostMapping("/admin/dynamic/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String title = request.getParameter("title");
        String hyid=request.getParameter("hyid");
        if (title != null)
            map.put("title", title);
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
            List<Dynamic> listDynamic = dynamicSrv.getEntityPlus(map);
            PageInfo<Dynamic> pageInfo = new PageInfo<Dynamic>(listDynamic);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", dynamicSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
