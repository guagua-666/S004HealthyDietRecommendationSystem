package com.daowen.controller;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.entity.Acttype;
import com.daowen.entity.Huiyuan;
import com.daowen.service.HuiyuanService;
import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HuiyuanController extends SimpleController {
    @Autowired
    private HuiyuanService huiyuanSrv = null;



    @PostMapping("/admin/huiyuan/delete")
    public JsonResult delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return JsonResult.error(-1, "编号不能为空");
        String where = " where id in(" + join(",", ids) + ")";
        huiyuanSrv.delete(where);
        return JsonResult.success(1, "删除成功");
    }

    @ResponseBody
    @PostMapping("/admin/huiyuan/login")
    public JsonResult login(){
        String accountname=request.getParameter("accountname");
        String password=request.getParameter("password");

        Huiyuan huiyuan=huiyuanSrv.load(MessageFormat.format("where accountname=''{0}'' and password=''{1}''",accountname,password));

        if(huiyuan==null){
            return JsonResult.error(-1,"不合法的账户和密码");
        }
        if(password!=null&&!password.equals(huiyuan.getPassword())){
            return JsonResult.error(-2,"小样注入式攻击？");
        }
        if(huiyuan.getState()==2){
            return JsonResult.error(-3,"账户被加入黑名单不能登录");
        }

        huiyuan.setLogtimes(huiyuan.getLogtimes()+1);
        huiyuanSrv.update(huiyuan);


        return  JsonResult.success(1,"登录成功",huiyuan);

    }
    @ResponseBody
    @PostMapping("/admin/huiyuan/wxlogin")
    public JsonResult wxlogin(){
        String accountname=request.getParameter("accountname");
        String openid=request.getParameter("openid");
        String name=request.getParameter("name");
        String sex=request.getParameter("sex");
        String touxiang=request.getParameter("touxiang");
        if(openid==null||openid.equals("")){
            return JsonResult.error(-1,"请提供微信账户");
        }
        Huiyuan huiyuan=huiyuanSrv.load("where openid='"+openid+"'");
        if(huiyuan==null)
            return JsonResult.success(1,"暂无授权登录");

        return JsonResult.success(2,"已微信授权",huiyuan);

    }



    @ResponseBody
    @PostMapping("/admin/huiyuan/register")
    public JsonResult register() {

        //获取账户名
        String accountname = request.getParameter("accountname");
        //获取密码
        String password = request.getParameter("password");
        //获取登陆次数
        String logtimes = request.getParameter("logtimes");
        //获取性别
        String sex = request.getParameter("sex");
        //获取头像
        String touxiang = request.getParameter("touxiang");

        //获取联系电话
        String mobile = request.getParameter("mobile");
        //获取姓名
        String name = request.getParameter("name");
        String wxname = request.getParameter("wxname");
        String isbind=request.getParameter("isbind");
        String openid=request.getParameter("openid");
        Huiyuan huiyuan = new Huiyuan();
        // 设置账户名
        huiyuan.setAccountname(accountname == null ? "" : accountname);
        // 设置密码
        huiyuan.setPassword(password == null ? "" : password);
        // 设置登陆次数
        huiyuan.setLogtimes(logtimes == null ? 0 : new Integer(logtimes));
        // 设置性别
        huiyuan.setSex(sex==null?"男":sex);

        huiyuan.setState(1);
        // 设置头像
        huiyuan.setTouxiang(touxiang==null?"/upload/nopic.jpg":touxiang);

        huiyuan.setRegdate(new Date());
        huiyuan.setYue(0.0);
        huiyuan.setWxname(wxname==null?"":wxname);
        huiyuan.setIsbind(isbind==null?0:new Integer(1));
        huiyuan.setOpenid(openid==null?"":openid);
        // 设置说明
        huiyuan.setDes("");
        // 设置联系电话
        huiyuan.setMobile(mobile == null ? "" : mobile);
        // 设置姓名
        huiyuan.setName(name == null ? "" : name);
        if(huiyuanSrv.isExist("where accountname='"+accountname+"'")){
            return JsonResult.error(-1,"账户已经存在");
        }
        huiyuanSrv.save(huiyuan);
        return JsonResult.success(1,"账户注册成功",huiyuan);
    }


    @ResponseBody
    @PostMapping("/admin/huiyuan/modifypwd")
    public JsonResult modifypwd(){
        String accountname=request.getParameter("accountname");
        String newpwd = request.getParameter("newpwd");
        String oldpwd = request.getParameter("oldpwd");
        if(accountname==null||accountname.equals("")){
            return JsonResult.error(-1,"账户参数异常");
        }
        Huiyuan huiyuan=huiyuanSrv.load("where accountname='"+accountname+"'");
        if(huiyuan==null){
            return JsonResult.error(-2,"不存在的账户");
        }
        if(!huiyuan.getPassword().equals(oldpwd)){
            return JsonResult.error(-3,"原始密码不正确");
        }
        huiyuan.setPassword(newpwd);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"密码修改成功");


    }

    @ResponseBody
    @PostMapping("/admin/huiyuan/modifyinfo")
    public JsonResult modifyinfo(){
        String accountname=request.getParameter("accountname");
        String mobile = request.getParameter("mobile");
        String sex = request.getParameter("sex");
        String name = request.getParameter("name");
        String des = request.getParameter("des");
        if(accountname==null||accountname.equals("")){
            return JsonResult.error(-1,"账户参数异常");
        }
        Huiyuan huiyuan=huiyuanSrv.load("where accountname='"+accountname+"'");
        if(huiyuan==null){
            return JsonResult.error(-2,"不存在的账户");
        }
        huiyuan.setName(name);
        huiyuan.setSex(sex);
        huiyuan.setMobile(mobile);
        huiyuan.setDes(des);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"账户修改成功",huiyuan);

    }

    @ResponseBody
    @PostMapping("/admin/huiyuan/chongzhi")
    public JsonResult chongzhi(){
        String id=request.getParameter("id");
        String fee=request.getParameter("fee");
        if(id==null)
            return JsonResult.error(-1,"id异常");
        if(fee==null)
            return JsonResult.error(-2,"请提供充值金额");
        Huiyuan huiyuan=huiyuanSrv.load("where id="+id);
        if(huiyuan==null)
            return JsonResult.error(-4,"账户异常");
        huiyuan.setYue(huiyuan.getYue()+Integer.parseInt(fee));
        huiyuanSrv.update(huiyuan);
       return JsonResult.success(1,"充值成功",huiyuan);

    }



    @ResponseBody
    @PostMapping("/admin/huiyuan/modifyphoto")
    public JsonResult modifyphoto(){
        String id=request.getParameter("id");
        String touxiang = request.getParameter("touxiang");

        if(id==null||id.equals("")){
            return JsonResult.error(-1,"账户参数异常");
        }
        Huiyuan huiyuan=huiyuanSrv.loadPlus(new Integer(id));
        if(huiyuan==null){
            return JsonResult.error(-2,"不存在的账户");
        }
        huiyuan.setTouxiang(touxiang);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"修改头像成功",huiyuan);

    }


    @PostMapping("/admin/huiyuan/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1,"编号不能为空");
        Huiyuan huiyuan = huiyuanSrv.load(new Integer(id));
        if (huiyuan == null)
            return JsonResult.error(-2,"非法的数据");
        //获取账户名
        String accountname = request.getParameter("accountname");
        //获取性别
        String sex = request.getParameter("sex");
        //获取头像
        String touxiang = request.getParameter("touxiang");
        //获取说明
        String des = request.getParameter("des");
        //获取联系电话
        String mobile = request.getParameter("mobile");
        //获取姓名
        String name = request.getParameter("name");
        SimpleDateFormat sdfhuiyuan = new SimpleDateFormat("yyyy-MM-dd");

        // 设置性别
        huiyuan.setSex(sex);
        // 设置头像
        huiyuan.setTouxiang(touxiang);
        // 设置说明
        huiyuan.setDes(des);
        // 设置联系电话
        huiyuan.setMobile(mobile);
        // 设置姓名
        huiyuan.setName(name);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"更新成功",huiyuan);

    }


    @ResponseBody
    @PostMapping("/admin/huiyuan/load")
    public JsonResult load() {
        //
        String id = request.getParameter("id");
        if (id == null || id == "")
            return JsonResult.error(-1, "编号不存在");
        Huiyuan huiyuan = huiyuanSrv.load("where id=" + id);
        if (huiyuan == null)
            return JsonResult.error(-2, "不存在的账号");
        return JsonResult.success(1,"成功",huiyuan);

    }


    @PostMapping("/admin/huiyuan/black")
    public JsonResult black() {
        //
        String id = request.getParameter("id");
        if (id == null || id == "")
            return JsonResult.error(-1, "编号不存在");
        Huiyuan huiyuan = huiyuanSrv.load("where id=" + id);
        if (huiyuan == null)
            return JsonResult.error(-2, "不存在的账号");
        huiyuan.setState(2);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"成功");

    }

    @PostMapping("/admin/huiyuan/white")
    public JsonResult white() {
        //
        String id = request.getParameter("id");
        if (id == null || id == "")
            return JsonResult.error(-1, "编号不存在");
        Huiyuan huiyuan = huiyuanSrv.load("where id=" + id);
        if (huiyuan == null)
            return JsonResult.error(-2, "不存在的账号");
        huiyuan.setState(1);
        huiyuanSrv.update(huiyuan);
        return JsonResult.success(1,"成功");

    }


    @PostMapping("/admin/huiyuan/info")
    public JsonResult info() {
        //
        String id = request.getParameter("id");
        String accountname = request.getParameter("accountname");
        if (id == null && accountname == null)
            return JsonResult.error(-1, "参数不存在");

        Huiyuan huiyuan =null;
        if(id!=null&&id!=""){
            huiyuan=huiyuanSrv.loadPlus(new Integer(id));
            if (huiyuan == null)
                return JsonResult.error(-2, "不存在的账号");
        }
        if(accountname!=null&&accountname!=""){
            HashMap map = new HashMap();
            map.put("accountname",accountname);
            huiyuan=huiyuanSrv.loadPlus(map);
            if(huiyuan==null)
                return JsonResult.error(-2, "不存在的账号");
        }

        return JsonResult.success(1,"成功",huiyuan);

    }


    @ResponseBody
    @PostMapping("/admin/huiyuan/topcount")
    public JsonResult topcount() {
        HashMap<String, Object> map = new HashMap<>();
        String topcount=request.getParameter("topcount");
        if(topcount!=null)
            map.put("topcount",topcount);
        else
            map.put("topcount",5);
        map.put("order"," order by yue desc");
        return JsonResult.success(1,"获取会员信息",huiyuanSrv.getEntityPlus(map));
    }

    @ResponseBody
    @PostMapping("/admin/huiyuan/list")
    public JsonResult list() {
        int pageindex = 1;
        int pagesize = 10;
        String ispaged = request.getParameter("ispaged");

        // 获取当前分页
        String accountname = request.getParameter("accountname");
        HashMap map = new HashMap();
        if (accountname != null)
            map.put("accountname",accountname);

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
            List<Huiyuan> listHuiyuan = huiyuanSrv.getEntityPlus(map);
            PageInfo<Huiyuan> pageInfo = new PageInfo<>(listHuiyuan);
            return JsonResult.success(1, "成功", pageInfo);
        }
        return JsonResult.success(1,"获取会员信息",huiyuanSrv.getEntityPlus(map));
    }

}
