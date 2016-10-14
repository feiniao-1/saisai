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
<title>后台编辑</title>
<link href="img/toubiao.png" rel="SHORTCUT ICON">
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>  
    <script type="text/javascript" src="js/nicEdit.js"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
String fileName = "";
String fullName1 = "";
String fullName2 = "";
String fullName3 = "";
String fullName4 = "";
String fullName5 = "";
String fullName6 = "";
String fullName7 = "";
String fullName8 = "";
String fullName9 = "";
String fullName10 = "";
String fullName11 = "";
String fullName12 = "";
String fullName13 = "";
String fullName14 = "";
String fullName15 = "";
String fullName16 = "";
String fullName17 = "";
String fullName18 = "";
String fullName19 = "";
String fullName20 = "";
String shuzi="";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName1 = request.getParameter("fullName1");
fullName2 = request.getParameter("fullName2");
fullName3 = request.getParameter("fullName3");
fullName4 = request.getParameter("fullName4");
fullName5 = request.getParameter("fullName5");
fullName6 = request.getParameter("fullName6");
fullName7 = request.getParameter("fullName7");
fullName8 = request.getParameter("fullName8");
fullName9 = request.getParameter("fullName9");
fullName10 = request.getParameter("fullName10");
fullName11 = request.getParameter("fullName11");
fullName12 = request.getParameter("fullName12");
fullName13 = request.getParameter("fullName13");
fullName14 = request.getParameter("fullName14");
fullName15 = request.getParameter("fullName15");
fullName16 = request.getParameter("fullName16");
fullName17 = request.getParameter("fullName17");
fullName18 = request.getParameter("fullName18");
fullName19 = request.getParameter("fullName19");
fullName20 = request.getParameter("fullName20");
if(request.getParameter("shuzi")!=null){
	System.out.println("YES");
	shuzi = request.getParameter("shuzi");
}else{
	System.out.println("NO");
	shuzi ="";
}
//shuzi= request.getParameter("shuzi");
System.out.println("shuzi"+shuzi);
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
//显示文章信息
//CREATE TABLE `sai_article` (
// `articleid` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
//  `author` int(11) DEFAULT NULL COMMENT '作者',
//  `title` varchar(255) DEFAULT NULL COMMENT '主题',
//  `content1` text COMMENT '简介',
//  `content2` text COMMENT '内容',
//  `img1` varchar(255) DEFAULT NULL COMMENT '图片1',
//  `img2` varchar(255) DEFAULT NULL COMMENT '图片2',
//  `img3` varchar(255) DEFAULT NULL COMMENT '图片3',
//  `img4` varchar(255) DEFAULT NULL COMMENT '图片4',
//  `img5` varchar(255) DEFAULT NULL COMMENT '图片5',
//  `img6` varchar(255) DEFAULT NULL COMMENT '图片6',
//  `img7` varchar(255) DEFAULT NULL COMMENT '图片7',
//  `img8` varchar(255) DEFAULT NULL COMMENT '图片8',
//  `img9` varchar(255) DEFAULT NULL COMMENT '图片9',
//  `img10` varchar(255) DEFAULT NULL COMMENT '图片10',
//  `img11` varchar(255) DEFAULT NULL COMMENT '图片11',
//  `img12` varchar(255) DEFAULT NULL COMMENT '图片12',
//  `img13` varchar(255) DEFAULT NULL COMMENT '图片13',
//  `img14` varchar(255) DEFAULT NULL COMMENT '图片14',
//  `img15` varchar(255) DEFAULT NULL COMMENT '图片15',
//  `img16` varchar(255) DEFAULT NULL COMMENT '图片16',
//  `img17` varchar(255) DEFAULT NULL COMMENT '图片17',
//  `img18` varchar(255) DEFAULT NULL COMMENT '图片18',
//  `img19` varchar(255) DEFAULT NULL COMMENT '图片19',
//  `img20` varchar(255) DEFAULT NULL COMMENT '图片20',
//  `articletype` int(11) DEFAULT NULL COMMENT '文章类型',
//  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
//  `updatetime` datetime DEFAULT NULL COMMENT '最新修改时间',
//  `is_discuss` tinyint(1) DEFAULT NULL COMMENT '是否被评论',
//  `del` int(11) DEFAULT NULL,
//  `zcount` int(11) DEFAULT NULL COMMENT '浏览量',
//  `price` int(11) DEFAULT NULL COMMENT '参考造价',
//  `projectname` varchar(255) DEFAULT NULL,
//  `projectdidian` varchar(255) DEFAULT NULL,
//  `projectlei` varchar(255) DEFAULT NULL,
//  `projectcreater` varchar(255) DEFAULT NULL,
//  `projectjigou` varchar(255) DEFAULT NULL,
//  `projecttime` varchar(255) DEFAULT NULL,
//  `canshu_url` int(11) DEFAULT NULL,
//  `fengge` varchar(255) DEFAULT NULL,
//  `kongjian` varchar(255) DEFAULT NULL,
//  `mianji` varchar(255) DEFAULT NULL,
//  `tagid` int(22) DEFAULT NULL,
//  PRIMARY KEY (`articleid`)
//) ENGINE=InnoDB DEFAULT CHARSET=utf8;
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from sai_article where  author=? order by articleid desc limit 1",new MapxListHandler(),dluserid);
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//显示文章信息
List<Mapx<String,Object>> showdiscuss2 = DB.getRunner().query("select author,title,content1,articletype,projectname,projectdidian,projectlei,projectcreater,projectjigou,projecttime,price,fengge,kongjian,mianji,createtime,canshu_url,img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20 from sai_article where  articleid=?",new MapxListHandler(),dluserid);
//编辑保存文章信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String title;
String content1;
String articletype;
String projectname;
String projectdidian;
String projectlei;
String projectcreater;
String projectjigou;
String projecttime;
String price;
String fengge;
String kongjian;
String mianji;
String img1;
String img2;
String img3;
String img4;
String img5;
String img6;
String img7;
String img8;
String img9;
String img10;
String img11;
String img12;
String img13;
String img14;
String img15;
String img16;
String img17;
String img18;
String img19;
String img20;
System.out.println("url_canshu:"+url_canshu+"canshu_url"+canshu_url);
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("发表文章")){
	title=new String(request.getParameter("title").getBytes("iso-8859-1"),"utf-8");
	content1=new String(request.getParameter("content1").getBytes("iso-8859-1"),"utf-8");
	articletype=new String(request.getParameter("articletype").getBytes("iso-8859-1"),"utf-8");
	projectname=new String(request.getParameter("projectname").getBytes("iso-8859-1"),"utf-8");
	projectdidian=new String(request.getParameter("projectdidian").getBytes("iso-8859-1"),"utf-8");
	projectlei=new String(request.getParameter("projectlei").getBytes("iso-8859-1"),"utf-8");
	projectcreater=new String(request.getParameter("projectcreater").getBytes("iso-8859-1"),"utf-8");
	projectjigou=new String(request.getParameter("projectjigou").getBytes("iso-8859-1"),"utf-8");
	projecttime=new String(request.getParameter("projecttime").getBytes("iso-8859-1"),"utf-8");
	if(param.get("price").equals("")){
		price="1000";
	}else{
		price=param.get("price");
	}
	
	System.out.println("price"+price);
	fengge=new String(request.getParameter("fengge").getBytes("iso-8859-1"),"utf-8");
	kongjian=new String(request.getParameter("kongjian").getBytes("iso-8859-1"),"utf-8");
	mianji=new String(request.getParameter("mianji").getBytes("iso-8859-1"),"utf-8");
	img1="upload/"+(String)session.getAttribute("fullName1");
	img2="upload/"+(String)session.getAttribute("fullName2");
	img3="upload/"+(String)session.getAttribute("fullName3");
	img4="upload/"+(String)session.getAttribute("fullName4");
	img5="upload/"+(String)session.getAttribute("fullName5");
	img6="upload/"+(String)session.getAttribute("fullName6");
	img7="upload/"+(String)session.getAttribute("fullName7");
	img8="upload/"+(String)session.getAttribute("fullName8");
	img9="upload/"+(String)session.getAttribute("fullName9");
	img10="upload/"+(String)session.getAttribute("fullName10");
	img11="upload/"+(String)session.getAttribute("fullName11");
	img12="upload/"+(String)session.getAttribute("fullName12");
	img13="upload/"+(String)session.getAttribute("fullName13");
	img14="upload/"+(String)session.getAttribute("fullName14");
	img15="upload/"+(String)session.getAttribute("fullName15");
	img16="upload/"+(String)session.getAttribute("fullName16");
	img17="upload/"+(String)session.getAttribute("fullName17");
	img18="upload/"+(String)session.getAttribute("fullName18");
	img19="upload/"+(String)session.getAttribute("fullName19");
	img20="upload/"+(String)session.getAttribute("fullName20");
	if((title.equals("")||title.equals(null))||(content1.equals("")||content1.equals(null))){
		%>
			<script type="text/javascript" language="javascript">
					alert("主体信息不能为空");                                            // 弹出错误信息
					window.location='admin_baike_edit.jsp' ;                            // 跳转到登录界面
			</script>
		<%
	}else{
		DB.getRunner().update("insert into sai_article(author,title,content1,articletype,projectname,projectdidian,projectlei,projectcreater,projectjigou,projecttime,price,fengge,kongjian,mianji,createtime,canshu_url,img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,del) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dluserid,title,content1,articletype,projectname,projectdidian,projectlei,projectcreater,projectjigou,projecttime,price,fengge,kongjian,mianji,df.format(new Date()),canshu_url,img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,"0");
		session.removeAttribute("fullName1");
		session.removeAttribute("fullName2");
		session.removeAttribute("fullName3");
		session.removeAttribute("fullName4");
		session.removeAttribute("fullName5");
		session.removeAttribute("fullName6");
		session.removeAttribute("fullName7");
		session.removeAttribute("fullName8");
		session.removeAttribute("fullName9");
		session.removeAttribute("fullName10");
		session.removeAttribute("fullName11");
		session.removeAttribute("fullName12");
		session.removeAttribute("fullName13");
		session.removeAttribute("fullName14");
		session.removeAttribute("fullName15");
		session.removeAttribute("fullName16");
		session.removeAttribute("fullName17");
		session.removeAttribute("fullName18");
		session.removeAttribute("fullName19");
		session.removeAttribute("fullName20");
		System.out.println("数据写入成功");
		%>
		<script type="text/javascript" language="javascript">
				alert("发表成功");                                            // 弹出错误信息
				window.location='admin_baike_list.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	}
}else{
}
}

%>
</head>
<body>
<div class="panel panel-default container box-shadow"  style="padding-top:50px; margin-top:50px;">
    <div class="row">
<h3>填写文章信息</h3><br>

        <span style="margin-left:500px;">
        <a href="admin_boke_edit.jsp" class="btn btn-primary">发表博客</a>/<a  href="admin_baike_edit.jsp" class="btn btn-primary">发表百科</a>/<a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>/<a href="front_index.jsp" class="btn btn-primary">首页</a></span><br>
       <a href="admin_baike_list.jsp" class="btn btn-primary">返回</a>  说明：请先上传图片，后填写主体信息。
        <br/>
     <!-- 图片上传start 1 -->
 	  	 <br/>
 	 <label>户型图*</label> 
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=1" method="post" enctype="multipart/form-data">
		<input type="file" name="attr_file1" style="display:inline-block;">
		<div style="margin-top:-25px;margin-left:200px;">
			<%if(shuzi!=null&&shuzi.equals("1")){
				if(fullName1==null){
					//session.removeAttribute("fullName1");
				}else{
					if(fileName==""){%>
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
  	 </form><br>
  	   	<img alt="" src="upload/<%=(String)session.getAttribute("fullName1") %>" style="width:50px!important;" height="50px"><br>
	<!-- 图片上传end  1-->
		 <label>其他图*</label> 
	     <!-- 图片上传start 2 -->
 	  	 <br/>
 <%for(int i=2;i<=20;i++){ %>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=<%=i %>" method="post" enctype="multipart/form-data">
		<input type="file" name="attr_file<%=i %>" style="display:inline-block;">
		<div style="margin-top:-25px;margin-left:200px;">
		<%if(shuzi!=null&&shuzi.equals("i")){
			if("fullName"+i==null){
				//session.removeAttribute("fullName2");
			}else{
				if(fileName=="") {%>
					<script type="text/javascript" language="javascript">
					document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
				</script>
				<%}else{ %>
				<%
				session.setAttribute("fullName"+i, "fullName"+i);
				} %>
			<%}
		}%>
					<%
			if((String)session.getAttribute("fullName"+i)!=null){%>
					<script type="text/javascript" language="javascript">
						document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
						
					</script>
			<%}else{ %>
			<%} %>
		<input type="submit" value="上传">  	</div>
  	 </form><br>
  	   	<img alt="" src="upload/<%=(String)session.getAttribute("fullName"+i) %>" style="width:50px!important;" height="50px"><br> 
  	   	<%} %>
	<!-- 图片上传end  2-->

	
	<br>
  	 <br><BR>
  	 <br><BR>
<form id="form_tj" action="admin_baike_edit.jsp?jishu=<%=val%>" method="post" style="margin-top:-100px;">
<label>标题</label><span style="color:red;"></span>：<br><input type="text" Name="title"  placeholder="标题"><br>
<label>描述(简介)：</label><span style="color:red;"></span>：<br><textarea id="discuss_content" rows="3" cols="100" name="content1" placeholder="描述" ></textarea><br>
<div class="form-group">
<label>文章类别*</label> 
	<br>
	<select name="articletype">
		<option>类别1</option>
		<option>类别2</option>
		<option>类别3</option>		
		<option>类别4</option>
	</select>
</div>
<label>摘要(选填)：</label><br>
项目名：&nbsp;&nbsp;&nbsp;<input type="text" Name="projectname"  placeholder="项目名" style="width:250px;"><br>
项目地点：<input type="text" Name="projectdidian"  placeholder="项目地点" style="width:250px;"><br>
空间类型：<input type="text" Name="projectlei"  placeholder="空间类型" style="width:250px;"><br>
主设计师：<input type="text" Name="projectcreater"  placeholder="主设计师" style="width:250px;"><br>
设计结构：<input type="text" Name="projectjigou"  placeholder="设计结构" style="width:250px;"><br>
项目年份：<input type="text" Name="projecttime"  placeholder="项目年份" style="width:250px;"><br>
参考造价：<input type="text" Name="price"  placeholder="参考造价" style="width:250px;"><br>
<label>其他（选填）：</label><br>
风格：<input type="text" Name="fengge"  placeholder="风格" style="width:250px;"><br>
空间：<input type="text" Name="kongjian"  placeholder="空间" style="width:250px;"><br>
面积：<input type="text" Name="mianji"  placeholder="面积" style="width:250px;"><br>
<input type="submit" Name="Action" value="发表文章" >
</form>
</div>
</div>
</body>
</html>