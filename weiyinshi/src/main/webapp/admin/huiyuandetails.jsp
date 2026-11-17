<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>会员信息查看</title>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div id="app">
	<div class="search-title">
		<h2>会员信息</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td align="right" class="title">用户名:</td>
			<td>
				{{huiyuan.accountname}}
			</td>
			<td colspan="2" rowspan="7">

				<img  width="200px"
											 height="200px" :src="touxiang" />
			</td>
		</tr>
		<tr>


			<td align="right" class="title">姓名:</td>
			<td>{{huiyuan.name}}</td>
		</tr>

		<tr>
			<td align="right" class="title">注册时间:</td>
			<td>
				{{huiyuan.regdate}}
			</td>
		</tr>
		<tr>
			<td align="right" class="title">登录次数:</td>
			<td>{{huiyuan.logtimes}}</td>
		</tr>


		<tr>
			<td align="right" class="title">移动电话:</td>
			<td>{{huiyuan.mobile}}</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td align="right" class="title">地址:</td>
			<td>{{huiyuan.address}}</td>
		</tr>


	</table>
</div>
</body>
</html>


<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};

	let vm=new Vue({
		el:"#app",
		data(){
			return {

				hostHead:'${pageContext.request.contextPath}',
				"huiyuan":{
				},
			}
		},
		methods:{
			//begin load
			async load(){
				let id="${param.id}"
				let util=new VueUtil(this);
				if(id!=""){
					let url="admin/huiyuan/load";
					let {data:res}=await util.http.post(url,{id:id});
					console.log("res",res);
					if(res!=null&&res.data!=null)
						this.huiyuan=res.data;
				}
			},//end load



		},
		created(){
			this.load();

		},
		computed:{
			touxiang(){
				if(!(this.huiyuan.touxiang.startsWith("http://") || this.huiyuan.touxiang.startsWith("https://")))
					return this.hostHead+this.huiyuan.touxiang;
				else
					return this.huiyuan.touxiang;
			}
		}

	});

</script>
