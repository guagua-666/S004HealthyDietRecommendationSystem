<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>页面设置项</title>

    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.umd.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/quill.min.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/vue-quill-editor.js"></script>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.core.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.snow.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.bubble.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>


</head>

<body>
<div id="app">

    <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: hostHead+'/admin/index.jsp' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item><a :href="hostHead+'/admin/pagesettingmanager.jsp'">页面管理</a></el-breadcrumb-item>
        <el-breadcrumb-item>新增板块</el-breadcrumb-item>
    </el-breadcrumb>

    <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
        <thead>
        <tr>

            <th><b>板块</b></th>
            <th><b>类型</b></th>
            <th><b>是否加入</b></th>
            <th>
                操作
            </th>
        </tr>
        </thead>
        <tbody>

        <tr v-show="listLanmu.length==0">
            <td colspan="20">
                没有相关板块信息
            </td>
        </tr>

        <tr v-for="lanmu in listLanmu" :key="lanmu.id">

            <td>{{lanmu.lmname}}</td>
            <td>
                <span v-if="lanmu.lmtype==1">健康食谱</span>
                <span v-if="lanmu.lmtype==2">商品</span>
                <span v-if="lanmu.lmtype==3">视频</span>
                <span v-if="lanmu.lmtype==4">下载资源</span>
            </td>
            <td>
                <span v-if="lanmu.pageid==null">未加入</span>
                <span v-else>已加入</span>
            </td>
            <td>
                <span v-if="lanmu.pageid==null" title="加入板块" @click="addToPage(lanmu.lmid,pageid)" class="btn btn-danger" ><i class="fa fa-plus"></i>加入</span>

            </td>
        </tr>

        </tbody>
    </table>
</div>


</body>
</html>

<script type="text/javascript">

    Vue.http.options.root = '${pageContext.request.contextPath}';
    Vue.http.options.emulateJSON = true;
    Vue.http.options.xhr = {withCredentials: true};
    Vue.use(window.VueQuillEditor);
    let vm = new Vue({
        el: "#app",
        data(){
            return{
                hostHead:"${pageContext.request.contextPath}",
                name:"",
                pageid:0,
                listLanmu:[]

            }
        },
        created(){
            this.search();
        },

        methods:{

            async  search(){
                this.pageid="${param.pageid}";
                console.log("pageid=",this.pageid);
                if(this.pageid!=0){
                    let url="admin/psitem/load";
                    let {data:res}=await this.$http.post(url,{pageid:this.pageid});
                    console.log("res",res);
                    if(res!=null&&res.data!=null)
                        this.listLanmu=res.data;
                }
            },
            async addToPage(lmid,pageid){

                let url="admin/psitem/save";
                let {data:res}= await this.$http.post(url, {pageid,lmid},{emulateJSON:false});
                if(res.stateCode<=0){
                    this.$alert('提交异常', '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }
                this.search();

            }


        }

    });

</script>