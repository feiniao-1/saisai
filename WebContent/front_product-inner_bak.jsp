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
		<title>菜品详情页</title>
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
						<li class="nLi on">
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
        <div class="product-banner"></div>
        <!--banner图部分结束-->
        <!--博客主体内容开始-->
        <div class="mainbox">
         <div class="container">
         	<div class="row">
         		<ol class="breadcrumb">
         		  <li>当前页面</li>	
				  <li><a href="#">饺耳</a></li>
				  <li><a href="front_product.jsp">饺耳菜品</a></li>
				  <li class="active">饺耳红烧肉</li>
				</ol>
         	</div>
         	<div class="row">
         		<!--左边部分开始-->
	         		<div class="col-md-9">
	         			<div class="main-left">
	         				<div class="product-detail">
	         					<div class="bdsharebuttonbox" style="position: absolute; right: 0px; top: 5px;">
								    <a href="#" class="bds_more" data-cmd="more">分享到：</a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信">微信</a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博">新浪微博</a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博">腾讯微博</a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网">人人网</a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间">QQ空间</a>
								</div>
		         				<h3 class="color-dd2727 mb20">饺耳红烧肉</h3>
		         				<img src="img/big-pic01_03.jpg" class="img-responsive mb20" />
		         				<p class="txt-indent color-666666 mb30 dash-line">红烧肉是热菜菜谱之一。以五花肉为制作主料，红烧肉的烹饪技巧以砂锅为主，肥瘦相间，香甜松软，入口即化。红烧肉在我国各地流传很广，是一道著名的大众菜肴。</p>
	         					<h4 class="icon-cp mb20">菜品介绍</h4>
	         					<img src="img/big-pic02_03.jpg" class="img-responsive mb20">
	         					<h4 class="text-center color-ff6600 mb20">纯天然饲养的长白猪</h4>
	         					<p>1.长白猪原产于丹麦，是世界著名的瘦肉型猪种。</p>
	         					<p class="mb30">2.自家自制纯天然饲料喂养，不含任何添加剂，可放心使用。</p>
	         					<img src="img/big-pic03_03.jpg" class="img-responsive mb20">
	         					<h4 class="text-center color-ff6600 mb20">肉质细腻鲜红</h4>
	         					<p>含有丰富的蛋白质及脂肪、碳水化合物、钙、铁、磷等成分。</p>
	         					<p class="mb30">肌肉组织中含有较多的肌间脂肪，因此，经过烹调加工后肉味特别鲜美。</p>
	         					<img src="img/big-pic04_03.jpg" class="img-responsive mb20">
	         					<h4 class="text-center color-ff6600 mb20">精湛工艺加工</h4>
	         					<p class="mb30">锅里放油（多放点），热后放入糖（白糖也可）一勺（可多放点），炒到糊为止（这时候锅里应该在冒浓烟，别怕）。倒入切好的肉和调料（厚片的姜、成瓣（不要弄碎）的蒜头、桂皮、干辣椒、八角、橙子皮（非陈皮）），大火爆炒三分钟，这时肉变成了深红色</p>
	         					<img src="img/big-pic05_03.jpg" class="img-responsive mb20">
	         					<h4 class="text-center color-ff6600 mb20">饺耳红烧肉油而不腻</h4>
	         					<p class="mb30">饺耳红烧肉稍有甜味，极其美味，肥而不腻，口感极佳。</p>
	         					<img src="img/big-pic06_03.jpg" class="img-responsive mb20">
	         					<h4 class="text-center color-ff6600 mb20">饺耳红烧肉食用功效</h4>
	         					<p class="mb30 dash-line">
	         						1.补虚强身，滋阴润燥、丰肌泽肤的作用。<br />
									2.凡病后体弱、产后血虚、面黄赢瘦者，皆可用之作营养滋补之品。 <br />
									3.饺耳红烧肉性平味甘，有润肠胃、生津液、补肾气、解热毒的功效<br />
									4.饺耳红烧肉还主治热病伤津、消渴羸瘦、肾虚体弱、燥咳、便秘、补虚、滋阴、润燥、滋肝阴、润肌肤、利小便和止消渴。
	         					</p>
	         					<h4 class="icon-xg">店长推荐</h4>
		         				<ul class="about-food clearfix">
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/wh-pic02_03.jpg">
			         						<p>蓝莓山药</p>
		         						</a>
		         					</li>
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/wh-pic03_03.jpg">
			         						<p>非诚勿扰</p>
		         						</a>
		         					</li>
		         					<li>
		         						<a href="" target="_blank">
			         						<img src="img/wh-pic04_03.jpg">
			         						<p>西红柿鸡蛋饺子</p>
		         						</a>
		         					</li>
		         					<li class="mr0">
		         						<a href="" target="_blank">
			         						<img src="img/wh-pic05_03.jpg">
			         						<p>金牌水饺</p>
		         						</a>
		         					</li>
		         				</ul>
	         				</div>
	         			</div>
         		    </div>
         		<!--右边部分开始-->
	         		<div class="col-md-3">
	         			<div class="main-right">
	         				<!--广告图部分-->
	         				<div class="baike-content">
	         				<div class="ad mb30">
	         					<a href="" target="_blank"><img src="img/wh-pic03_03.jpg" class="img-responsive"></a>
	         				</div>
	         				<h4 class="icon-sp">相关视频</h4>
		         			<div class="video mb30">
		         				<a href="javascript:;" class="play-video"><img src="img/video-pic_03.jpg"  class="img-responsive"></a>
		         			</div>
		         			<h4  class="icon-tj">推荐</h4>
		         			<table width="100%" border="0" cellspacing="0" class="recommend">
		         				<tbody>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank">红烧肉做法</a></td>
		         						<td width="50%"><a href="" target="_blank">醋溜土豆丝做法</a></td>
		         					</tr>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank">红烧肉做法</a></td>
		         						<td width="50%"><a href="" target="_blank">醋溜土豆丝做法</a></td>
		         					</tr>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank">红烧肉做法</a></td>
		         						<td width="50%"><a href="" target="_blank">醋溜土豆丝做法</a></td>
		         					</tr>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank">红烧肉做法</a></td>
		         						<td width="50%"><a href="" target="_blank">醋溜土豆丝做法</a></td>
		         					</tr>
		         					<tr>
		         						<td width="50%"><a href="" target="_blank">红烧肉做法</a></td>
		         						<td width="50%"><a href="" target="_blank">醋溜土豆丝做法</a></td>
		         					</tr>
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
