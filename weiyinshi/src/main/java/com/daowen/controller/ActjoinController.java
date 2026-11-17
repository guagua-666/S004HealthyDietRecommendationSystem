package com.daowen.controller;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;

import com.daowen.entity.Activity;
import com.daowen.util.JsonResult;
import com.daowen.vo.ActjoinVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jdk.nashorn.internal.scripts.JS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.daowen.entity.Actjoin;
import com.daowen.service.ActjoinService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;


/**************************
 *
 * 报名控制
 *
 */
@Controller
public class ActjoinController {
    @Autowired
    private ActjoinService actjoinSrv = null;

    @Autowired
    private HttpServletRequest request;

    @PostMapping("/admin/actjoin/save")
    @ResponseBody
    public JsonResult save() {
        String forwardurl = request.getParameter("forwardurl");
        // 验证错误url
        String errorurl = request.getParameter("errorurl");
        String actid = request.getParameter("actid");

        String hyid = request.getParameter("hyid");

        Actjoin actjoin = new Actjoin();
        actjoin.setState(1);
        actjoin.setScore(0.0);
        actjoin.setActid(actid == null ? 0 : new Integer(actid));
        actjoin.setHyid(hyid==null?0:new Integer(hyid));
        Boolean validateresult = actjoinSrv.isExist(MessageFormat.format("where actid={0} and hyid=''{1}''  ",actid,hyid));
        if (validateresult) {
            return JsonResult.success(-1,"用户已经参加过了");
        }
        actjoinSrv.save(actjoin);


        return JsonResult.success(1,"参加成功");
    }

    @PostMapping("/admin/actjoin/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "ids不能为空");
        String spliter = ",";
        String where = " where id  in(" + String.join(spliter, ids) + ")";
        actjoinSrv.delete(where);
        return JsonResult.success(1, "不能为空");
    }

    @ResponseBody
    @PostMapping("/admin/actjoin/shenhe")
    public JsonResult shenhe() {
        String id=request.getParameter("id");
        String state=request.getParameter("state");
        String spdes=request.getParameter("spdes");
        if (id == null)
            return JsonResult.error(-1, "ID不能为空");
        Actjoin actjoin = actjoinSrv.load(new Integer(id));
        if (actjoin == null)
            return JsonResult.error(-2, "非法数据");
        actjoin.setState(Integer.parseInt(state));
        actjoin.setSpdes(spdes==null?"":spdes);
        actjoinSrv.update(actjoin);
        return JsonResult.success(1, "成功");
    }


    @ResponseBody
    @PostMapping("/admin/actjoin/list")
    public JsonResult list() {

        HashMap<String, Object> map = new HashMap<>();
        String ispaged = request.getParameter("ispaged");

        String hyid = request.getParameter("hyid");
        String actid=request.getParameter("actid");
        String actname=request.getParameter("actname");
        String state=request.getParameter("state");


        if (hyid != null)
            map.put("hyid", hyid);

        if(actid!=null)
            map.put("actid",actid);
        if(actname!=null)
            map.put("actname",actname);

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
            List<ActjoinVo> listActivity = actjoinSrv.getEntityPlus(map);
            PageInfo<ActjoinVo> pageInfo = new PageInfo<ActjoinVo>(listActivity);
            return JsonResult.success(1, "成功", pageInfo);
        }

        return JsonResult.success(1, "获取成功", actjoinSrv.getEntityPlus(map));


    }





}
