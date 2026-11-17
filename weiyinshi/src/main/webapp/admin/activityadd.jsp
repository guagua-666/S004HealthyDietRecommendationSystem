<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>健康食谱活动</title>

    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
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
    <div class="search-title">
        <h2>
            <div v-if="actiontype=='save'">新建健康食谱活动</div>
            <div v-if="actiontype=='update'">编辑健康食谱活动</div>
        </h2>
        <div class="description">
        </div>
    </div>


    <table class="grid" cellspacing="1" width="100%">


        <tr>
            <td width="10%" align="right">标题:</td>
            <td width="*">
                <input name="title" v-model="activity.title" placeholder="标题"
                       v-validate="{required:true,messages:{required:'请输入标题'}}" class="input-txt" type="text"/>


            </td>
        </tr>


        <tr>
            <td width="10%" align="right">开始时间:</td>
            <td width="*">
                <el-date-picker format="yyyy-MM-dd" value-format="yyyy-MM-dd"    v-model="activity.begindate" type="date" placeholder="选择日期">
                </el-date-picker>
            </td>
        </tr>


        <tr>
            <td width="10%" align="right">结束日期:</td>
            <td width="*">
                <el-date-picker format="yyyy-MM-dd" value-format="yyyy-MM-dd"   v-model="activity.enddate" type="date" placeholder="选择日期">
                </el-date-picker>
            </td>
        </tr>


        <tr>
            <td align="right">图片:</td>
            <td>

                <dw-upload :host-head="hostHead" v-model="activity.tupian"></dw-upload>
            </td>
        </tr>




        <tr>
            <td align="right">类别:</td>
            <td>
                <dw-dropdownlist name="typeid" v-model="activity.typeid"
                                 :url="hostHead+'/admin/acttype/list?ispaged=-1'"></dw-dropdownlist>

            </td>
        </tr>

        <tr>
            <td width="10%" align="right">招募人数:(人)</td>
            <td width="*">
                <input name="maxcount" v-model="activity.maxcount" placeholder="招募人数"
                       v-validate="{required:true,number:true,messages:{required:'请输入招募人数',number:'请输入正确的招募人数'}}" class="input-txt" type="text"/>


            </td>
        </tr>




        <tr>
            <td align="right">介绍:</td>
            <td colspan="3">
                <quill-editor v-model="activity.des" :options="{placeholder: '介绍'}"></quill-editor>
            </td>
        </tr>


        <tr>
            <td colspan="4">

                <button @click="submitHandler" class="btn btn-danger"><i class="fa fa-check"></i>提交</button>

            </td>
        </tr>


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
        data() {
            return {

                actiontype: 'save',
                hostHead: '${pageContext.request.contextPath}',
                fileList: [],
                errors: {},
                "activity": {
                    "title": "",
                    "begindate": "",
                    "enddate": "",
                    "tupian": "/upload/nopic.jpg",
                    "pubren": "${sessionScope.users.id}",
                    "state": "1",
                    "typeid": "1",
                    "tid":1,
                    "des": "",
                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                this.activity.begindate = new Date().toLocaleDateString().split('/').join('-');
                this.activity.enddate = new Date().toLocaleDateString().split('/').join('-');
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑健康食谱活动";
                    let url = "admin/activity/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null) {
                        this.activity = res.data;
                    }
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/activity/save",
                    actionTip: "健康食谱活动新增成功"
                };
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/activity/update";
                    defaultOptions.actionTip = "健康食谱活动更新成功";
                }
                const validRes = this.myValidator.valid(this);
                console.log("valRes", validRes);
                if (!validRes)
                    return;
                let util = new VueUtil(this);
                let params = {...this.activity};
                let {data: res} = await util.http.post(defaultOptions.url, params);
                if (res.stateCode <= 0) {
                    util.alert(res.des, '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }
                util.message({
                    message: defaultOptions.actionTip,
                    type: 'success',
                    duration: 2000
                });
                window.location.href = this.hostHead + "/admin/activitymanager.jsp";
            },

        },
        created() {
            this.load();
        }

    });

</script>