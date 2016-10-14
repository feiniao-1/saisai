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
<title>菜品编辑</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/nicEdit.js"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String fullName1 = "";
String fullName2 = "";
String caiid = "";
String shuzi = "";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName1 = request.getParameter("fullName1");
fullName2 = request.getParameter("fullName2");
caiid = request.getParameter("caiid");
shuzi = request.getParameter("shuzi");
System.out.println("caiid"+request.getParameter("caiid"));
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
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间 
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
//菜品列表信息
List<Mapx<String,Object>> menu=DB.getRunner().query("select productmenuid,productname,productEname,productlei,content1,content2,img1,ydimg1,substring(createtime,1,19) as createtime,substring(updatetime,1,19) as updatetime,count,yprice,shoucang,author from productmenu where del=? and productmenuid=?", new MapxListHandler(),"0",caiid);
System.out.println(menu);
//显示该菜品的随机数信息
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from productmenu where  author=? order by productmenuid desc limit 1",new MapxListHandler(),menu.get(0).getIntView("author"));
System.out.println();
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//编辑保存菜品信息
String productlei;
String productname;
String productEname;
String yprice;
String content1;
String content2;
String count;
String shoucang;
String img1;
String ydimg1;
System.out.println("url_canshu:"+url_canshu+";canshu_url:"+canshu_url+";提交前img:"+(String)session.getAttribute("fullName1"));
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("确定")){
	productlei=param.get("productlei");
	productname=param.get("productname");
	productEname=param.get("productEname");
	yprice=param.get("yprice");
	content1=param.get("content1");
	content2=param.get("content2");
	count=param.get("count");
	shoucang=param.get("shoucang");
	if((String)session.getAttribute("fullName1")==null){
		img1=menu.get(0).getStringView("img1");
	}else{
		img1="upload/"+(String)session.getAttribute("fullName1");
	}
	if((String)session.getAttribute("fullName2")==null){
		ydimg1=menu.get(0).getStringView("ydimg1");
	}else{
		ydimg1="upload/"+(String)session.getAttribute("fullName2");
	}
	System.out.println(productlei+productname+productEname+yprice+content1+count+shoucang+img1);
		DB.getRunner().update("update productmenu set productlei=?,productname=?,productEname=?,content1=?,content2=?,img1=?,ydimg1=?,updatetime=?,count=?,canshu_url=?,yprice=?,shoucang=? where productmenuid=?",productlei,productname,productEname,content1,content2,img1,ydimg1,df.format(new Date()),count,url_canshu,yprice,shoucang,param.get("id"));
		session.removeAttribute("fullName1");
		session.removeAttribute("fullName2");
		%>
		<script type="text/javascript" language="javascript">
				alert("修改成功");                                            // 弹出提示信息
				window.location='admin_product.jsp' ;                           
		</script>
	<%
}else{
}
}
%> 
</head>
<body>
<div class="panel panel-default container box-shadow"  style="padding-top:50px; margin-top:50px;">
    <div class="row">
    <div style="text-align:center; ">
