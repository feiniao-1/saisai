<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="javax.swing.JOptionPane"%>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式  
System.out.println(df.format(new Date()));// new Date()为获取当前系统时间  
//验证用户登陆
Mapx<String,Object> user = G.getUser(request);
String pageType = null;
String userType = null;
//验证用户登陆
String username = (String)session.getAttribute("username");
System.out.println("当前登录用户"+username);
List<Mapx<String, Object>> useridc= DB.getRunner().query("SELECT userid FROM user where username=?", new MapxListHandler(),username);
int flag=0;
if(username==null){
	
}else{
	flag=1;
}
//文章信息
List<Mapx<String, Object>> article=DB.getRunner().query("select articleid,author,title,content1,content2,zcount,tag1,tag2,tag3,tag4,img1,createtime from article where tagid=?", new MapxListHandler(),request.getParameter("tagid"));
int zcount;
if(article.get(0).getIntView("zcount").equals("")){
	zcount=0;
}else{
	zcount=Integer.parseInt(article.get(0).getIntView("zcount"));
}
//更新访问量加1
DB.getRunner().update("update article set zcount=? where tagid=?",zcount+1,request.getParameter("tagid"));
DB.getRunner().update("update news set count=? where tagid=?",zcount+1,request.getParameter("tagid"));
//当前文章的下一条文章信息
List<Mapx<String, Object>> articlenext=DB.getRunner().query("select title,tagid from article where articleid<? order by articleid desc limit 1", new MapxListHandler(),article.get(0).getIntView("articleid"));
System.out.println(articlenext);
//获取文章作者
List<Mapx<String, Object>> authorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),article.get(0).getStringView("author"));
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
//获取页数信息
String discuss_page;
if(request.getParameter("page")==null){
	discuss_page=String.valueOf(0);
}else{
	discuss_page=request.getParameter("page");
}
int page_ye=Integer.parseInt(discuss_page)*5;
//显示评论信息
int canshu_url;
int useridh=10049;
List<Mapx<String,Object>> showdiscuss1 = DB.getRunner().query("select canshu_url as canshu_url from discuss where  articleid=? order by discussid desc limit 1",new MapxListHandler(),article.get(0).getStringView("articleid"));
System.out.println("showdiscuss1"+showdiscuss1.size());
if(showdiscuss1.size()==0){
	canshu_url=1;
}else{
	canshu_url=showdiscuss1.get(0).getInt("canshu_url");
}
//获取评论信息
System.out.println(request.getMethod());//获取request方法 POST or GET
HashMap<String,String> param= G.getParamMap(request);
String content;
	if(url_canshu!=canshu_url){
	if(param.get("Action")!=null && param.get("Action").equals("发表评论")){
		if(flag==1){
			content=new String(request.getParameter("content").getBytes("iso-8859-1"),"utf-8");
			if(content.equals("")||content.equals(null)){
			}else{
				DB.getRunner().update("insert into discuss(discusscontent,visitor,canshu_url,discusstime,userid,articleid) values(?,?,?,?,?,?)",content,useridc.get(0).getIntView("userid"),url_canshu,df.format(new Date()),10049,article.get(0).getStringView("articleid"));
				content=null;
			}
		}else{
			//JOptionPane.showMessageDialog(null, "请登录", "请登录", JOptionPane.ERROR_MESSAGE); 
			//response.sendRedirect("front_login.jsp");
			%>
			<script type="text/javascript" language="javascript">
					alert("请登录");                                            // 弹出错误信息
					window.location='front_boke-inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>' ;                            // 跳转到登录界面
			</script>
		<%
		}
	}else{
	}
	}

//显示评论信息
List<Mapx<String,Object>> showdiscuss = DB.getRunner().query("select discusscontent as sh_discuss,userid as sh_userid,visitor as sh_visitor,canshu_url as canshu_url ,substring(discusstime,1,19) as discusstime from discuss where  articleid=? order by discussid desc limit "+page_ye+",5",new MapxListHandler(),article.get(0).getStringView("articleid"));

