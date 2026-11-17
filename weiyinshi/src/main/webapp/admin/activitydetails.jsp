<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>活动信息查看</title>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.umd.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>


</head>
<body>
<div id="app">
    <div class="search-title">
        <h2>
            查看活动
        </h2>
        <div class="description">
        </div>
    </div>
    <table cellpadding="0" cellspacing="1" border="1" class="smart-table" width="100%">


        <tr>
            <td width="10%" class="tlabel" align="right">标题:</td>
            <td width="40%">
                {{activity.title}}
            </td>
            <td width="50%" colspan="2" rowspan="6">
                <img width="120" height="120" :src="hostHead+activity.tupian"/>

            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">开始时间:</td>
            <td>
                {{activity.begindate}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">结束日期:</td>
            <td>
                {{activity.enddate}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">发布人:</td>
            <td width="*">
                {{activity.pbrname}}({{activity.pbraccount}})
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">状态:</td>
            <td width="*">
                <span v-if="activity.state==1"> 进行中</span>
                <span v-if="activity.state==2"> 已结束</span>

            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">类别:</td>
            <td width="*">
                {{activity.typename}}
            </td>
        </tr>


    </table>

    <div class="action-details">
        共{{listJoin.length}}人 已参加

    </div>
    <div class="brief-content">


        <table width="100%" border="0" cellspacing="0"
               cellpadding="0" class="ui-record-table">
            <thead>
            <tr>

                <th><b>参与人</b></th>
                <th><b>活动</b></th>
                <th><b>相片</b></th>
                <th><b>状态</b></th>

                <th><b>联系方式</b></th>
                <th><b>操作</b></th>


            </tr>
            </thead>
            <tbody>


            <tr v-for="join in listJoin">

                <td>{{join.joinname}}-{{join.joinaccount}}</td>
                <td>{{join.actname}}</td>
                <td><img width="80" height="70" :src="hostHead+join.photo"/></td>
                <td>
                    <span v-if="join.state==1">等待审核</span>
                    <span v-if="join.state==2">审核通过</span>
                    <span v-if="join.state==3">审核不通过</span>
                </td>
                <td>{{join.mobile}}</td>

                <td>
                    <el-button type="danger" icon="el-icon-check" @click="showSpdlg(join)" v-if="join.state==1">审核
                    </el-button>
                </td>

            </tr>


            <tr v-if="listJoin!=null&&listJoin.length==0">
                <td colspan="5">暂无相关人员参加</td>
            </tr>


            </tbody>
        </table>


    </div>

    <el-dialog title="报名审核" :visible.sync="spdlg">

        <table class="smart-table" width="100%" border="1">

            <tr>
                <td class="tlabel">参与人</td>
                <td>{{join.joinname}}--{{join.joinaccount}}</td>
            </tr>
            <tr>
                <td class="tlabel">相片</td>
                <td><img width="120" height="120" :src="hostHead+join.photo"></td>
            </tr>
            <tr>
                <td class="tlabel">活动</td>
                <td>{{join.actname}}</td>
            </tr>
            <tr>
                <td class="tlabel">电话</td>
                <td>{{join.mobile}}</td>
            </tr>

            <tr>
                <td class="tlabel">结果</td>
                <td>
                    <el-radio-group v-model="state">
                        <el-radio :label="2">通过</el-radio>
                        <el-radio :label="3">不合格</el-radio>
                    </el-radio-group>
                </td>
            </tr>

            <tr>
                <td class="tlabel">描述</td>
                <td>
                    <el-input type="textarea" v-model="spdes" :rows="5" placeholder="请输入说明"></el-input>
                </td>
            </tr>



            <tr>

                <td colspan="2">
                    <el-button type="danger" @click="spHandler" icon="el-icon-plus">提交</el-button>
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
                actiontype: 'save',
                hostHead: '${pageContext.request.contextPath}',
                "activity": {},
                listJoin: [],
                join: {},
                state: 2,
                spdes:"",
                spdlg: false
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                let util = new VueUtil(this);
                if (id != "") {
                    let url = "admin/activity/load";
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.activity = res.data;
                }

            },//end load
            async getJoins() {

                let util = new VueUtil(this);
                let {data: res} = await util.http.post("admin/actjoin/list", {
                    actid: "${param.id}",
                    "ispaged": "-1"

                });
                if (res != null && res.stateCode < 0) {
                    util.message.error(res.des);
                    return;
                }
                this.listJoin = res.data;

            },
            async actoverHandler() {
                let url = "admin/activity/over";
                let util = new VueUtil(this);
                let {data: res} = await util.http.post(url, {id: this.activity.id});
                if (res != null && res.stateCode < 0) {
                    util.message.error(res.des);
                    return;
                }
                util.message.succe("成功");
                this.load();


            },
            showSpdlg(join) {
                this.join = join;
                this.spdlg = true;
            },
            async spHandler() {
                let util = new VueUtil(this);
                let {data: res} = await util.http.post("admin/actjoin/shenhe", {
                    id: this.join.id,
                    "state": this.state,
                    "spdes":this.spdes

                });
                if (res != null && res.stateCode < 0) {
                    util.message.error(res.des);
                    return;
                }
                this.$message.success("成功");
                this.spdlg=false;
                this.load();
                this.getJoins();
            }
        },
        created() {
            this.load();
            this.getJoins();

        }

    });

</script>