<h3>菜品详细信息</h3><br>
        <span style="margin-left:500px;">
        <a href="admin_boke_edit.jsp" class="btn btn-primary">发表博客</a>/<a  href="admin_baike_edit.jsp" class="btn btn-primary">发表百科</a>/<a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>/<a href="front_index.jsp" class="btn btn-primary">首页</a></span><br>
        <a href="admin_product.jsp" class="btn btn-primary">返回</a><span style="color:red;">操作说明：如需改动图片；先上传图片，再修改内容</span>
        </div>
        		<!-- 表格 start -->
        		<div class="form-group">
        		<label>PC商品图片*</label> 
						<form action="${pageContext.request.contextPath }/uploadServlet?url=productpublish&caiid=<%= caiid%>&shuzi=1" method="post" enctype="multipart/form-data">
						<input type="file" name="attr_file1" style="display:inline-block;">
						<div style="margin-top:-25px;margin-left:200px;">
						<%if(shuzi!=null&&shuzi.equals("1")){
							if(fullName1==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("fullName1", fullName1);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName1")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						<input type="submit" value="上传">  	</div>
				  	 </form>
						 <%if((String)session.getAttribute("fullName1")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("fullName1") %>" style="width:220px!important;" height="150px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("img1") %>" style="width:220px!important;" height="150px">
							 <%} %>
							 <label>移动端商品图片*</label> 
					<form action="${pageContext.request.contextPath }/uploadServlet?url=productpublish&caiid=<%= caiid%>&shuzi=2" method="post" enctype="multipart/form-data">
						<input type="file" name="attr_file1" style="display:inline-block;">
						<div style="margin-top:-25px;margin-left:200px;">
						<%if(shuzi!=null&&shuzi.equals("2")){
							if(fullName2==null){
								//session.removeAttribute("fullName2");
							}else{
								if(fileName=="") {%>
									<script type="text/javascript" language="javascript">
									document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
								</script>
								<%}else{ %>
								<%
								session.setAttribute("fullName2", fullName2);
								} %>
							<%}
						}%>
									<%
							if((String)session.getAttribute("fullName2")!=null){%>
									<script type="text/javascript" language="javascript">
										document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
										
									</script>
							<%}else{ %>
							<%} %>
						<input type="submit" value="上传">  	</div>
				  	 </form>
						 <%if((String)session.getAttribute("fullName2")!=null){ %>
							 	<img alt="" src="upload/<%=(String)session.getAttribute("fullName2") %>" style="width:120px!important;" height="90px">
							 <%}else{ %>
							 	<img alt="" src="<%=menu.get(0).getStringView("ydimg1") %>" style="width:120px!important;" height="90px">
							 <%} %>
				</div>
				<form role="form" action="admin_product_publish.jsp?jishu=<%=val%>&caiid=<%=caiid %>" method="POST" name="form1"
					novalidate>
					<div class="form-group">
						<label>ID</label> <input type="text" class="form-control" style="width:200px;"
							readOnly="true" value="<%= menu.get(0).getIntView("productmenuid") %>" name="id">
						<p class="help-block">ID由系统自动生成</p>
					</div>
					<div class="form-group">
						<label>菜品类别</label>
							<br>
							<select name="productlei">
								<option><%= menu.get(0).getStringView("productlei") %></option>
								<option>特色水饺</option>
								<option>开胃凉菜</option>
								<option>精美热菜</option>
								<option>酒水饮料</option>
								<option>主食</option>
							</select>
					</div>
					<div class="form-group">
						<label>菜品名称</label> <input type="text" class="form-control" style="width:200px;"
							name="productname"
							value="<%= menu.get(0).getStringView("productname") %>">
					</div>
					<div class="form-group">
						<label>英文名称</label> <input type="text" class="form-control" style="width:200px;"
							name="productEname"
							value="<%= menu.get(0).getStringView("productEname") %>">
					</div>
					<div class="form-group">
						<label>价格</label> ￥：<input type="text" class="form-control" style="width:200px;"
							name="yprice"
							value="<%=menu.get(0).getIntView("yprice") %>">
					</div>
					<div class="form-group">
						<label>菜品简介(字数为1行或最多65字)</label> <textarea type="text" class="form-control"  rows="3" cols="105"
							name="content1"
							value="<%=menu.get(0).getStringView("content1") %>"><%=menu.get(0).getStringView("content1") %></textarea>
					</div>
					<div class="form-group">
						<label>菜品介绍</label> <textarea type="text" class="form-control"  rows="8" cols="105"
							name="content2"
							value="<%=menu.get(0).getStringView("content2") %>"><%=menu.get(0).getStringView("content2") %></textarea>
					</div>
					<div class="form-group">
						<label>创建时间</label> <input type="text" class="form-control" style="width:200px;"
							name="createtime" readOnly="true"
							value="<%=menu.get(0).getIntView("createtime") %>">
					</div>
					<div class="form-group">
						<label>最近修改时间</label> <input type="text" class="form-control" style="width:200px;"
							name="updatetime" readOnly="true"
							value="<%=menu.get(0).getIntView("updatetime") %>">
					</div>
					<div class="form-group">
						<label>销售量</label> <input type="text" class="form-control" style="width:200px;"
							name="count"
							value="<%=menu.get(0).getIntView("count") %>">
					</div>
					<div class="form-group">
						<label>收藏量</label> <input type="text" class="form-control" style="width:200px;"
							name="shoucang"
							value="<%=menu.get(0).getIntView("shoucang") %>">
					</div>
					<input type=submit class="btn btn-default" name="Action" value="确定">
				</form>
				<!-- 表格 end -->
			
  </div>
</div>
</body>
</html>