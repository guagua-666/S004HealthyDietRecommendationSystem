<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>页面项目信息</title>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>

</head>
<body >
<div id="app">
		<div class="search-title">
			<h2>[{{ psColumn.pageName }}]板块管理</h2>
			<div class="description">

			</div>
		</div>

		<!-- 搜索控件结束 -->
		<div class="action-details">
			<div class="btn-group">

				<!--{{export-view}}-->
				<span class="btn btn-danger" @click="deleteRec"><i class="fa fa-trash"></i>删除</span>
				<a class="btn btn-success" :href="hostHead+'/admin/psitemadd.jsp?pageid='+psColumn.pageId"><i class="fa fa-plus"></i>添加板块</a>
			</div>
		</div>
		<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
			<thead>
			<tr>
				<th>
					<input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
				</th>

				<th><b>板块名</b></th>
				<th><b>板块类型</b></th>
				<th>
					操作
				</th>
			</tr>
			</thead>
			<tbody>

			<tr v-show="listPsitem.length==0">
				<td colspan="20">
					没有相关页面信息
				</td>
			</tr>

			<tr v-for="psitem in listPsitem" :key="psitem.id">
				<td>
					<input class="check" name="ids" type="checkbox" v-model="psitem.rowSelected"
						   :value="psitem.id"/>
				</td>
				<td>{{psitem.lmName}}</td>
				<td>
					<span v-if="psitem.lmType==1">健康食谱板块</span>
					<span v-if="psitem.lmType==2">商品板块</span>
					<span v-if="psitem.lmType==3">视频板块</span>

				</td>

				<td>
					<span  title="删除" @click="deleteOne(psitem.id)" class="btn btn-danger" ><i class="fa fa-trash-o"></i></span>

				</td>
			</tr>

			</tbody>
		</table>
		<div class="clear"></div>
</div>
</body>
</html>
<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};


	let  vm=new Vue({
         el:"#app",
		data () {
			return {
				hostHead:'${pageContext.request.contextPath}',
				name:"",
				selectedAll:false,
				listPsitem:[],
				psColumn:{}

			}
		},
		created () {
			this.search();
		},
		methods:{


			async search(){
				let url="admin/psitem/list";
				let pageid="${param.pageid}";
				let param={
					pageid
				};
				let { data:res }=await this.$http.post(url,param);
				if(res!=null&&res.data!=null){
					this.psColumn=res.data;
					this.listPsitem=this.psColumn.psItemVos;
				}
			},
			selectedAllHandler(){
				console.log(this.selectedAll);
				if(this.listPsitem!=null){
					this.listPsitem.forEach(c=>{
						c.rowSelected=!this.selectedAll;
					});
				}
			},
			deleteRec(){

				let hasChecked=this.listPsitem.some(c=>{
					return c.rowSelected==true;
				});
				if(!hasChecked){
					this.$alert('请选择需要删除的记录', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}
				let ids=this.listPsitem.filter(c=>c.rowSelected).map(c=>c.id);
				console.log("ids",ids);
				this._doDelete({ids});
			},
			deleteOne(id){
				let ids=[];
				ids.push(id);
				this._doDelete({ids});
			},
			async _doDelete(options){
				let defaultOptions={
					ids:[]
				};
				Object.assign(defaultOptions,options);
				let url="admin/psitem/delete";
				let confirm= await this.$confirm('是否要删除信息?', '系统提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
				});
				if(defaultOptions.ids==null||defaultOptions.ids.length<=0)
					return;
				let {data:res}=await this.$http.post(url, {ids:defaultOptions.ids},{emulateJSON:false});
				if (res.stateCode > 0) {
					this.$message({
						message:"删除成功",
						type:'success',
						duration:3000
					});
					this.search();
				}
			}
		}


	});

</script>
