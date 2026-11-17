<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>会员</title>

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
        <h2 >
            <div v-if="actiontype=='save'">新建会员</div>
            <div v-if="actiontype=='update'">编辑会员</div>

        </h2>
        <div class="description">
        </div>
    </div>


    <table class="grid" cellspacing="1" width="100%">





        <tr>
            <td width="10%" align="right">账号:</td>
            <td width="*">

                    <input v-if="actiontype=='save'"  name="accountname" v-model="huiyuan.accountname" placeholder="账号"
                        v-validate="{required:true,messages:{required:'请输入账号'}}" class="input-txt" type="text"/>

                <div v-if="actiontype=='update'">{{huiyuan.accountname}}</div>

            </td>


        </tr>
        <tr>
            <td width="10%" align="right">账号:</td>
            <td >

                <dw-upload :host-head="hostHead" v-model="huiyuan.touxiang"></dw-upload>
            </td>
        </tr>


        <tr>
            <td align="right">密码:</td>
            <td>
                <input name="password" v-model="huiyuan.password" placeholder="密码"
                       v-validate="{required:true,messages:{required:'请输入密码'}}" class="input-txt" type="password"/>

            </td>
        </tr>



        <tr>
            <td align="right">姓名:</td>
            <td>
                <input name="name" v-model="huiyuan.name" placeholder="姓名"
                       v-validate="{required:true,messages:{required:'请输入姓名'}}" class="input-txt" type="text"/>

            </td>
        </tr>




        <tr>
            <td align="right">性别:</td>
            <td>
                <el-radio-group v-model="huiyuan.sex">
                    <el-radio label="男">男</el-radio>
                    <el-radio label="女">女</el-radio>
                </el-radio-group>

            </td>
        </tr>




        <tr>
            <td align="right">说明:</td>
            <td colspan="3">
                <quill-editor v-model="huiyuan.des" :options="{placeholder: '说明'}"></quill-editor>
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
                errors:"",
                hostHead: '${pageContext.request.contextPath}',
                "huiyuan": {
                    "accountname": "",
                    "password": "",
                    "nickname": "",
                    "name": "",
                    "sex": "",
                    "touxiang": "/upload/nopic.jpg",
                    "des": ""
                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑会员";
                    let url = "admin/huiyuan/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.huiyuan = res.data;
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/huiyuan/save",
                    actionTip: "会员新增成功"
                };
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/huiyuan/update";
                    defaultOptions.actionTip = "会员更新成功";
                }
                const  validRes=this.myValidator.valid(this);
                console.log("valRes",validRes);
                if (!validRes)
                    return ;
                let util = new VueUtil(this);
                let params = {...this.huiyuan};
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
                window.location.href = this.hostHead + "/admin/huiyuanmanager.jsp";
            }
        },
        created() {
            this.load();
        }

    });

</script>