/*统计 评论数及 页数*/
String sqlPreCount = "select count(1) as count from discuss where  (del is NULL or del <>1) and userid=? order BY discussid DESC ";
List<Mapx<String,Object>> sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),useridh);
//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/5;
System.out.println("count_page"+count_page);
int plus;
int minus;
//下一页
if(Integer.parseInt(discuss_page)==count_page){
	plus=count_page;
}else{
	plus =Integer.parseInt(discuss_page)+1;
}
//上一页
if(Integer.parseInt(discuss_page)==0){
	minus =0;	
}else{
	minus =Integer.parseInt(discuss_page)-1;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="">
		  <meta name="keywords" content="饺耳、美食">
		<title>博客内页</title>
		<!--<link href="css/bootstrap.css" rel="stylesheet">-->
		<link href="img/toubiao.png" rel="SHORTCUT ICON">
		<link href="css/_main.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<script src="layer/layer.js"></script>
		<!--[if it iE8]>
			<p class="tixin">为了达到最佳观看效果，请升级到最新浏览器</p>
        -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	
	</head>
	<body>
		<!--视频弹出层开始-->
		<div class="video-box" style="display: none;">
			<video id="vPlayer" controls="controls"  width="100%" heigh="517" poster="img/video-bg.jpg" src="video/example.mp4"></video>
		</div>
		<!--视频弹出层结束-->
		<%@ include file="boke_header.jsp"%>
		<!--导航部分开始-->
        <div class="navbar">
        	<div class="container">
        		<div class="row">
			    	<ul id="nav2" class="nav2 clearfix">
						<li class="nLi">
								<h3><a href="front_index.jsp" >首页</a></h3>
						</li>
						<li class="nLi ">
								<h3><a href="front_news.jsp" >饺耳咨讯</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="front_product.jsp?cailei=1" >饺耳菜品</a></h3>
								<ul class="sub">
									<li><a href="front_product.jsp?cailei=1">特色水饺</a></li>
									<li><a href="front_product.jsp?cailei=2">开胃凉菜</a></li>
									<li><a href="front_product.jsp?cailei=3">精美热菜</a></li>
									<li><a href="front_product.jsp?cailei=4">滋补汤锅</a></li>
									<li><a href="front_product.jsp?cailei=5">酒水饮料</a></li>
								</ul>
						</li>
						<li class="nLi">
								<h3><a href="about-us.html" >关于饺耳</a></h3>
								<ul class="sub">
									<li><a href="about-us.html">公司介绍</a></li>
									<li><a href="about-us.html">公司文化</a></li>
									<li><a href="about-us.html">店铺活动</a></li>
									<li><a href="about-us.html">人才招聘</a></li>
									<li><a href="about-us.html">联系我们</a></li>
								</ul>
						</li>
						<li class="nLi on">
								<h3><a href="front_boke.jsp?page=0" >饺耳博客</a></h3>
						</li>
						<li class="nLi">
								<h3><a href="#" >饺耳社区</a></h3>
						</li>

					</ul>


        		</div>
		    </div>
		</div>
        <!--导航部分结束-->
		        <!--banner图部分开始-->
        <div id="homepage-feature" class="carousel slide">
						<ol class="carousel-indicators">
							<li data-target="#homepage-feature" data-slide-to="0" class="active"> </li>
							<li data-target="#homepage-feature" data-slide-to="1"> </li>
							<li data-target="#homepage-feature" data-slide-to="2"> </li>
							<li data-target="#homepage-feature" data-slide-to="3"> </li>
						</ol>
						<!--图片板块-->
						<div class="carousel-inner">
							<div class="item active">
								<img src="img/banner01.jpg" alt="图片1"/>
							</div>
							<div class="item">
								<img src="img/banner02.jpg" alt="图片2"/>
							</div>
							<div class="item">
								<img src="img/banner03.jpg" alt="图片3"/>
							</div>
							<div class="item">
								<img src="img/banner04.jpg" alt="图片4"/>
							</div>
						</div>
						<!--左右控制按钮 -->
						<a class="left carousel-control" href="#homepage-feature" data-slide="prev">
							<span class="glyphicon glyphicon-chevron-left"></span>
						</a>
						<a class="right carousel-control" href="#homepage-feature" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right"></span>
						</a>
		</div>
        <!--banner图部分结束-->
        <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
          <div class="row">
         		<ol class="breadcrumb">
				  <li><a href="front_boke.jsp?page=0">饺耳</a></li>
				  <li><a href="front_boke.jsp?page=0">饺耳博客</a></li>
				  <li class="active">博客详情</li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         				<!--文章部分开始-->
	         				<div class="article">
	         					<h3 class="color-dd2727 mb15"><%=article.get(0).getStringView("title") %></h3>
	         					<div class="cell">
	         						<div class="cell_primary">
	         							<p class="color-666666">来自：<%=authorxx.get(0).getStringView("username") %><span class="m_r_l-10">|</span><%=article.get(0).getStringView("createtime") %><span class="glyphicon glyphicon-eye-open color-ff6600 m_r_l-10"></span><%=zcount+1 %></p>
	         						</div>
	         						<div class="cell_primary">
	         							<div class="bdsharebuttonbox">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
	         						</div>
	         					</div>
	         					<div class="summary">
	         						<p><%=article.get(0).getStringView("content1") %></p>
	         					</div>
	         					<div class="article-pic mb20">
	         						<img src="<%=article.get(0).getStringView("img1") %>">
	         					</div>
	         					<div class="article-word" >
	         						<%=article.get(0).getStringView("content2") %>
	         					</div>
	         					<p class="lable color-ff6600"><%
	         					if(article.get(0).getStringView("tag1").equals("")&&article.get(0).getStringView("tag2").equals("")&&article.get(0).getStringView("tag3").equals("")&&article.get(0).getStringView("tag4").equals("")){
	         					%><%}else{ %>词条标签：<%} %>
	         					<%
	         					if(!article.get(0).getStringView("tag1").equals("")){
	         					%>
	         					<a href="" target="_blank"><%=article.get(0).getStringView("tag1") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag2").equals("")){%>
	         					<a href="" target="_blank"><%=article.get(0).getStringView("tag2") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag3").equals("")){%>
	         					<a href="" target="_blank"><%=article.get(0).getStringView("tag3") %></a>
	         					<%}%>
	         					<%if(!article.get(0).getStringView("tag4").equals("")){%>
	         					<a href="" target="_blank"><%=article.get(0).getStringView("tag4") %></a>
	         					<%}%>
	         					</p>
	         					<h4 class="next-article-tilte"><a href="front_boke-inner.jsp?page=0&tagid=<%=articlenext.get(0).getIntView("tagid")%>" target="_blank">下一篇：<%=articlenext.get(0).getStringView("title") %></a></h4>
	         				</div>
	         				<!--文章部分结束-->
	         				<!--评价部分开始-->
	         				<div class="evaluate">
	         					<h4>发表评论</h4>
	         					<form id="form_tj" action="front_boke-inner.jsp?page=0&jishu=<%=val%>&tagid=<%=request.getParameter("tagid") %>" method="post"  class="clearfix mb20">
		         					<textarea placeholder="写出你的点评" id="discuss_content" rows="5" cols="35" name="content"></textarea>
		         					<input type="submit" Name="Action" value="发表评论" class="submit-fb" >
	         					</form>
	         					<div class="evaluate-list">
	         					 <% for(int i=0;i<showdiscuss.size();i++){
						    	Mapx<String,Object> showdiscuss_1 = showdiscuss.get(i);
						    	List<Mapx<String,Object>> user_xinxi = DB.getRunner().query("select username from user where  userid=? ",new MapxListHandler(),showdiscuss_1.getIntView("sh_userid"));
						    	//获取访客用户
						    	
						    	List<Mapx<String, Object>> visitorxx= DB.getRunner().query("SELECT username FROM user where userid=?", new MapxListHandler(),showdiscuss_1.getIntView("sh_visitor"));
						    	System.out.println("showdiscuss_1"+showdiscuss_1);
						    	%>
						    		<div class="cell" style="align-items:flex-start;">
	         							<div class="pic-tx">
	         								<img src="img/visitor.png">
	         							</div>
	         							<div class="cell_primary">
	         								<h5 class="mb10"><%=visitorxx.get(0).getStringView("username") %></h5>
	         								<p class="color-666666 mb10"><%=showdiscuss_1.getStringView("sh_discuss") %></p>
	         								<p class="color-999999"><span class="mr20">时间：<%=showdiscuss_1.getStringView("discusstime")%></span><a href="javascript:;" class=" mr10"><span class="glyphicon glyphicon-thumbs-up"></span></a>66</p>
	         							</div>
	         						</div>
						            
						    	<%} %> 
	         					</div>
	         					<div class="nav-page">
								    <ul class="pagination">
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=<%=minus%>">«</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=0">1</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=1">2</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=2">3</a></li>
								    <li><a>...</a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=<%=count_page-1%>"><%=count_page%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=<%=count_page%>"><%=count_page+1%></a></li>
								    <li><a href="${pageContext.request.contextPath}/front_boke-inner.jsp?page=<%=plus%>">»</a></li>
								  </ul>
								</div>
	         				</div>
	         				<!--评价部分结束-->
	         		    </div>
         		    </div>
         		<!--右边部分开始-->
         		
	         		<div class="col-md-3">
	         			<div class="main-right">
		         			<!--右边-板块一开始-->
		         			<div class="celan celan1">
		         				<h4>图片集</h4>
		         				<ul class="clearfix">
		         				<%List<Mapx<String, Object>> wzt=DB.getRunner().query("select img1 ,substring(title,1,4) as  title,tagid from news where newstype=? order by newsid desc limit 9", new MapxListHandler(),"boke");
		         				for(int index_tp=0;index_tp<9;index_tp++){ 
		         				if(((index_tp+1)%3)!=0){%>
		         					<li> 
		         						<a href="front_boke-inner.jsp?page=0&tagid=<%=wzt.get(index_tp).getIntView("tagid") %>" target="_blank"><img src="<%=wzt.get(index_tp).getStringView("img1")%>" ></a>
		         						<p><%=wzt.get(index_tp).getStringView("title")%></p>
		         					</li>
		         					<%}else{ %>
		         					<li  class="mr0">
		         						<a href="front_boke-inner.jsp?page=0&tagid=<%=wzt.get(index_tp).getIntView("tagid") %>" target="_blank"><img src="<%=wzt.get(index_tp).getStringView("img1")%>"></a>
		         						<p><%=wzt.get(index_tp).getStringView("title")%></p>
		         					</li>
		         					<%} }%>
		         				</ul>
		         			</div>
		         			<!--右边-板块二开始-->
		         			<div class="celan celan2">
		         				<h4>最新文章</h4>
		         				<ul>
		         				<%List<Mapx<String, Object>> wzm=DB.getRunner().query("select title,tagid from news where newstype=?  order by newsid desc limit 6", new MapxListHandler(),"boke");
		         				for(int index_wz=0;index_wz<wzm.size();index_wz++){ %>
		         					<li><a href="front_boke-inner.jsp?page=0&tagid=<%=wzm.get(index_wz).getIntView("tagid") %>" target="_blank"><%=wzm.get(index_wz).getStringView("title") %></a></li>
		         				<%} %>
		         				</ul>
		         			</div>
		         			<!--右边-板块三开始-->
		         			<div class="celan celan3">
		         				<h4>视频</h4>
		         				<div class="video">
		         					<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"></a>
		         				</div>
		         			</div>
		         			<!--右边-板块四开始-->
		         			<div class="celan celan4">
		         				<h4>你可能感兴趣</h4>
		         				<ul class="keyword-first clearfix">
		         				<%List<Mapx<String, Object>> targ=DB.getRunner().query("select  substring(searchname,1,4) as searchname from search_count where searchtype=? order by searchtj desc limit 9",new MapxListHandler(),"boke");
		         				
		         				%>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(0).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(0).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(1).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(1).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(2).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(2).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(3).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(3).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(4).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(4).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(5).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(5).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(6).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(6).getStringView("searchname") %></a></li>
		         					<li class="bqb-width"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(7).getStringView("searchname") %>" class="bg_color-ff6600"><%=targ.get(7).getStringView("searchname") %></a></li>
		         					<li class="bqb-width mr0"><a href="front_boke.jsp?page=0&searchname=<%=targ.get(8).getStringView("searchname") %>" class="bg_color-dd2727"><%=targ.get(8).getStringView("searchname") %></a></li>
		         				</ul>
		         			</div>
		         			<!--右边-板块五开始-->
		         			<div class="celan5">
		         				<img src="img/pic18_03.jpg" />
		         			</div>
	         			</div>
         		</div>
         		<!--右边部分结束-->
         	</div>
         	
         </div>  
       </div>  
        <!--博客主体内容结束-->
        <!--页面底部板块开始-->
		<%@ include file="footer.jsp"%>
        <!--页面底部板块结束-->
	</body>
	<!--主内容区左边标题导航tab切换js-->
	<!--<script>
	$(function(){
	var $div_li=$('.title-nav .title-nav-item');
	$div_li.click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		var index =$div_li.index(this);
		$('.course-slide >div').eq(index).show().siblings().hide();
		});	
	});
	</script>-->
	<!--导航下拉菜单js部分-->
	<script src="js/jquery.SuperSlide.2.1.1.js"></script>
	<script id="jsID" type="text/javascript">
			
			jQuery("#nav2").slide({ 
				type:"menu",// 效果类型，针对菜单/导航而引入的参数（默认slide）
				titCell:".nLi", //鼠标触发对象
				targetCell:".sub", //titCell里面包含的要显示/消失的对象
				effect:"slideDown", //targetCell下拉效果
				delayTime:300 , //效果时间
				triggerTime:0, //鼠标延迟触发时间（默认150）
				returnDefault:true //鼠标移走后返回默认状态，例如默认频道是“预告片”，鼠标移走后会返回“预告片”（默认false）
			});
	</script>
	<!--视频弹出层js开始-->
	<script>
		$(function(){
			$(".play-video").click(function(){
			layer.open({
				  type: 1, 
				  title: false,//不要标题
				  area: ['930px', '537px'],//区域宽和高
				  shadeClose:1,//点击遮罩层关闭弹窗
				  content: $(".video-box") //这里显示内容
			});
		})	
		})
	</script>
	<!--返回顶部js部分-->
	<script>
		$(function(e) {
            var T=0;
		    $(window).scroll(function(event) {
		        T=$(window).scrollTop();
		
		        if(T>500)
		        {
		            $("#topcontrol").fadeIn();
		        }
		        else
		        {
		            $("#topcontrol").fadeOut();
		        }
		
		    });
		    $("#topcontrol").click(function(event) {
		        $("body,html").stop().animate({"scrollTop":0},1000);//一秒钟时间回到顶部
		    });
      })
	</script>
<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"18"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
