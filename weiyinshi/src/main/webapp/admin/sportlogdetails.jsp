<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  
  <title>体检记录信息查看</title>
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
	                <h2>
	                      查看体检记录
	                </h2>
	                <div class="description">
	                </div>
                 </div>
				        <table class="smart-table" border="1" cellspacing="1" width="100%">
						       
						          
						            
						          
						             
						             
						                 <tr>
						                     <td class="tlabel" align="right">日期:</td>
								 <td>
						                      {{sportlog.createtime}}
						                 </td>
						                 </tr>
						            
						           
						            
						       
						          
						            
						             <tr>
						                     <td class="tlabel" width="10%" align="right">血压:</td>
								 <td width="*">
								      {{sportlog.shour}}
                                                               </td>
                                                               </tr>
						            
						          
						             
						             
						           
						            
						       
						          
						            
						             <tr>
						                     <td class="tlabel" width="10%" align="right">血糖:</td>
								 <td width="*">
								      {{sportlog.calorie}}
                                                               </td>
                                                               </tr>
						            
						             <tr>
						                     <td class="tlabel" width="10%" align="right">体检记录:</td>
								 <td width="*">
								      {{sportlog.tijiancontent}}
                                                               </td>
                                                               </tr>						          
						             
						             
						           
						            
						       
						          
						            
						             <tr>
						                     <td class="tlabel" width="10%" align="right">发布人:</td>
								 <td width="*">
								      {{sportlog.hyid}}
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
	   
          let vm=new Vue({
               el:"#app",
               data(){
                  return {
                      actiontype:'save',
		      hostHead:'${pageContext.request.contextPath}',
		       "sportlog":{
		       },
                  }
               },
               methods:{
                   	//begin load
                   	async load(){
				let id="${param.id}"
				let util=new VueUtil(this);
				if(id!=""){
				    let url="admin/sportlog/load";
				    let {data:res}=await util.http.post(url,{id:id});
				    console.log("res",res);
				   if(res!=null&&res.data!=null)
					 this.sportlog=res.data;
				 }
		     },//end load
		    
               },
                created(){
	           this.load();
		 }
          
          });
    
</script>