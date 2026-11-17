<%@include file="law.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<% int pageId=2; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>用户管理</title>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>

</head>
<body>

<div id="app">
	<div class="search-title">
		<h2>
			系统用户管理
		</h2>
		<div class="description">
		</div>
	</div>

	<div class="search-options">

		<table cellspacing="0" width="100%">
			<tbody>
			<tr>
				<td>用户名:<div  style="display: inline-block;width:280px;"><el-input  @keyup.enter="search"  v-model="username" placeholder="用户名" type="text" /></div>
					<el-button type="primary" icon="el-icon-search"  @click="search">查找</el-button>

				</td>
			</tr>
			</tbody>
		</table>


	</div>
	<div class="action-details">
		<el-button type="danger" @click="deleteRec" icon="el-icon-delete">删除</el-button>
	</div>


	<table  width="100%" border="0" cellspacing="0"
			cellpadding="0" class="table-striped table table-bordered table-bordered">
		<thead>
		<tr>
			<th>
				<input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
			</th>
			<th>
				<b>用户名</b>
			</th>
			<th>
				<b>角色</b>
			</th>
			<th>
				<b>创建时间</b>
			</th>
			<th>
				<b>绑定邮箱</b>
			</th>
			<th>
				<b>电话</b>
			</th>
			<th>
				<b>登录次数</b>
			</th>
			<th>
				<b>真名</b>
			</th>
			<th>
				<b>昵称</b>
			</th>
			<th>
				<b>性别</b>
			</th>

			<th>
				操作
			</th>
		</tr>
		</thead>
		<tbody>

		<tr v-show="listUsers.length==0">
			<td colspan="20">
				没有相关系统用户信息
			</td>
		</tr>


		<tr v-for="user in listUsers">
			<td>
				&nbsp
				<input  class="check" name="ids" type="checkbox" v-model="user.rowSelected" :value="user.id"/>
			</td>
			<td>
				{{user.username}}
			</td>


			<td>
				{{user.rolename}}

			</td>
			<td>
				{{user.createtime}}

			</td>
			<td>
				{{user.email}}

			</td>
			<td>
				{{user.tel}}
			</td>
			<td>
				{{user.logtimes}}

			</td>
			<td>
				{{user.realname}}
			</td>
			<td>
				{{user.nickname}}
			</td>
			<td>
				{{user.sex}}
			</td>

			<td>
				<a class="btn btn-danger" :href="'${pageContext.request.contextPath}/admin/usersadd.jsp?id='+user.id"><i class="fa fa-edit"></i>修改</a>
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


</div>

<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};

	let vm=new Vue({

		el:"#app",
		data(){
			return {
				username:"",
				selectedAll:false,
				listUsers:[],
				pageindex:1, //初始页
				pagesize:10,
				total:10
			}

		},
		methods:{
			pagesizeChange: function (pagesize) {
				this.pagesize = pagesize;
			},
			pageindexChange: function(pageindex){
				this.pageindex = pageindex;
				console.log(this.pageindex);
				this.search();
			},
			async search(){
				let url="admin/users/list";
				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize,
					username:this.username
				};
				console.log("this.pageindex="+this.pageindex);
				let res=await this.$http.post(url,param);
				if(res.data!=null){
					let pageInfo=res.data.data;
					this.total=pageInfo.total;
					this.listUsers=pageInfo.list;
					console.log(pageInfo);
				}
			},
			async deleteRec(){
				let url="admin/users/delete";
				let hasChecked=this.listUsers.some(c=>{
					return c.rowSelected==true;
				});
				if(!hasChecked){
					this.$alert('请选择需要删除的记录', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}

				let ids=this.listUsers.filter(c=>c.rowSelected).map(c=>c.id);
				console.log("ids",ids);
				let res= this.$confirm('是否要删除用户?', '系统提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
				}).then(()=>{
					this.$http.post(url, {ids},{emulateJSON:false}).then(res=>{
						if (res.data != null && res.data.stateCode > 0) {
							this.search();
						}
					});
				}).catch(()=>{});
			},
			selectedAllHandler(){
				console.log(this.selectedAll);
				if(this.listUsers!=null){
					this.listUsers.forEach(c=>{
						c.rowSelected=!this.selectedAll;
					});
				}
			}
		},
		created(){
			this.search();
		}
	});

</script>

</body>
</html>