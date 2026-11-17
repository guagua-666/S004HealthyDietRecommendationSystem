package com.daowen.controller;

import java.text.MessageFormat;
import java.util.List;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.entity.Comment;
import com.daowen.service.CommentService;
import com.daowen.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;
import org.springframework.web.bind.annotation.ResponseBody;

/**************************
 *
 * 评论表控制
 *
 */
@Controller
public class CommentController extends SimpleController {
    @Autowired
    private CommentService commentSrv = null;

    @Override
    @RequestMapping("/admin/commentmanager.do")
    public void mapping(HttpServletRequest request, HttpServletResponse response) {
        mappingMethod(request, response);
    }

    /********************************************************
     ******************信息注销监听支持*****************************
     *********************************************************/
    public void delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return;
        String spliter = ",";
        String SQL = " where id in(" + join(spliter, ids)
                + ")";
        System.out.println("sql=" + SQL);
        commentSrv.delete(SQL);
    }

    @ResponseBody
    @PostMapping("/admin/comment/delete")
    public JsonResult ajaxdelete() {
        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1,"参数异常");
        commentSrv.delete("where id="+id);
        return JsonResult.success(1,"删除成功");
    }

   @ResponseBody
   @PostMapping("/admin/comment/save")
    public JsonResult save() {
        String forwardurl = request.getParameter("forwardurl");
        //获取备注
        String commentor = request.getParameter("commentor");
        //获取备注
        String commenttime = request.getParameter("commenttime");
        String type=request.getParameter("type");
        //获取内容
        String dcontent = request.getParameter("dcontent");
        //获取宿主id
        String belongid = request.getParameter("belongid");
        //获取图片
        String pics = request.getParameter("pics");
        SimpleDateFormat sdfcomment = new SimpleDateFormat("yyyy-MM-dd");
        Comment comment = new Comment();
        // 设置备注
        comment.setCommentor(commentor == null ? "" : commentor);
        // 设置备注
	   comment.setCommenttime(new Date());
        // 设置内容
        comment.setDcontent(dcontent == null ? "" : dcontent);

        comment.setTablename(type);
        // 设置宿主id
        comment.setBelongid(belongid == null ? 0 : new Integer(belongid));
        // 设置图片
        comment.setPics(pics == null ? "" : pics);
	    System.out.println("pics="+pics);
        commentSrv.save(comment);
        return JsonResult.success(1,"成功");

    }

    @ResponseBody
    @PostMapping("/admin/spcomment/list")
    public JsonResult splist(){
        String spid=request.getParameter("spid");

        if(spid==null|spid.equals("")){
            return JsonResult.error(-1,"spid非法");
        }

        String sql=MessageFormat.format(" select c.*,h.accountname,h.name,h.touxiang from spcomment c ,huiyuan h,shorder o where  o.id=c.orderid and o.purchaser=h.id and c.spid={0} ",spid);
        List<HashMap<String, Object>> listComment = commentSrv.queryToMap(sql);
        return  JsonResult.success(1,"获取评论信息",listComment);

    }

    @ResponseBody
    @PostMapping("/admin/comment/list")
    public JsonResult list(){
        String belongid=request.getParameter("belongid");
        String type=request.getParameter("type");
        if(belongid==null|belongid.equals("")){
            return JsonResult.error(-1,"宿主编号非法");
        }
        if(type==null|type.equals("")){
            return JsonResult.error(-1,"类型非法");
        }

       String sql=MessageFormat.format("select c.*,h.accountname,h.name,h.touxiang from comment c ,huiyuan h where h.accountname=c.commentor and belongid={0} and tablename=''{1}'' ",belongid,type);
        List<HashMap<String, Object>> listComment = commentSrv.queryToMap(sql);
       return  JsonResult.success(1,"获取评论信息",listComment);


    }


    /******************************************************
     ***********************加载内部支持*********************
     *******************************************************/
    public void load() {
        //
        String id = request.getParameter("id");
        String actiontype = "save";
        dispatchParams(request, response);
        if (id != null) {
            Comment comment = commentSrv.load("where id=" + id);
            if (comment != null) {
                request.setAttribute("comment", comment);
            }
            actiontype = "update";
            request.setAttribute("id", id);
        }
        request.setAttribute("actiontype", actiontype);
        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/commentadd.jsp";
        }
        forward(forwardurl);
    }

    /******************************************************
     ***********************数据绑定内部支持*********************
     *******************************************************/
    public void get() {
        String filter = "where 1=1 ";
        String title = request.getParameter("title");
        if (title != null)
            filter += "  and title like '%" + title + "%'  ";
        //
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
        List<Comment> listcomment = commentSrv.getPageEntitys(filter, pageindex, pagesize);
        int recordscount = commentSrv.getRecordCount(filter == null ? "" : filter);
        request.setAttribute("listcomment", listcomment);
        PagerMetal pm = new PagerMetal(recordscount);
        //设置尺寸
        pm.setPagesize(pagesize);
        //设置当前显示页
        pm.setCurpageindex(pageindex);
        // 设置分页信息
        request.setAttribute("pagermetal", pm);
        //分发请求参数
        dispatchParams(request, response);
        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/commentmanager.jsp";
        }
        forward(forwardurl);
    }

    public void query() {
        String sql = " select * from comment    ";
        List<HashMap<String, Object>> listComment = commentSrv.queryToMap(sql);
        request.setAttribute("listComment", listComment);
        // 分发请求参数
        dispatchParams(request, response);
        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/commentmanager.jsp";
        }
        forward(forwardurl);
    }
}
