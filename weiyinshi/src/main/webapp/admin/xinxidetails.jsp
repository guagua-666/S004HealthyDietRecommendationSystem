<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>健康食谱信息查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/leaveword.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/box.all.css" type="text/css"></link>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js'></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/quill.min.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/vue-quill-editor.js"></script>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.core.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.snow.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.bubble.css" rel="stylesheet"/>

    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<div class="search-title">
    <h2>
        查看健康食谱健康食谱
    </h2>
    <div class="description">
    </div>
</div>

<div id="app"  class="wrap  round-block">


    <div style="overflow: hidden" class="split-left white-paper">
            <div class="show-details">
                <div class="picture-box">
                    <img v-if="xinxi.images!=null" :src="hostHead+xinxi.images[0]" />

                </div>
                <div class="text-box">
                    <div class="title">{{xinxi.title}}</div>
                    <div class="sub-title"></div>
                    <div>
                        <ul>

                            <li><strong>发布人:</strong><a :href="hostHead+'/e/myspace.jsp?accountname='+xinxi.pubren">{{xinxi.pubren}}</a></li>
                            <li><strong>发布时间:</strong>{{xinxi.pubtime}}</li>
                            <li><strong>点击次数:</strong> {{xinxi.clickcount}}
                            </li>
                            <li><strong>所属分类:</strong> {{xinxi.lmname}}</li>



                        </ul>
                    </div>

                </div>
            </div>

            <div v-html="xinxi.dcontent" class="brief-content">

            </div>
            <!--评论区域-->
            <comment :delete-comment="true" :belongid="this.id" :with-comment="false" xtype="xinxi"></comment>

        </div>



</div>

<jsp:include page="../e/commentvue.jsp"></jsp:include>
</body>
</html>

<script type="text/javascript">


    Vue.http.options.root = '${pageContext.request.contextPath}';
    Vue.http.options.emulateJSON = true;
    Vue.http.options.xhr = {withCredentials: true};
    Vue.use(window.VueQuillEditor);
    let vm=new Vue({
        el:"#app",
        name: 'xinxiinfo',
        data(){
            return {
                hostHead:'${pageContext.request.contextPath}',
                listHotXinxi:[],
                id:0,
                openLogin:false,
                hyid:"${sessionScope.huiyuan.id}",
                xinxi:{},
                swiperOptions: {
                    pagination: {
                        el: '.swiper-pagination',    //与slot="pagination"处 class 一致
                        clickable: true            //轮播按钮支持点击
                    },
                    navigation: { // 左右箭头
                        nextEl:'.swiper-button-next',
                        prevEl:'.swiper-button-prev'
                    },
                    loop: true,		// 循环回路
                    slidesPerView: "auto",	// 设置slider容器能够同时显示的slides数量; 设置为auto则自动根据slides的宽度来设定数量
                    centeredSlides: true,	// 设定为true时，active slide会居中，而不是默认状态下的居左
                    spaceBetween: 30

                },

            }
        },
        methods:{

            async getInfo(){
                this.id=${param.id};
                let {data:res}=await this.$http.post("admin/xinxi/info",{id:this.id});
                if(res!=null&&res.stateCode>0) {
                    this.xinxi = res.data;
                    console.log(this.xinxi);

                }
            },


        },
        created () {
            this.id="${param.id}";
            this.getInfo();
        },

    });
</script>

