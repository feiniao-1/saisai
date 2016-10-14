<%@page import="com.mchange.v2.c3p0.impl.DbAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
<title>Insert title here</title>
  <link href="img/logo_03.jpg" rel="SHORTCUT ICON">
  <script type="text/javascript" src="js/nicEdit.js"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>
<%
//获取当前url
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jishu = "";
try{
jishu = request.getParameter("jishu");
System.out.println("jishu"+jishu);
}catch(Exception e){
	
}
//设置随机数
int  val = (int)(Math.random()*10000)+1;
int url_canshu;
if(jishu==null){
	url_canshu=Integer.parseInt("1");
}else{	
	url_canshu=Integer.parseInt(jishu);
}
//显示评论信息
int useridh=10049;
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from discuss where  userid=? order by discussid desc limit 1",new MapxListHandler(),useridh);
int canshu_url=showdiscuss1.get(0).getInt("canshu_url");
//获取评论信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String content;
System.out.println("url_canshu:"+url_canshu+"canshu_url"+canshu_url);
if(url_canshu!=canshu_url){
if(param.get("Action")!=null && param.get("Action").equals("发表评论")){
	content=new String(request.getParameter("content").getBytes("iso-8859-1"),"utf-8");
	if(content.equals("")||content.equals(null)){
	}else{
		DB.getRunner().update("insert into discuss(discusscontent,userid,canshu_url) values(?,?,?)",content,10049,url_canshu);
		content=null;
	}
}else{
}
}
//显示评论信息
List<Mapx<String,Object>> showdiscuss = DB.getRunner().query("select discusscontent as sh_discuss,userid as sh_userid,canshu_url as canshu_url from discuss where  userid=? order by discussid desc limit 10",new MapxListHandler(),useridh);
%>
</head>
<body>

评论<br>
<form id="form_tj" action="front_discuss.jsp?jishu=<%=val%>" method="post" >
<textarea id="discuss_content" rows="5" cols="35" name="content" ></textarea>
<input type="submit" Name="Action" value="发表评论" >
</form>
评论显示：<br>
    <% for(int i=0;i<showdiscuss.size();i++){
    	Mapx<String,Object> showdiscuss_1 = showdiscuss.get(i);
    	List<Mapx<String,Object>> user_xinxi = DB.getRunner().query("select username from user where  userid=? ",new MapxListHandler(),showdiscuss_1.getIntView("sh_userid"));
    	%>
            <%=user_xinxi.get(0).getString("username") %>&nbsp&nbsp<%=showdiscuss_1.getStringView("sh_discuss") %><br>
            
    	<%} %> 
</body>
</html>