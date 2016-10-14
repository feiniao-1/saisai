<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jx.common.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.dbutils.QueryRunner"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta name="description" content="">
		  <meta name="keywords" content="饺耳、美食">
		<title>百科问答内页</title>
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
		<%@ include file="baike_header.jsp"%>
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
						<li class="nLi ">
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
        <div class="baike-banner"></div>
        <!--banner图部分结束-->
        <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
         <div class="row">
         		<ol class="breadcrumb">
				  <li><a href="front_baike.jsp?page=0">饺耳</a></li>
				  <li><a href="front_baike.jsp?page=0">百科问答</a></li>
				  <li class="active">词条详情</li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         				<div class="baike-content">
	         				<%List<Mapx<String, Object>> baikexx=DB.getRunner().query("SELECT title,content1,img1,img2,img3,img4,step1,step2,step3,step4,chinaname,Englishname,maining,function,`character`,usetime,tag1,tag2,tag3,tag4 FROM `baike_article` where tagid=?", new MapxListHandler(), request.getParameter("tagid"));
	         				%>
		         				<h3><%=baikexx.get(0).getStringView("title") %></h3><!--关键词条-->
		         				<P class="color-666666 mb20 word-introduce"><%=baikexx.get(0).getStringView("content1") %></P>
		         				<!--简介-->
		         				<h4 class="icon-zy">摘要</h4>
		         				<table width="100%" border="1" cellspacing="0" class="mb30 table-zy">
		         					<tbody>
		         						<tr>
		         							<td>中文名</td>
		         							<td><%=baikexx.get(0).getStringView("chinaname") %></td>
		         							<td>英文名</td>
		         							<td><%=baikexx.get(0).getStringView("Englishname") %></td>
		         						</tr>
		         						<tr>
		         							<td>主要食材</td>
		         							<td><%=baikexx.get(0).getStringView("maining") %></td>
		         							<td>功效</td>
		         							<td><%=baikexx.get(0).getStringView("function") %></td>
		         						</tr>
		         						<tr>
		         							<td>特色</td>
		         							<td><%=baikexx.get(0).getStringView("character") %></td>
		         							<td>用时</td>
		         							<td><%=baikexx.get(0).getStringView("usetime") %></td>
		         						</tr>
		         					</tbody>
		         				</table>
		         				<h4 class="icon-zf">做法</h4>
		         				<div class="cell-list" style="position: relative; padding-bottom: 60px; margin-bottom: 30px;">
		         					<div class="cell">
		         						<div class="pic width200">
		         							<img src="<%=baikexx.get(0).getStringView("img1") %>">
		         						</div>
		         						<div class="cell_primary">
		         							<h4 class="mb10"><span class="step">1</span>步骤一</h4>
		         							<p><%=baikexx.get(0).getStringView("step1") %>
		         							</p>
		         						</div>
		         					</div>
		         					<div class="cell">
		         						<div class="pic width200">
		         							<img src="<%=baikexx.get(0).getStringView("img2") %>">
		         						</div>
		         						<div class="cell_primary">
		         							<h4 class="mb10"><span class="step">2</span>步骤二</h4>
		         							<p><%=baikexx.get(0).getStringView("step2") %>
		         							</p>
		         						</div>
		         					</div>
		         					<div class="cell">
		         						<div class="pic width200">
		         							<img src="<%=baikexx.get(0).getStringView("img3") %>">
		         						</div>
		         						<div class="cell_primary">
		         							<h4 class="mb10"><span class="step">3</span>步骤三</h4>
		         							<p><%=baikexx.get(0).getStringView("step3") %>
		         							</p>
		         						</div>
		         					</div>
		         					<div class="cell">
		         						<div class="pic width200">
		         							<img src="<%=baikexx.get(0).getStringView("img4") %>">
		         						</div>
		         						<div class="cell_primary">
		         							<h4 class="mb10"><span class="step">4</span>步骤四</h4>
		         							<p><%=baikexx.get(0).getStringView("step4") %>
		         							</p>
		         						</div>
		         					</div>
		         					<!--<div class="bdsharebuttonbox" style="position: absolute; right: 30px; bottom: 0;">
										<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
								    </div>-->
								    <div class="bdsharebuttonbox" style="position: absolute; right: 30px; bottom: 0;">
								    	<a href="#" class="bds_more" data-cmd="more">分享到：</a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信">微信</a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博">新浪微博</a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博">腾讯微博</a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网">人人网</a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间">QQ空间</a>
								    </div>

		         				</div>
		         				<!--做法结束-->
		         				<h4 class="icon-xg">相关</h4>
		         				<ul class="about-food clearfix">
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/food-sj.png">
			         						<p>韭菜饺子</p>
		         						</a>
		         					</li>
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/food-sj.png">
			         						<p>韭菜饺子</p>
		         						</a>
		         					</li>
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/food-sj.png">
			         						<p>韭菜饺子</p>
		         						</a>
		         					</li>
		         					<li class="mr0">
		         						<a href="" target="_blank">
			         						<img src="img/food-sj.png">
			         						<p>韭菜饺子</p>
		         						</a>
		         					</li>
		         				</ul>
		         				<h4 class="mb10">参考资料</h4>
		         				<div class="reference">
			         				<p><a href="" target="_blank">1.饺子的菜谱做法大全  ．香哈网[引用日期2014-05-24]</a></p>
			         				<p><a href="" target="_blank">2.饺子的菜谱做法大全  ．香哈网[引用日期2014-05-24]</a></p>
			         				<p><a href="" target="_blank">3.饺子的菜谱做法大全  ．香哈网[引用日期2014-05-24]</a></p>
			         				<p><a href="" target="_blank">4.饺子的菜谱做法大全  ．香哈网[引用日期2014-05-24]</a></p>
		         				</div>
		         				<h4 class="mb10">关键词</h4>
		         				<p class="about-word">
		         				<a href="" target="" class="mr20"><%=baikexx.get(0).getStringView("tag1") %></a>
		         				<a href="" target="" class="mr20"><%=baikexx.get(0).getStringView("tag2") %></a>
		         				<a href="" target="" class="mr20"><%=baikexx.get(0).getStringView("tag3") %></a>
		         				<a href="" target="" class="mr20"><%=baikexx.get(0).getStringView("tag4") %></a></p>
	         					<h4 class="mb10">链接</h4>
	         					<p class="about-link"><a href="" target="" class="mr20">饺耳水饺</a><a href="" target="" class="mr20">多野火锅</a><a href="" target="" class="mr20">寰宇汇智</a></p>
	         				</div>
	         			</div>
         		    </div>
         		<!--右边部分开始-->
	         		<div class="col-md-3">
	         			<div class="main-right">
	         				<!--广告图部分-->
	         				<div class="baike-content">
	         				<div class="ad mb30">
	         					<a href="" target="_blank"><img src="img/food-sj.png" class="img-responsive"></a>
	         				</div>
	         				<h4 class="icon-sp">相关视频</h4>
		         			<div class="video mb30">
		         				<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"  class="img-responsive"></a>
		         			</div>
		         			<h4  class="icon-tj">推荐</h4>
		         			<table width="100%" border="0" cellspacing="0" class="recommend">
		         			
		         				<tbody>
		         			<%List<Mapx<String, Object>> baiketitle=DB.getRunner().query("SELECT substring(title,1,6) as title FROM `baike_article` order by articleid desc limit 8", new MapxListHandler());
		         			for(int i=0;i<baiketitle.size();i=i+2){
	         				%>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank"><%=baiketitle.get(i).getStringView("title") %></a></td>
		         						<td width="50%"><a href="" target="_blank"><%=baiketitle.get(i+1).getStringView("title") %></a></td>
		         					</tr>
		         					<%} %>
		         				</tbody>
		         			</table>
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
