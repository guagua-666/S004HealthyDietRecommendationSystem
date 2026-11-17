package com.daowen.controller;

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
import org.springframework.web.bind.annotation.RestController;

//##{{import}}
@RestController
public class ActtypeController extends SimpleController {

    @Autowired
    private ActtypeService acttypeSrv = null;


    //
    @PostMapping("/admin/acttype/save")
    public JsonResult save() {

        String name = request.getParameter("name");

        SimpleDateFormat sdfacttype = new SimpleDateFormat("yyyy-MM-dd");
        Acttype acttype = new Acttype();


        acttype.setName(name == null ? "" : name);


        //end forEach

        Boolean validateresult = acttypeSrv.isExist("  where  name='" + name + "'");
        if (validateresult)
            return JsonResult.error(-1, "已存在的记录");

        acttypeSrv.save(acttype);
        return JsonResult.success(1, "成功", acttype);
    }

    @PostMapping("/admin/acttype/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Acttype acttype = acttypeSrv.load("where id=" + id);
        if (acttype == null)
            return JsonResult.error(-2, "非法数据");

        String name = request.getParameter("name");

        SimpleDateFormat sdfacttype = new SimpleDateFormat("yyyy-MM-dd");


        acttype.setName(name == null ? "" : name);


        acttypeSrv.update(acttype);
        return JsonResult.success(1, "成功", acttype);

    }

    @PostMapping("/admin/acttype/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        acttypeSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @RequestMapping("/admin/acttype/load")
    public JsonResult load() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Acttype acttype = acttypeSrv.loadPlus(new Integer(id));
        if (acttype == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", acttype);

    }

    @RequestMapping("/admin/acttype/info")
    public JsonResult info() {
        String id = request.getParameter("id");

        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Acttype acttype = acttypeSrv.loadPlus(new Integer(id));
        if (acttype == null)
            return JsonResult.error(-2, "非法数据");
        return JsonResult.success(1, "成功", acttype);

    }

    @PostMapping("/admin/acttype/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String name = request.getParameter("name");
        if (name != null)
            map.put("name", name);

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
            List<Acttype> listActtype = acttypeSrv.getEntityPlus(map);
            PageInfo<Acttype> pageInfo = new PageInfo<Acttype>(listActtype);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1, "获取成功", acttypeSrv.getEntityPlus(map));


    }

    //##{{methods}}


}
