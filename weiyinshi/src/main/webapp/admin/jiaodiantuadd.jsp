<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>轮播图</title>

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
    <div class="search-title">
        <h2>
            新建轮播图
        </h2>
        <div class="description">
        </div>
    </div>


    <table class="grid" cellspacing="1" width="100%">



        <tr>

            <td colspan="4">

                <dw-upload :host-head="hostHead" class-name="horizontal-banner" v-model="jiaodiantu.tupian"></dw-upload>
            </td>
        </tr>

        <tr>
            <td align="right">标题:</td>
            <td>
                <input name="title" v-model="jiaodiantu.title" placeholder="标题"
                       v-validate="{required:true,messages:{required:'请输入标题'}}" class="input-txt" type="text"/>

            </td>
            <td align="right">链接地址:</td>
            <td><input name="href" v-model="jiaodiantu.href" v-validate="{required:true,messages:{required:'请输入链接地址'}}"  class="input-txt"   type="text" /></td>
        </tr>


        <tr>
            <td align="right">显示优先级:</td>
            <td>

                <select v-model="jiaodiantu.pindex" name="pindex" class="mydropdown">
                    <option value="0">第一级</option>
                    <option value="2">第二季</option>
                    <option value="3">第三级</option>
                    <option value="4">第四级</option>
                    <option value="5">第五级</option>
                </select>

            </td>
            <td align="right">类型:</td>
            <td><input type="radio" v-model="jiaodiantu.xtype" id="radXtype" value="站内"
                       checked="checked">站内
                <input type="radio" v-model="jiaodiantu.xtype" value="站外">站外
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
                errors: {},
                hostHead: '${pageContext.request.contextPath}',
                "jiaodiantu": {
                    "title": "",
                    "tupian": "/upload/nopic.jpg",
                    "xtype": "站内",
                    "href":"",
                    "pindex": "0",
                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑轮播图";
                    let url = "admin/jiaodiantu/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.jiaodiantu = res.data;
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/jiaodiantu/save",
                    actionTip: "轮播图新增成功"
                };
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/jiaodiantu/update";
                    defaultOptions.actionTip = "轮播图更新成功";
                }
                const  validRes=this.myValidator.valid(this);
                console.log("valRes",validRes);
                if (!validRes)
                    return ;
                let util = new VueUtil(this);
                let params = {...this.jiaodiantu};
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
                window.location.href = this.hostHead + "/admin/jiaodiantumanager.jsp";
            }
        },
        created() {
            this.load();
        }

    });

</script>