<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="law.jsp"%>
<html>
<head>
    <title>后台用户中心</title>
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
<body >
<div id="app">
<div class="search-title">
    <h2>修改密码</h2>
    <div class="description">
    </div>
</div>

    <table  cellspacing="1"  class="smart-table" border="1" cellpadding="0" width="100%" >

        <tr>
            <td class="tlabel" align="right" >原始密码 :</td>
            <td align="left" >
                <input name="password1"  type="password" v-model="password1" class="input-txt" validate="{required:true,messages:{required:'请输入密码'}}" />
            </td>
        </tr>
        <tr>
            <td class="tlabel" align="right">修改密码 :</td>
            <td align="left" >
                <input name="repassword1"   type="password" v-model="repassword1" class="input-txt" validate="{required:true,messages:{required:'请输入确定密码'}}" />
            </td>
        </tr>
        <tr>
            <td class="tlabel" align="right" >确认密码 :</td>
            <td align="left">
                <input name="repassword2"  type="password" v-model="repassword2" class="input-txt" validate="{required:true,equalTo:'#repassword1',messages:{required:'请输入确定密码',equalTo:'两次密码不一致'}}" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <el-button @click="modifyHandler"  type="primary" icon="el-icon-lock">修改密码</el-button>
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

    let  vm=new Vue({
        el:"#app",
        data(){
            return {
               hostHead:"${pageContext.request.contextPath}",
               id:"${sessionScope.users.id}",
                password1:"",
                repassword1:"",
                repassword2:""
            }
        },
        methods:{
           async modifyHandler(){
               let url="admin/users/modifypw";
               if (this.password1==""){
                   this.$message.error("请输入原始密码");
                   return ;
               }
               if (this.repassword1==""){
                   this.$message.error("请输入修改密码");
                   return ;
               }
               if (this.repassword2==""){
                   this.$message.error("请输入确认密码");
                   return ;
               }
               if(this.repassword1!=this.repassword2){
                   this.$message.error("两次密码不一致");
                   return ;
               }

               let {data:res}= await this.$http.post(url, {
                    id: this.id,
                    password1: this.password1,
                    repassword1: this.repassword1
                });
               if (res!=null&&res.stateCode<0){
                   this.$message.error(res.des);
                   return ;
               }
               this.$message.success("修改成功");
               window.location.href=this.hostHead+"/admin/usersmanager.jsp";


            }
        }

    })

</script>
