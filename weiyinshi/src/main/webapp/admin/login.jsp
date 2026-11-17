<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.min.css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/login.css"/>

    <script src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>


</head>

<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
<div id="app" >
    <div id="mainBody">
        <div id="cloud1" class="cloud"></div>
        <div id="cloud2" class="cloud"></div>
    </div>


    <div class="logintop">
        <span>基于微信小程序的健康饮食推荐系统</span>

    </div>

    <div class="loginbody">

        <span class="systemlogo"></span>

        <div class="loginbox">

            <div class="l-form">
                <div class="input-group fm-row">
                    <span class="input-group-addon" ><i style="color:#10c35b;" class="fa fa-user"></i></span>
                    <input type="text" class="form-control" name="username" v-model="username" placeholder="用户名" />
                </div>
                <div class="input-group fm-row">
                    <span class="input-group-addon" ><i style="color:#10c35b;" class="fa fa-lock"></i></span>
                    <input  class="form-control" type="password" name="password" v-model="password" placeholder="密码"/>
                </div>


                <div class="fm-row">

                    <el-button-group>
                        <el-button @click="login" icon="el-icon-check" type="danger">登录</el-button>
                    </el-button-group>

                </div>
            </div>


        </div>

    </div>




</div>
</body>

</html>


<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/three.min.js"></script>
<script type="text/javascript">
    if (top.window != window)
        top.location.href = "login.jsp";


    Vue.http.options.root = '${pageContext.request.contextPath}';

    Vue.http.options.emulateJSON = true;
    Vue.http.options.xhr = {withCredentials: true};

    let vm=new Vue({
        el:"#app",
        data:{
            username:"",
            password:"",
            code:"",
            usertype:1,
            inputCode:""
        },
        methods:{
            getCode() {

                let arrays = new Array(
                    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
                    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                    'u', 'v', 'w', 'x', 'y', 'z',
                    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
                    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                    'U', 'V', 'W', 'X', 'Y', 'Z'
                );
                codes = '';// 重新初始化验证码
                for (var i = 0; i < 4; i++) {
                    // 随机获取一个数组的下标
                    var r = parseInt(Math.random() * arrays.length);
                    codes += arrays[r];
                }
                this.code=codes;
                return codes;

            },
            login(){

                if(this.username==""){
                    this.$message.warning("用户名不能为空");
                    return;
                }
                if(this.password==""){
                    this.$message.warning("密码不能为空");
                    return;
                }
                let url = "admin/login";

                this.$http.post(url,{
                    username:this.username,
                    password:this.password,
                    usertype:this.usertype
                }).then(res => {
                    console.log(res.data);
                    let data=res.data;
                    if(data.stateCode<0){
                        this.$message.error(data.des);
                        return;
                    }
                    let url="/admin/index.jsp";
                    if(this.usertype==1)
                        url="/admin/index.jsp";

                    window.location="${pageContext.request.contextPath}"+url;
                });

            }
        },
        created(){

        },
        mounted(){


        }

    });


</script>