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
<title>百科编辑</title>
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
String shuzi="";
try{
jishu = request.getParameter("jishu");
fileName = request.getParameter("fileName");
fullName1 = request.getParameter("fullName1");
fullName2 = request.getParameter("fullName2");
fullName3 = request.getParameter("fullName3");
fullName4 = request.getParameter("fullName4");
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
//显示博客信息
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from baike_article where  author=? order by articleid desc limit 1",new MapxListHandler(),dluserid);
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//编辑保存博客信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String title;
String content1;
String tag1;
String tag2;
String tag3;
String tag4;
String chinaname;
String Englishname;
String maining;
String function;
String character;
String usetime;
String step1;
String step2;
String step3;
String step4;
String img1;
String img2;
String img3;
String img4;
System.out.println("url_canshu:"+url_canshu+"canshu_url"+canshu_url);
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("发表文章")){
	title=new String(request.getParameter("title").getBytes("iso-8859-1"),"utf-8");
	content1=new String(request.getParameter("content1").getBytes("iso-8859-1"),"utf-8");
	tag1=new String(request.getParameter("tag1").getBytes("iso-8859-1"),"utf-8");
	tag2=new String(request.getParameter("tag2").getBytes("iso-8859-1"),"utf-8");
	tag3=new String(request.getParameter("tag3").getBytes("iso-8859-1"),"utf-8");
	tag4=new String(request.getParameter("tag4").getBytes("iso-8859-1"),"utf-8");
	chinaname=new String(request.getParameter("chinaname").getBytes("iso-8859-1"),"utf-8");
	Englishname=new String(request.getParameter("Englishname").getBytes("iso-8859-1"),"utf-8");
	maining=new String(request.getParameter("maining").getBytes("iso-8859-1"),"utf-8");
	function=new String(request.getParameter("function").getBytes("iso-8859-1"),"utf-8");
	character=new String(request.getParameter("character").getBytes("iso-8859-1"),"utf-8");
	usetime=new String(request.getParameter("usetime").getBytes("iso-8859-1"),"utf-8");
	step1=new String(request.getParameter("step1").getBytes("iso-8859-1"),"utf-8");
	step2=new String(request.getParameter("step2").getBytes("iso-8859-1"),"utf-8");
	step3=new String(request.getParameter("step3").getBytes("iso-8859-1"),"utf-8");
	step4=new String(request.getParameter("step4").getBytes("iso-8859-1"),"utf-8");
	img1="upload/"+(String)session.getAttribute("fullName1");
	img2="upload/"+(String)session.getAttribute("fullName2");
	img3="upload/"+(String)session.getAttribute("fullName3");
	img4="upload/"+(String)session.getAttribute("fullName4");
	System.out.println("img1"+img1);
	System.out.println("img1="+img1+"<br>img2="+img2+"<br>img3="+img3+"<br>img4="+img4);
	if((title.equals("")||title.equals(null))||(content1.equals("")||content1.equals(null))){
		%>
			<script type="text/javascript" language="javascript">
					alert("主体信息不能为空");                                            // 弹出错误信息
					window.location='admin_baike_edit.jsp' ;                            // 跳转到登录界面
			</script>
		<%
	}else{
		DB.getRunner().update("insert into baike_article(author,title,content1,createtime,tag1,tag2,tag3,tag4,canshu_url,chinaname,Englishname,maining,function,`character`,usetime,step1,step2,step3,step4,img1,img2,img3,img4,tagid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dluserid,title,content1,df.format(new Date()),tag1,tag2,tag3,tag4,url_canshu,chinaname,Englishname,maining,function,character,usetime,step1,step2,step3,step4,img1,img2,img3,img4,tagid);
		DB.getRunner().update("insert into news(author,title,content,createtime,newstype,img1,tagid) values(?,?,?,?,?,?,?)",dluserid,title,content1,df.format(new Date()),"baike",img1,tagid);
		session.removeAttribute("fullName1");
		session.removeAttribute("fullName2");
		session.removeAttribute("fullName3");
		session.removeAttribute("fullName4");
		System.out.println("数据写入成功");
		%>
		<script type="text/javascript" language="javascript">
				alert("发表成功");                                            // 弹出错误信息
				window.location='admin_baike_edit.jsp' ;                            // 跳转到登录界面
		</script>
	<%
	}
}else{
}
}

%>
</head>
<body>
<div class="panel panel-default container box-shadow"  style="text-align:center; padding-top:50px; margin-top:50px;">
    <div class="row">
