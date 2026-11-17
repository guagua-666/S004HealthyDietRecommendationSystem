<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="law.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>栏目管理信息</title>

    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>

</head>
<body>

<div id="app">
<div class="search-title">
    <h2>栏目管理</h2>
    <div class="description">
        <a href="${pageContext.request.contextPath}/admin/lanmuadd.jsp">新建栏目</a>
    </div>
</div>
<!-- 搜索控件开始 -->
<div class="search-options">

        <table cellspacing="0" width="100%">
            <tbody>
            <tr>
                <td>
                    名称
                    <input name="name" @keyup.enter="search" v-model="name" class="input-txt" type="text" id="name"/>

                    <button @click="search" class="btn btn-danger">
                        <i class="fa fa-search"></i>搜索
                    </button>
                </td>
            </tr>
            </tbody>
        </table>

</div>
<!-- 搜索控件结束 -->
<div class="clear">
</div>


<div class="clear"></div>
<table  width="100%" border="0" cellspacing="0"
        cellpadding="0" class="ui-record-table">
    <thead>
    <tr>

        <th><b>名称</b></th>

        <th><b>子栏目</b></th>

    </tr>
    </thead>
    <tbody>

        <tr v-if="listLanmu.length==0">
            <td colspan="20">没有相关类别</td>
        </tr>


        <tr v-for="lanmu in listLanmu" :key="lanmu.id">

            <td >
                <div class="cst-group-btn">
                    <div class="it"><a  :href="hostHead+'/admin/lanmuadd.jsp?id='+lanmu.id">{{lanmu.name}}</a>
                       <span v-if="lanmu.type==1">（健康食谱）</span>
                       <span v-if="lanmu.type==2">（商品）</span>

                    </div>
                    <div  @click="deleteLanmu(lanmu.id)"  class="it del-btn">
                        ×
                    </div>
                    <div class="it">
                        <a  :href="hostHead+'/admin/subtypeadd.jsp?parentid='+lanmu.id"><i class="fa fa-plus"></i>新增子栏目</a>
                    </div>


                </div>


            </td>

            <td >
                <div class="subtype-list">

                            <div v-for="subtype in lanmu.subtypes" :key="subtype.id" class="lm-item">
                                <a  :href="hostHead+'/admin/subtypeadd.jsp?parentid='+lanmu.id+'&id='+subtype.id"> <div class="text ">{{subtype.name}}</div></a>
                                <div @click="deleteSubtype(subtype.id)"  class="del-btn">×</div>
                            </div>

                </div>

                <span v-if="lanmu.subtypes.length==0">
                    暂无子栏目
                </span>

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


    let vm=new Vue({

        el:"#app",
        data(){
            return {
                "name":"",
                hostHead:"${pageContext.request.contextPath}",
                listLanmu:[],
            }

        },
        methods:{
            async search(){
                let url="admin/lanmu/list";
                let param={
                    "name":this.name,
                };
                let util=new VueUtil(this);
                console.log("this.pageindex="+this.pageindex);
                let {data:res}=await util.http.post(url,param);
                if(res!=null){

                    this.listLanmu=res.data;
                    console.log(this.listLanmu);
                }
            },
            async deleteLanmu(id){
                let url="admin/lanmu/delete";
                let util=new VueUtil(this);

                let res= util.confirm('是否要删除数据?', '系统提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).then(()=>{
                    util.http.post(url, {id},{emulateJSON:false}).then(res=>{
                        if (res.data != null && res.data.stateCode > 0) {
                            this.search();
                        }
                    });
                }).catch(()=>{});
            },
            async deleteSubtype(id){
                let url="admin/subtype/delete";
                let util=new VueUtil(this);

                let res= util.confirm('是否要删除数据?', '系统提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).then(()=>{
                    util.http.post(url, {id},{emulateJSON:false}).then(res=>{
                        if (res.data != null && res.data.stateCode > 0) {
                            this.search();
                        }
                    });
                }).catch(()=>{});
            }

        },
        created(){
            this.search();
        }
    });

</script>

