<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
<title>菜品列表</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String fullName = "";
String dhpage = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName = request.getParameter("fullName");
dhpage = request.getParameter("page");
System.out.println("jishu"+jishu);
}catch(Exception e){
	
}
//验证用户登陆
Mapx<String,Object> user = G.getUser(request);
String pageType = null;
String userType = null;
//验证用户登陆
String username = (String)session.getAttribute("username");
List<Mapx<String, Object>> useridc= DB.getRunner().query("SELECT userid FROM user where username=?", new MapxListHandler(),username);
int flag=0;
if(username==null){
	%>
	<script type="text/javascript" language="javascript">
			alert("请登录");                                            // 弹出错误信息
			window.location='front_login.jsp' ;                            // 跳转到登录界面
	</script>
<%
}else{
	flag=1;
}
//设置随机数
int  val = (int)(Math.random()*10000)+1;
int tagid=(int)new Date().getTime()/1000+(int)(Math.random()*10000)+1;
int url_canshu;
if(jishu==null){
	url_canshu=Integer.parseInt("1");
}else{	
	url_canshu=Integer.parseInt(jishu);
}
//当前登录用户
//int dluserid=useridc.get(0).getInt("userid");
int dluserid=10196;	
HashMap<String,String> param= G.getParamMap(request); 
//统计菜品总页数
List<Mapx<String,Object>> menupage=DB.getRunner().query("select count(1) as count from productmenu where del=? ", new MapxListHandler(),"0");
int pagetotal=Integer.parseInt(menupage.get(0).getIntView("count"))/10;
System.out.println("总页数="+pagetotal);
//如果urlpage为null
int intdhpage;
if(dhpage==null){
	intdhpage=Integer.parseInt("0");
}else{	
	intdhpage=Integer.parseInt(dhpage);
}
System.out.println("当前页数="+intdhpage);
int plus;
int minus;
//下一页
if(intdhpage==pagetotal){
	plus=pagetotal;
}else{
	plus =intdhpage+1;
}
//上一页
if(intdhpage==0){
	minus =0;	
}else{
	minus =intdhpage-1;
}
//菜品列表信息
//CREATE TABLE `productmenu` (
// `productmenuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
//  `productlei` varchar(255) DEFAULT NULL COMMENT '菜品类别',
//  `productname` varchar(255) DEFAULT NULL COMMENT '菜名',
//  `productEname` varchar(255) DEFAULT NULL COMMENT '菜英文名',
//  `content1` text COMMENT '菜品简介',
//  `img1` varchar(255) DEFAULT NULL COMMENT '图片1',
//  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
//  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//  `is_discuss` tinyint(1) DEFAULT NULL COMMENT '是否被评论',
//  `del` int(11) DEFAULT NULL,
//  `count` int(11) DEFAULT NULL COMMENT '销售量',
//  `yprice` int(11) DEFAULT NULL COMMENT '原价格',
//  `xprice` int(11) DEFAULT NULL COMMENT '现价格',
//  `shoucang` int(11) DEFAULT NULL COMMENT '收藏量',
//  `canshu_url` int(11) DEFAULT NULL,
//  `tagid` int(22) DEFAULT NULL,
//  `visitor` varchar(255) DEFAULT NULL,
//  PRIMARY KEY (`productmenuid`)
//) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
//设置标题栏信息
String[] colNames={"菜品ID","菜名","英文名","菜品类别","创建时间","销售量","价格","收藏量","操作"};
//菜品列表信息
List<Mapx<String,Object>> menu=DB.getRunner().query("select productmenuid,productname,productEname,productlei,substring(createtime,1,19) as createtime,count,yprice,shoucang from productmenu where del=? order by productmenuid desc limit "+intdhpage*10+",10 ", new MapxListHandler(),"0");
System.out.println(menu);
//删除
String dhid; 
System.out.println("Action"+param.get("Action")+"dhid"+request.getParameter("dhid"));
if((param.get("Action")!=null)&&(param.get("Action").equals("删除"))){
	dhid=new String(request.getParameter("dhid").getBytes("iso-8859-1"),"utf-8");
		DB.getRunner().update("update productmenu set del=? where productmenuid=?","1",dhid);
		%>
		<script type="text/javascript" language="javascript">
				alert("删除成功");                                            // 弹出错误信息
				window.location='admin_product.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	
}
%> 
</head>
<body>
<div class="panel panel-default container box-shadow"  style="text-align:center; padding-top:50px; margin-top:50px;">
    <div class="row">
<h3>菜品列表信息</h3><br>
        <span style="margin-left:500px;">
        <a href="admin_boke_edit.jsp" class="btn btn-primary">发表博客</a>/<a  href="admin_baike_edit.jsp" class="btn btn-primary">发表百科</a>/<a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>/<a href="front_index.jsp" class="btn btn-primary">首页</a></span><br>
        <a href="admin_product_add.jsp" class="btn btn-primary">添加</a>
        		<!-- 表格 start -->
				<table class="table table-striped">
					<thead>
						<tr>
							<% for(int i=0;i<colNames.length;i++){%>
							<th><%= colNames[i] %></th>
							<%} %>
						</tr>
					</thead>
					<tbody>
					<%for(int j=0;j<menu.size();j++) {%>
						<tr>
							<td><%=menu.get(j).getIntView("productmenuid") %></td>
							<td><%=menu.get(j).getStringView("productname") %></td>
							<td><%=menu.get(j).getStringView("productEname") %></td>
							<td><%=menu.get(j).getStringView("productlei") %></td>
							<td><%=menu.get(j).getIntView("createtime") %></td>
							<td><%=menu.get(j).getIntView("count") %></td>
							<td><%=menu.get(j).getIntView("yprice") %></td>
							<td><%=menu.get(j).getIntView("shoucang") %></td>
							<td>
								<div style="width:150px;">
								<a href="admin_product_publish.jsp?caiid=<%=menu.get(j).getIntView("productmenuid")%>">管理</a>|
								<form action="admin_product.jsp" id="subform" method="POST" style="float:right;">
									<input type="hidden" value="<%=menu.get(j).getIntView("productmenuid") %>" name="dhid">
									<input type="hidden" value="删除" name="Action">
								</form>
								<a class="zhuce"  name="删除" onclick="test_post()">删除</a>
								</div>
							</td>
						</tr>
<%} %>
<script type="text/javascript">
function test_post() {
var testform=document.getElementById("subform");
testform.action="admin_product.jsp";
testform.submit();
}
</script>
					</tbody>
				</table>
				<!-- 表格 end -->
				<!-- 分页start -->
				<div class="nav-page">
								    <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=<%=minus%>">«</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=0">1</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=1">2</a></li>
								    <%if(pagetotal>=3){ %>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=2">3</a></li>
								    <%} %>
								    <li><a>...</a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=<%=pagetotal-1%>"><%=pagetotal%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=<%=pagetotal%>"><%=pagetotal+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/admin_product.jsp?page=<%=plus%>">»</a></li>
								  </ul>
				</div>
				<!-- 分页end -->
  </div>
</div>
</body>
</html>