<h3>填写博客信息</h3><br>

        <span style="margin-left:500px;">
        <a href="admin_boke_edit.jsp" class="btn btn-primary">发表博客</a>/<a  href="admin_baike_edit.jsp" class="btn btn-primary">发表百科</a>/<a href="admin_product.jsp" class="btn btn-primary">发表菜品</a>/<a href="front_index.jsp" class="btn btn-primary">首页</a></span><br>
        说明：请先上传图片，后填写主体信息。
        <br/>
     <!-- 图片上传start 1 -->
 	  	 <br/>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=1" method="post" enctype="multipart/form-data">
 	 <div style="margin-left:-100px;">图片格式：<span style="color:red;">79*60</span>
		<input type="file" name="attr_file1" style="display:inline-block;"></div>
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
  	   	<center><img alt="" src="upload/<%=(String)session.getAttribute("fullName1") %>" style="width:50px!important;" height="50px"><br></center> 
	<!-- 图片上传end  1-->
	     <!-- 图片上传start 2 -->
 	  	 <br/>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=2" method="post" enctype="multipart/form-data">
 	 <div style="margin-left:-100px;">
		<input type="file" name="attr_file2" style="display:inline-block;"></div>
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
  	 </form><br>
  	   	<center><img alt="" src="upload/<%=(String)session.getAttribute("fullName2") %>" style="width:50px!important;" height="50px"><br></center> 
	<!-- 图片上传end  2-->
	<!-- 图片上传start 3 -->
 	  	 <br/>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=3" method="post" enctype="multipart/form-data">
 	 <div style="margin-left:-100px;">
		<input type="file" name="attr_file3" style="display:inline-block;"></div>
		<div style="margin-top:-25px;margin-left:200px;">
		<%if(shuzi!=null&&shuzi.equals("3")){
			if(fullName3==null){
				//session.removeAttribute("fullName3");
			}else{
				if(fileName=="") {%>
					<script type="text/javascript" language="javascript">
					document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
				</script>
				<%}else{ %>
				<%
				session.setAttribute("fullName3", fullName3);
				} %>
			<%}
		}%>
					<%
			if((String)session.getAttribute("fullName3")!=null){%>
					<script type="text/javascript" language="javascript">
						document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
						
					</script>
			<%}else{ %>
			<%} %>
		<input type="submit" value="上传">  	</div>
  	 </form><br>
  	   	<center><img alt="" src="upload/<%=(String)session.getAttribute("fullName3") %>" style="width:50px!important;" height="50px"><br></center> 
	<!-- 图片上传end  3-->
	<!-- 图片上传start 4 -->
 	  	 <br/>
 	 <form action="${pageContext.request.contextPath }/uploadServlet?url=baike&shuzi=4" method="post" enctype="multipart/form-data">
 	 <div style="margin-left:-100px;">
		<input type="file" name="attr_file4" style="display:inline-block;"></div>
		<div style="margin-top:-25px;margin-left:200px;">
		<%if(shuzi!=null&&shuzi.equals("4")){
			if(fullName4==null){
				//session.removeAttribute("fullName4");
			}else{
				if(fileName=="") {%>
					<script type="text/javascript" language="javascript">
					document.write('<span style="color:red;">上传失败</span>');          // 跳转到登录界面
				</script>
				<%}else{ %>
				<%
				session.setAttribute("fullName4", fullName4);
				} %>
			<%}
		}%>
					<%
			if((String)session.getAttribute("fullName4")!=null){%>
					<script type="text/javascript" language="javascript">
						document.write('<span style="color:red;">上传成功</span>');          // 跳转到登录界面
						
					</script>
			<%}else{ %>
			<%} %>
		<input type="submit" value="上传">  	</div>
  	 </form><br>
  	   	<center><img alt="" src="upload/<%=(String)session.getAttribute("fullName4") %>" style="width:50px!important;" height="50px"><br></center> <BR>
  	 <br><BR>
  	 <br><BR>
  	 
	<!-- 图片上传end  4-->
<form id="form_tj" action="admin_baike_edit.jsp?jishu=<%=val%>" method="post" style="margin-top:-100px;">
标题<span style="color:red;">*(最多20字)</span>：<br><input type="text" Name="title"  placeholder="标题"><br>
描述<span style="color:red;">*(建议3-4行；最多200字)</span>：<br><center><textarea id="discuss_content" rows="3" cols="100" name="content1" placeholder="描述" ></textarea><br></center>
摘要(选填)：<br>
中文名：&nbsp;&nbsp;&nbsp;<input type="text" Name="chinaname"  placeholder="中文名" style="width:150px;"><br>
英文名：&nbsp;&nbsp;&nbsp;<input type="text" Name="Englishname"  placeholder="英文名" style="width:150px;"><br>
主要食材：<input type="text" Name="maining"  placeholder="主要食材" style="width:150px;"><br>
功效：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" Name="function"  placeholder="功效" style="width:150px;"><br>
特色：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" Name="character"  placeholder="特色" style="width:150px;"><br>
用时：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" Name="usetime"  placeholder="用时" style="width:150px;"><br>
做法：<br>
步骤一：<br>
<center><textarea id="discuss_content" rows="3" cols="100" name="step1" placeholder="步骤一" ></textarea><br></center>
步骤二：<br>
<center><textarea id="discuss_content" rows="3" cols="100" name="step2" placeholder="步骤二" ></textarea><br></center>
步骤三：<br>
<center><textarea id="discuss_content" rows="3" cols="100" name="step3" placeholder="步骤三" ></textarea><br></center>
步骤四：<br>
<center><textarea id="discuss_content" rows="3" cols="100" name="step4" placeholder="步骤四" ></textarea><br></center>
关键词（选填）：<br>
<input type="text" Name="tag1"  placeholder="标签1" style="width:50px;">
<input type="text" Name="tag2"  placeholder="标签2" style="width:50px;">
<input type="text" Name="tag3"  placeholder="标签3" style="width:50px;">
<input type="text" Name="tag4"  placeholder="标签4" style="width:50px;"><br>
<input type="submit" Name="Action" value="发表文章" >
</form>
</div>
</div>
</body>
</html>