<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>我的计划管理</title>
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
        <h2>我的计划管理</h2>
        <div class="description">

        </div>
    </div>

    <!-- 搜索控件开始 -->
    <div class="search-options">


        <table cellspacing="0" width="100%">
            <tbody>

            <tr>
                <td>


                    <input name="title" @keyup.enter="search" v-model="title" class="input-txt" type="text"/>


                    <el-button type="success" icon="el-icon-search" @click="search">搜索</el-button>
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
            <!--{{export-view}}-->
            <el-button type="danger" icon="el-icon-delete" @click="deleteRec">删除</el-button>

        </el-button-group>
    </div>

    <table id="myplan" width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
        <thead>
        <tr>
            <th>
                <input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
            </th>


            <th><b>计划</b></th>


            <th><b>日期</b></th>


            <th><b>会员</b></th>


            <th><b>状态</b></th>



            <th>
                操作
            </th>

        </tr>

        </thead>
        <tbody>


        <tr v-for="(myplan,index) in  listMyplan" :key="myplan.id">
            <td>
                <input class="check" name="ids" type="checkbox" v-model="myplan.rowSelected"/>


            </td>


            <td>
                {{myplan.title}}
            </td>


            <td>
                {{myplan.createtime}}
            </td>


            <td>
                {{myplan.hyname}}--{{myplan.hyaccount}}
            </td>


            <td>
                <span v-if="myplan.state==1">待执行</span>
                <span v-if="myplan.state==2">完成</span>
                <span v-if="myplan.state==3">未完成</span>

            </td>

            <td>
                <el-button-group>

                    <el-button type="warning" @click="showInfodlg(myplan)"><i class="el-icon-info"></i> 详细</el-button>
                </el-button-group>
            </td>
        </tr>

        <tr v-if="listMyplan.length==0">
            <td colspan="20">
                没有相关我的计划信息
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


    <el-dialog :visible.sync="infodlg" title="我的计划详细">

        <table class="smart-table" border="1" cellspacing="1" width="100%">


            <tr>
                <td class="tlabel" width="10%" align="right">计划:</td>
                <td width="*">
                    {{myplan.title}}
                </td>
            </tr>


            <tr>
                <td class="tlabel" align="right">日期:</td>
                <td>
                    {{myplan.createtime}}
                </td>
            </tr>


            <tr>
                <td class="tlabel" width="10%" align="right">会员:</td>
                <td width="*">
                    {{myplan.hyid}}
                </td>
            </tr>


            <tr>
                <td class="tlabel" width="10%" align="right">状态:</td>
                <td width="*">
                    {{myplan.state}}
                </td>
            </tr>


            <tr>
                <td class="tlabel" width="10%" align="right">说明:</td>
                <td width="*">
                    {{myplan.des}}
                </td>
            </tr>


        </table>


    </el-dialog>
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
                listMyplan: [],
                pageindex: 1, //初始页
                pagesize: 10,
                total: 10,
                infodlg: false,
                myplan: {}

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
                let url = "admin/myplan/list";
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
                    this.listMyplan = pageInfo.list;
                    console.log(pageInfo);
                }
            },
            async deleteRec() {
                let url = "admin/myplan/delete";
                let util = new VueUtil(this);
                let hasChecked = this.listMyplan.some(c => {
                    return c.rowSelected == true;
                });
                if (!hasChecked) {
                    util.alert('请选择需要删除的记录', '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }

                let ids = this.listMyplan.filter(c => c.rowSelected).map(c => c.id);
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
            exportHandler() {
                window.location.href = this.hostHead + "/admin/myplan/expor";
            },
            selectedAllHandler() {
                console.log(this.selectedAll);
                if (this.listMyplan != null) {
                    this.listMyplan.forEach(c => {
                        c.rowSelected = !this.selectedAll;
                    });
                }
            },
            showInfodlg(myplan) {
                this.myplan = myplan;
                this.infodlg = true;
            },
        },
        created() {
            this.search();
        }
    });

</script>
