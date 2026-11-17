<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>健康食谱活动管理</title>
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
        <h2>健康食谱活动管理</h2>
        <div class="description">

        </div>
    </div>

    <!-- 搜索控件开始 -->
    <div class="search-options">


        <table cellspacing="0" width="100%">
            <tbody>

            <tr>
                <td>


                    标题:<input name="title" @keyup.enter="search" v-model="title" class="input-txt" type="text"/>


                    <el-button type="danger" @click="search">
                        <i class="el-icon-search"></i>搜索
                    </el-button>
                </td>
            </tr>
            </tbody>
        </table>


    </div>
    <!-- 搜索控件结束 -->

    <div class="clear">
    </div>


    <div class="action-details">
        <el-button-group>

            <el-button @click="deleteRec"  type="danger" icon="el-icon-delete"> 删除</el-button>

        </el-button-group>
    </div>

    <table id="activity" width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
        <thead>
        <tr>
            <th>
                <input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
            </th>


            <th><b>标题</b></th>


            <th><b>开始时间</b></th>


            <th><b>结束日期</b></th>


            <th><b>发布人</b></th>


            <th><b>状态</b></th>


            <th><b>类别</b></th>


            <th>
                操作
            </th>

        </tr>

        </thead>
        <tbody>


        <tr v-for="(activity,index) in  listActivity" :key="activity.id">
            <td>
                <input class="check" name="ids" type="checkbox" v-model="activity.rowSelected"/>


            </td>


            <td>
                {{activity.title}}
            </td>


            <td>
                {{activity.begindate}}
            </td>


            <td>
                {{activity.enddate}}
            </td>



            <td>
                {{activity.pbraccount}}({{activity.pbrname}})
            </td>


            <td>
                <span v-if="activity.state==1">进行中</span>
                <span v-if="activity.state==2">已结束</span>

            </td>


            <td>
                {{activity.typename}}
            </td>


            <td>
                <el-button-group>
                    <a class="el-button el-button--danger" :href="hostHead+'/admin/activityadd.jsp?id='+activity.id"><i
                            class="el-icon-edit"></i>修改</a>
                    <a class="el-button el-button--primary" :href="hostHead+'/admin/activitydetails.jsp?id='+activity.id"><i
                            class="el-icon-info"></i>查看</a>
                </el-button-group>

            </td>
        </tr>

        <tr v-if="listActivity.length==0">
            <td colspan="20">
                没有相关健康食谱活动信息
            </td>
        </tr>


        </tbody>
    </table>
    <el-pagination
            @size-change="pagesizeChange"
            @current-change="pageindexChange"
            :current-page="pageindex"
            :page-sizes="[pagesize]"
            :page-size="pagesize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
    </el-pagination>
    <div class="clear"></div>
</div>
</body>
</html>


<script type="text/javascript">

    Vue.http.options.root = '${pageContext.request.contextPath}';
    Vue.http.options.emulateJSON = true;
    Vue.http.options.xhr = {withCredentials: true};


    let vm = new Vue({

        el: "#app",
        data() {
            return {


                "title": "",


                hostHead: "${pageContext.request.contextPath}",
                selectedAll: false,
                listActivity: [],
                pageindex: 1, //初始页
                pagesize: 10,
                total: 10
            }

        },
        methods: {
            pagesizeChange: function (pagesize) {
                this.pagesize = pagesize;
            },
            pageindexChange: function (pageindex) {
                this.pageindex = pageindex;
                console.log(this.pageindex);
                this.search();
            },
            async search() {
                let url = "admin/activity/list";
                let param = {
                    currentpageindex: this.pageindex,
                    pagesize: this.pagesize,

                    "title": this.title,


                };
                let util = new VueUtil(this);
                console.log("this.pageindex=" + this.pageindex);
                let res = await util.http.post(url, param);
                if (res.data != null) {
                    let pageInfo = res.data.data;
                    this.total = pageInfo.total;
                    this.listActivity = pageInfo.list;
                    console.log(pageInfo);
                }
            },
            async deleteRec() {
                let url = "admin/activity/delete";
                let util = new VueUtil(this);
                let hasChecked = this.listActivity.some(c => {
                    return c.rowSelected == true;
                });
                if (!hasChecked) {
                    util.alert('请选择需要删除的记录', '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }

                let ids = this.listActivity.filter(c => c.rowSelected).map(c => c.id);
                let res = util.confirm('是否要删除数据?', '系统提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).then(() => {
                    util.http.post(url, {ids}, {emulateJSON: false}).then(res => {
                        if (res.data != null && res.data.stateCode > 0) {
                            this.search();
                        }
                    });
                }).catch(() => {
                });
            },
            selectedAllHandler() {
                console.log(this.selectedAll);
                if (this.listActivity != null) {
                    this.listActivity.forEach(c => {
                        c.rowSelected = !this.selectedAll;
                    });
                }
            }
        },
        created() {
            this.search();
        }
    });

</script>
