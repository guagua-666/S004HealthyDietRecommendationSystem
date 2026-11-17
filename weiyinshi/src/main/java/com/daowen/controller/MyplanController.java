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
public class MyplanController extends SimpleController {

    @Autowired
    private MyplanService myplanSrv = null;


    //
    @ResponseBody
    @PostMapping("/admin/myplan/save")
    public JsonResult save() {

        String title = request.getParameter("title");

        String createtime = request.getParameter("createtime");

        String hyid = request.getParameter("hyid");

        String state = request.getParameter("state");

        String des = request.getParameter("des");

        SimpleDateFormat sdfmyplan = new SimpleDateFormat("yyyy-MM-dd");
        Myplan myplan = new Myplan();


        myplan.setTitle(title == null ? "" : title);


        if (createtime != null) {
            try {
                myplan.setCreatetime(sdfmyplan.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            myplan.setCreatetime(new Date());
        }


        myplan.setHyid(hyid == null ? 0 : new Integer(hyid));


        myplan.setState(1);


        myplan.setDes(des == null ? "" : des);


        //end forEach

        Boolean validateresult = myplanSrv.isExist(MessageFormat.format("where hyid={0} and createtime=''{1}'' ",hyid,createtime));
        if (validateresult)
            return JsonResult.error(-1, "已经制定了当日计划");

        myplanSrv.save(myplan);
        return JsonResult.success(1, "成功", myplan);
    }


    @ResponseBody
    @PostMapping("/admin/myplan/over")
    public JsonResult over() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Myplan myplan = myplanSrv.load("where id=" + id);
        if (myplan == null)
            return JsonResult.error(-2, "非法数据");

        String state=request.getParameter("state");

        SimpleDateFormat sdfmyplan = new SimpleDateFormat("yyyy-MM-dd");

        myplan.setState(state==null?2:new Integer(state));
        myplanSrv.update(myplan);
        return JsonResult.success(1, "成功", myplan);

    }

    @ResponseBody
    @PostMapping("/admin/myplan/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Myplan myplan = myplanSrv.load("where id=" + id);
        if (myplan == null)
            return JsonResult.error(-2, "非法数据");

        String title = request.getParameter("title");

        String createtime = request.getParameter("createtime");

        String hyid = request.getParameter("hyid");

        String des = request.getParameter("des");

        SimpleDateFormat sdfmyplan = new SimpleDateFormat("yyyy-MM-dd");


        myplan.setTitle(title == null ? "" : title);


        if (createtime != null) {
            try {
                myplan.setCreatetime(sdfmyplan.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            myplan.setCreatetime(new Date());
        }


        myplan.setHyid(hyid == null ? 0 : new Integer(hyid));



        myplan.setDes(des == null ? "" : des);


        myplanSrv.update(myplan);
        return JsonResult.success(1, "成功", myplan);

    }

    @ResponseBody
    @PostMapping("/admin/myplan/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        myplanSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @RequestMapping("/admin/myplan/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Myplan myplan = myplanSrv.loadPlus(new Integer(id));
        if (myplan == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", myplan);

    }

    @ResponseBody
    @RequestMapping("/admin/myplan/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Myplan myplan = myplanSrv.loadPlus(new Integer(id));
        if (myplan == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", myplan);

    }


    @ResponseBody
    @PostMapping("/admin/myplan/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String title = request.getParameter("title");
        if (title != null)
            map.put("title", title);
		String hyid = request.getParameter("hyid");

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
            List<Myplan> listMyplan = myplanSrv.getEntityPlus(map);
            PageInfo<Myplan> pageInfo = new PageInfo<Myplan>(listMyplan);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", myplanSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
