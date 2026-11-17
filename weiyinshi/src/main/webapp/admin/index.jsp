<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="law.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>

    <script type="text/javascript">
        $(function(){
            $(".leftnav h2").click(function(){
                $(this).closest(".leftnav").find("ul").hide();
                $(this).next().slideToggle(200);
                $(this).toggleClass("on");
            });
            $(".leftnav ul li a").click(function(){
                $("#a_leader_txt").text($(this).text());
                $(".leftnav ul li a").removeClass("on");
                $(this).addClass("on");
            })
        });
    </script>
</head>
<body >
<div class="header bg-main">
    <div class="logo margin-big-left fadein-top">
        <h1><img src="${pageContext.request.contextPath}${sessionScope.users.xiangpian}" class="radius-circle rotate-hover" height="50"  />基于微信小程序的健康饮食推荐系统小程序 </h1>
    </div>
    <div class="head-l">

        <div class="user-name">
            <a href="${pageContext.request.contextPath}/admin/accountinfo.jsp" target="main"> ${sessionScope.users.username}-${sessionScope.users.realname}</a>
            (${sessionScope.users.rolename})
        </div>

        <a class="button button-little bg-red" href="${pageContext.request.contextPath}/admin/login.jsp">
            <span class="icon-power-off"></span> 退出登录</a>
    </div>
    <div >

    </div>

</div>
<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>

    <jsp:include page="menu.jsp"></jsp:include>


</div>

<ul class="bread">

    <li><a href="##" id="a_leader_txt">网站信息</a></li>
    <li><b>当前语言：</b><span style="color:red;">中文</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;切换语言：<a href="##">中文</a> &nbsp;&nbsp;<a href="##">英文</a> </li>
</ul>
<div class="admin">
    <iframe scrolling="auto" rameborder="0" src="${pageContext.request.contextPath}/admin/usersmanager.jsp" name="main" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">

</div>
</body>
</html>