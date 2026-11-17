<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>页面设置管理</title>
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
        <h2>页面设置管理</h2>
        <div class="description">
            <a href="${pageContext.request.contextPath}/admin/pagesettingadd.jsp">新建页面设置</a>
        </div>
    </div>

    <!-- 搜索控件开始 -->
    <div class="search-options">


        <table cellspacing="0" width="100%">
            <tbody>

            <tr>
                <td>


                    <input name="name" @keyup.enter="search" v-model="name" class="input-txt" type="text"/>


                    <button class="btn btn-danger" @click="search">
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


    <div class="action-details">
        <div class="btn-group">

            <!--{{export-view}}-->
            <span class="btn btn-success" @click="deleteRec">删除</span>
        </div>
    </div>

    <table id="pagesetting" width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
        <thead>
        <tr>
            <th>
                <input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
            </th>


            <th><b>名称</b></th>


            <th>
                操作
            </th>

        </tr>

        </thead>
        <tbody>


        <tr v-for="(pagesetting,index) in  listPagesetting" :key="pagesetting.id">
            <td>
                <input class="check" name="ids" type="checkbox" v-model="pagesetting.rowSelected"/>


            </td>


            <td>
                {{pagesetting.name}}
            </td>


            <td>
                <div class="btn-group">
                    <a class="btn btn-danger" :href="hostHead+'/admin/pagesettingadd.jsp?id='+pagesetting.id"><i
                            class="fa fa-edit"></i>编辑</a>
                    <a class="btn btn-success" :href="hostHead+'/admin/psitemmanager.jsp?pageid='+pagesetting.id"><i class="fa fa-cog"></i>设置</a>
                </div>
            </td>
        </tr>

        <tr v-if="listPagesetting.length==0">
            <td colspan="20">
                没有相关页面设置信息
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


                "name": "",


                hostHead: "${pageContext.request.contextPath}",
                selectedAll: false,
                listPagesetting: [],
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
                let url = "admin/pagesetting/list";
                let param = {
                    currentpageindex: this.pageindex,
                    pagesize: this.pagesize,

                    "name": this.name,


                };
                let util = new VueUtil(this);
                console.log("this.pageindex=" + this.pageindex);
                let res = await util.http.post(url, param);
                if (res.data != null) {
                    let pageInfo = res.data.data;
                    this.total = pageInfo.total;
                    this.listPagesetting = pageInfo.list;
                    console.log(pageInfo);
                }
            },
            async deleteRec() {
                let url = "admin/pagesetting/delete";
                let util = new VueUtil(this);
                let hasChecked = this.listPagesetting.some(c => {
                    return c.rowSelected == true;
                });
                if (!hasChecked) {
                    util.alert('请选择需要删除的记录', '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }

                let ids = this.listPagesetting.filter(c => c.rowSelected).map(c => c.id);
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
                if (this.listPagesetting != null) {
                    this.listPagesetting.forEach(c => {
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
