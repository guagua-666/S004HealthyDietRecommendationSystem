<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>后台用户</title>

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
            新建后台用户
        </h2>
        <div class="description">
        </div>
    </div>


    <table class="smart-table" border="1" cellspacing="1" width="100%">


        <tr>
            <td class="tlabel" width="10%" align="right">用户名:</td>
            <td width="*">
                <input name="username" v-model="users.username" placeholder="用户名"
                       v-validate="{required:true,messages:{required:'请输入用户名'}}" class="input-txt" type="text"/>
            </td>
            <td colspan="2" rowspan="6">

                <dw-upload :host-head="hostHead" v-model="users.xiangpian"></dw-upload>
            </td>
        </tr>


        <tr>
            <td class="tlabel" width="10%" align="right">密码:</td>
            <td width="*">
                <input name="password" v-model="users.password" placeholder="密码"
                       v-validate="{required:true,messages:{required:'请输入密码'}}" class="input-txt" type="password"/>
            </td>
        </tr>

        <tr>
            <td class="tlabel" align="right">角色:</td>
            <td>
                <dw-dropdownlist name="roleid" v-model="users.roleid"
                                 :url="hostHead+'/admin/sysrole/list?ispaged=-1'"></dw-dropdownlist>

            </td>
        </tr>


        <tr>
            <td class="tlabel" width="10%" align="right">姓名:</td>
            <td width="*">
                <input name="realname" v-model="users.realname" placeholder="姓名"
                       v-validate="{required:true,messages:{required:'请输入姓名'}}" class="input-txt" type="text"/>
            </td>
        </tr>




        <tr>
            <td  class="tlabel" align="right">性别:</td>
            <td width="*">
                <el-radio-group v-model="users.sex">
                    <el-radio label="男"></el-radio>
                    <el-radio label="女"></el-radio>
                </el-radio-group>

            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">电话:</td>
            <td width="*">
                <input name="tel" v-model="users.tel" placeholder="电话"
                       v-validate="{required:true,messages:{required:'请输入电话'}}" class="input-txt" type="text"/>
            </td>
        </tr>



        <tr>
            <td class="tlabel" align="right">昵称:</td>
            <td width="*">
                <input name="nickname" v-model="users.nickname" placeholder="昵称"
                       v-validate="{required:true,messages:{required:'请输入昵称'}}" class="input-txt" type="text"/>
            </td>

            <td class="tlabel" align="right">邮箱:</td>
            <td width="*">
                <input name="email" v-model="users.email" placeholder="邮箱"
                       v-validate="{required:true,messages:{required:'请输入邮箱'}}" class="input-txt" type="text"/>
            </td>
        </tr>

        <tr>
            <td colspan="4">

                <el-button icon="el-icon-check" @click="submitHandler" type="danger">提交</el-button>

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
                errors: {},
                "users": {
                    "username": "",
                    "password": "",
                    "sex": "男",
                    "tel": "",
                    "roleid":1,
                    "realname": "",
                    "nickname": "",
                    "email": "",
                    "creator": "${sessionScope.users.username}",
                    "xiangpian": "/upload/nopic.jpg",
                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑后台用户";
                    let url = "admin/users/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.users = res.data;
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/users/save",
                    actionTip: "后台用户新增成功"
                };
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/users/update";
                    defaultOptions.actionTip = "后台用户更新成功";
                }
                const  validRes=this.myValidator.valid(this);
                if (!validRes)
                    return ;
                let util = new VueUtil(this);
                let params = {...this.users};
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
                window.location.href = this.hostHead + "/admin/usersmanager.jsp";
            }
        },
        created() {
            this.load();
        }

    });

</script>