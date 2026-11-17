<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



 <h2><span class="icon-pencil-square-o"></span>饮食活动管理</h2>
  <ul>
      <li>
          <a  href="${pageContext.request.contextPath}/admin/myplanmanager.jsp" target="main"><i class="fa fa-calendar"></i>每日计划管理</a>
      </li>
      <li>
          <a  href="${pageContext.request.contextPath}/admin/sportlogmanager.jsp" target="main"><i class="fa fa-calendar"></i>体检记录</a>
      </li>

      <li>
          <a target="main" href="${pageContext.request.contextPath}/admin/sleeplogmanager.jsp"><i class="fa fa-calendar"></i>健康贴士记录</a>
      </li>

      <li>
          <a target="main" href="${pageContext.request.contextPath}/admin/eatlogmanager.jsp"><i class="fa fa-calendar"></i>饮食打卡记录</a>
      </li>



      <li>
          <a  href="${pageContext.request.contextPath}/admin/activitymanager.jsp" target="main"><i class="fa fa-calendar"></i>健康活动管理</a>
      </li>
      <li>
          <a  href="${pageContext.request.contextPath}/admin/activityadd.jsp" target="main"><i class="fa fa-calendar"></i>发布活动</a>
      </li>

      <li>
          <a  href="${pageContext.request.contextPath}/admin/acttypemanager.jsp" target="main"><i class="fa fa-calendar"></i>食谱活动类别管理</a>
      </li>

  </ul>


<h2><span class="icon-music"></span>健康食谱管理</h2>
<ul style="display:block">


    <li>
        <a  href="${pageContext.request.contextPath}/admin/xinximanager.jsp" target="main"><i class="fa fa-calendar"></i>健康食谱管理</a>
    </li>
    <li>
        <a  href="${pageContext.request.contextPath}/admin/xinxiadd.jsp" target="main"><i class="fa fa-calendar"></i>发布健康食谱</a>
    </li>
    <li>
        <a  href="${pageContext.request.contextPath}/admin/lanmumanager.jsp" target="main"><i class="fa fa-calendar"></i>栏目管理</a>
    </li>

    <li><a href="${pageContext.request.contextPath}/admin/leavewordmanager.jsp" target="main"><i class="fa fa-calendar"></i>用户咨询管理</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/jiaodiantumanager.jsp" target="main"><i class="fa fa-calendar"></i>轮播图</a></li>

</ul>



   <h2><span class="icon-user"></span>人员管理</h2>
  <ul>
      <li><a href="${pageContext.request.contextPath}/admin/huiyuanmanager.jsp" target="main"><i class="fa fa-calendar"></i>会员管理</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/usersmanager.jsp" target="main"><i class="fa fa-calendar"></i>后台用户管理</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/usersadd.jsp" target="main"><i class="fa fa-calendar"></i>新增后台用户</a></li>

  </ul>

<h2><span class="icon-user"></span>账户设置</h2>
<ul>
    <li><a href="${pageContext.request.contextPath}/admin/accountinfo.jsp" target="main"><i class="fa fa-calendar"></i>账户信息</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/modifyinfo.jsp" target="main"><i class="fa fa-calendar"></i>编辑账户</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/modifypw.jsp" target="main"><i class="fa fa-calendar"></i>修改密码</a></li>
</ul>
 
