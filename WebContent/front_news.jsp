<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
HashMap<String,String> param= G.getParamMap(request);
//获取url
String  url  =  "http://"  +  request.getServerName()  +  ":"  +  request.getServerPort()  +  request.getContextPath()+request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
String url1 = request.getRequestURI(); 

String url3=request.getRequestURI().toString(); //得到相对url 
String url2=request.getRequestURI().toString(); //得到绝对URL
//验证用户登陆
String username = (String)session.getAttribute("username");
int flag=0;
if(username==null){
	
}else{
	flag=1;
}
//获取页数信息
String index_page;
if(request.getParameter("page")==null){
	index_page=String.valueOf(0);
}else{
	index_page=request.getParameter("page");
}
int page_ye=Integer.parseInt(index_page)*5;
//搜索属性
String searchtj;

/*统计 新闻数及 页数*/
String sqlPreCount = "select count(1) as count from news where newstype=? and (del is NULL or del <>1)  order BY newsid DESC ";
List<Mapx<String,Object>> sqlPreCount1 =  DB.getRunner().query(sqlPreCount, new MapxListHandler(),"boke");
//总商品数量
int total = sqlPreCount1.get(0).getInt("count");
//商品页数
int count_page=total/5;
System.out.println("count_page"+count_page);

int plus;
int minus;
//下一页
if(Integer.parseInt(index_page)==count_page){
	plus=count_page;
}else{
	plus =Integer.parseInt(index_page)+1;
}
//上一页
if(Integer.parseInt(index_page)==1){
	minus =1;	
}else{
	minus =Integer.parseInt(index_page)-1;
}
//用户信息
//List<Mapx<String, Object>> user = DB.getRunner().query("select userid from user where username=? ",new MapxListHandler(), username);

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="">
		  <meta name="keywords" content="饺耳、美食">
		<title>新闻咨询</title>
		<link href="img/m-icon.png" type="image/x-icon" rel="shortcut icon" />	
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
						<li class="nLi on">
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
						<li class="nLi">
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
        <div class="news-banner"></div>
        <!--banner图部分结束-->
           <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
         	<div class="row">
         		<ol class="breadcrumb">
         		  <li>当前页面</li>	
				  <li><a href="index.html">饺耳</a></li>
				  <li class="active">新闻资讯</li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         	<div class="col-md-9">
	         			<div class="main-left">
	         				<h4 class="icon-zx" style="border-bottom: 1px solid #DD2727;">新闻资讯</h4>
	         				<!--板块一内容-->
							<div class="tab-inner cell-list">
								<div class="cell">
									<div class="pic">
										<img src="img/pic22.jpg" class="img-responsive">
										<span class="pic-tilte">资讯</span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp" target="_blank"><h3 class="color-dd2727 mb15">习近平致信祝贺“中国天眼”落成启用</h3></a>	
										<p class="mb20">
												<a href="front_news-inner.jsp" class="line3 color-666666">国家重大科技基础设施500米口径球面射电望远镜今天落成启用。习近平指出，500米口径球面射电望远镜是具有我国自主知识产权、世界重大单口径、最灵敏的射电望远镜。
													它的落成启用，对我国在科学前沿实现重大原创突破、加快创新驱动发展具有重要意义。国家重大科技基础设施500米口径球面射电望……</a>
										</p>
										<p class="color-666666">来自：新华社<span>|</span>2016-9-27<span class="glyphicon glyphicon-eye-open color-ff6600"></span>1377</p>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
								<div class="cell">
									<div class="pic">
										<img src="img/pic22.jpg" class="img-responsive">
										<span class="pic-tilte">新闻</span>
									</div>
									<div class="cell_primary">
										<a href=front_news-inner.jsp"" target="_blank"><h3 class="color-dd2727 mb15">习近平致信祝贺“中国天眼”落成启用</h3></a>	
										<p class="mb20">
												<a href="front_news-inner.jsp" class="line3 color-666666">国家重大科技基础设施500米口径球面射电望远镜今天落成启用。习近平指出，500米口径球面射电望远镜是具有我国自主知识产权、世界重大单口径、最灵敏的射电望远镜。
													它的落成启用，对我国在科学前沿实现重大原创突破、加快创新驱动发展具有重要意义。国家重大科技基础设施500米口径球面射电望……</a>
										</p>
										<p class="color-666666">来自：新华社<span>|</span>2016-9-27<span class="glyphicon glyphicon-eye-open color-ff6600"></span>1377</p>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
								<div class="cell">
									<div class="pic">
										<img src="img/pic22.jpg" class="img-responsive">
										<span class="pic-tilte">资讯</span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp" target="_blank"><h3 class="color-dd2727 mb15">习近平致信祝贺“中国天眼”落成启用</h3></a>	
										<p class="mb20">
												<a href="front_news-inner.jsp" class="line3 color-666666">国家重大科技基础设施500米口径球面射电望远镜今天落成启用。习近平指出，500米口径球面射电望远镜是具有我国自主知识产权、世界重大单口径、最灵敏的射电望远镜。
													它的落成启用，对我国在科学前沿实现重大原创突破、加快创新驱动发展具有重要意义。国家重大科技基础设施500米口径球面射电望……</a>
										</p>
										<p class="color-666666">来自：新华社<span>|</span>2016-9-27<span class="glyphicon glyphicon-eye-open color-ff6600"></span>1377</p>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
								<div class="cell">
									<div class="pic">
										<img src="img/pic22.jpg" class="img-responsive">
										<span class="pic-tilte">新闻</span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp" target="_blank"><h3 class="color-dd2727 mb15">习近平致信祝贺“中国天眼”落成启用</h3></a>	
										<p class="mb20">
												<a href="front_news-inner.jsp" class="line3 color-666666">国家重大科技基础设施500米口径球面射电望远镜今天落成启用。习近平指出，500米口径球面射电望远镜是具有我国自主知识产权、世界重大单口径、最灵敏的射电望远镜。
													它的落成启用，对我国在科学前沿实现重大原创突破、加快创新驱动发展具有重要意义。国家重大科技基础设施500米口径球面射电望……</a>
										</p>
										<p class="color-666666">来自：新华社<span>|</span>2016-9-27<span class="glyphicon glyphicon-eye-open color-ff6600"></span>1377</p>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
								<div class="cell">
									<div class="pic">
										<img src="img/pic22.jpg" class="img-responsive">
										<span class="pic-tilte">资讯</span>
									</div>
									<div class="cell_primary">
										<a href="front_news-inner.jsp" target="_blank"><h3 class="color-dd2727 mb15">习近平致信祝贺“中国天眼”落成启用</h3></a>	
										<p class="mb20">
												<a href="front_news-inner.jsp" class="line3 color-666666">国家重大科技基础设施500米口径球面射电望远镜今天落成启用。习近平指出，500米口径球面射电望远镜是具有我国自主知识产权、世界重大单口径、最灵敏的射电望远镜。
													它的落成启用，对我国在科学前沿实现重大原创突破、加快创新驱动发展具有重要意义。国家重大科技基础设施500米口径球面射电望……</a>
										</p>
										<p class="color-666666">来自：新华社<span>|</span>2016-9-27<span class="glyphicon glyphicon-eye-open color-ff6600"></span>1377</p>
										<div class="bdsharebuttonbox bd-share">
											<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
										</div>
									</div>
								</div>
								<!--分页内容标签开始-->
								<div class="nav-page">
								  <ul class="pagination">
								    <li><a href="#">&laquo;</a></li>
								    <li><a href="#">1</a></li>
								    <li><a href="#">2</a></li>
								    <li><a href="#">3</a></li>
								    <li><a href="#">...</a></li>
								    <li><a href="#">9</a></li>
								    <li><a href="#">10</a></li>
								    <li><a href="#">&raquo;</a></li>
								  </ul>
								</div>
							</div>
							<!--板块一内容结束-->
						</div>
         		</div>
         		<!--右边部分开始-->
         		
	         		<div class="col-md-3">
	         			<div class="main-right">
		         			<!--右边-板块一开始-->
		         			<div class="ad mb30">
		         				<a href="" target="_blank"><img src="img/wh-pic03_03.jpg" class="img-responsive"></a>
		         			</div>
		         			<!--右边-板块二开始-->
		         			<div class="celan celan2">
		         				<h4>热门资讯</h4>
		         				<ul>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         					<li><a href="" target="_blank">全球移动营销第一平台Morketing全球移动营销第一平台Morketing</a></li>
		         				</ul>
		         			</div>
		         			<!--右边-板块三开始-->
		         			<div class="celan celan3">
		         				<h4>视频</h4>
		         				<div class="video">
		         					<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"></a>
		         				</div>
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
	<script>
	$(function(){
	var $div_li=$('.title-nav .title-nav-item');
	$div_li.click(function(){
		$(this).addClass('active').siblings().removeClass('active');
		var index =$div_li.index(this);
		$('.course-slide >div').eq(index).show().siblings().hide();
		});	
	});
	</script>
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
		        $("body,html").stop().animate({"scrollTop":0},1000);
		    });
      })
	</script>
<!--百度分享js-->
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"18"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</html>
