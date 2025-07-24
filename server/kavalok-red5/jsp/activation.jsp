<%@ page import="com.kavalok.dao.UserDAO, com.kavalok.db.User, com.kavalok.db.MarketingInfo, com.kavalok.transactions.DefaultTransactionStrategy, org.slf4j.Logger, org.slf4j.LoggerFactory, com.kavalok.user.UserUtil" %>
<%Logger logger = LoggerFactory.getLogger("activationJSP");

 	String activationKey = request.getParameter("activationKey");
 	String login = request.getParameter("login");
 	Boolean chatEnabled = "1".equals(request.getParameter("chatEnabled"));
 	
 	String chatType = chatEnabled?"full":"safe";
	boolean activated = false;

  DefaultTransactionStrategy dts = new DefaultTransactionStrategy();
  try {
    dts.beforeCall();

    logger.info("activating login: "+login + " activationKey: "+activationKey+" chatEnabled: " +chatEnabled);
    
    activated = (new UserUtil()).activateAccount(dts.getSession(), login, activationKey, chatEnabled);

    dts.afterCall();
  } catch (Exception e) {
    dts.afterError(e);
    logger.error("Error processing transaction", e);
  } %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>Chobots.com - Your Family Game!</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="keywords" content="family virtual world, kids and parents, kids education, learn by playing, fun online games for children, fun games for children, online games for kids, games on line for kids, children online games, online games for children, online games for preschool, online games for preschoolers, online games for preschool children, educational online games for children, free online games for young children, online games for small children" />
  <meta name="description" content="Chobots.com is an entertaining virtual world, a family game aimed at creating an interesting, safe and learning environment for your kids." />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="-1" />
	<link rel="stylesheet" href="/stylesheets/style.css" type="text/css" media="screen" title="no title" charset="utf-8" />

	<!--[if IE]><link rel="stylesheet" href="/stylesheets/ie.css" type="text/css" media="screen" title="no title" charset="utf-8" /><![endif]-->
	<script>
	  var ch_locale = 'enUS';
	  var ch_language = 'en';
	</script>
  <script src="/javascripts/game.js" type="text/javascript"></script> 
	
<style>
  div.ingame {
    display:none;
  }
</style>


	
</head>
<body>
	<div class="wrapper">

		
<div class="content index">
	<div class="text" style="height: 650px; border">
    
<div class="menu">
  <ul>
    
    <li><span><span><a href="/index.html"><span><span>Home</span></span></a></li>
    
    <li><span><span><a href="/play.html#membership"><span><span>Membership</span></span></a></li>
    
    <li><span><span><a href="/blog"><span><span>Community</span></span></a></li>

    
    <li><span><span><a href="/contact_us.html"><span><span>Contact us</span></span></a></li>
    
    <li class="play"><a href="/play.html#login"></a></li>
  </ul>
</div> 
<pre>
</pre>
<script>
$('.menu li:has(a[href$='+window.location.pathname+window.location.hash+']),.menu li:first').eq(0).addClass('current');
$('div.menu > ul > li a').click(function(){
  $('.menu li.current').removeClass('current');  
  $('.menu li:has(a[href$='+this.pathname+this.hash+'])').addClass('current');
})
</script>
		<div class="buttons">
			<a href="/play.html#register"><img src="/images/register-en.gif" alt="Register" ondragstart="return false;"/></a>
			<a href="/play.html#login"><img src="/images/play-en.gif" alt="Login" ondragstart="return false;"/></a>

		</div>
		<div class="inner">
			<h1 class="title">Chobots account activation</h1>
			<%
				if(activated){
			%>
			<p><b>Congratulations!<br>
			Your account is successfully activated with <b><%=chatType%></b> chat. Have fun playing!</b></p>			
			<%
				}else{
			%>
			<p><font color="red"><b>Activation key is not valid!</b></font></p>
			<%
				}
			%>
		</div>
		<div class="gallery-wrapper">
			<div class="preview">
				<div id="previewflash"></div>
				<!--div class="controls">
				  <img src="/images/pause.png" alt="Pause" height="39" width="39"/><img style="display:none" src="/images/play.png" alt="Play" height="39" width="39"/>
				</div-->
			</div> <!-- preview -->
			<div class="caption">
				<span class="number">1</span>
				<p>Spring with Chobots!</p>
				<p style="display:none">Play Collaborative Casual Games Designed for the Whole Family!<br/>100% Free!</p>
				<p style="display:none">Join the biggest Kid's Community of Earth Researchers!<br/>Chat and Make Friends!</p>
				<p style="display:none">Create and Design!<br/>Graffiti Art, Your Style, Your House and even Your Pet!</p>
				<p style="display:none">24/7 Live Moderation combined with innovative technological solutions!</p>
			</div> <!-- caption -->
			<ul class="gallery"> 
				<li onmousedown="galeryStop();"><img src="/images/gallery/pic1.jpg" width="92" alt="Play Collaborative Casual Games" /></li>
				<li onmousedown="galeryStop();"><img src="/images/gallery/pic2.jpg" width="92" alt="Join the biggest Kid's Community of Earth Researchers!<" /></li>
				<li onmousedown="galeryStop();"><img src="/images/gallery/pic3.jpg" width="92" alt="Create and Design!" /></li> 
				<li onmousedown="galeryStop();"><img src="/images/gallery/pic4.jpg" width="92" alt="24/7 Live Moderation" /></li>
				<li onmousedown="galeryStop();"><img src="/images/gallery/pic5.jpg" width="92" alt="Help Saving the Earth" /></li> 
			</ul>
			<div class="overlap">&nbsp;</div> <!-- overlap -->
		</div> <!-- gallery -->
	</div>

	<div class="character">
		<div class="logo" style="margin-right: 40px">
			<a href="/"><img src="/images/logo.png" alt="Chobots" /></a>
		</div> <!-- logo -->
		<div class="arrow">&nbsp;</div> <!-- arrow -->
	</div>
	<div class="decor left-side">&nbsp;</div> <!-- decor -->
</div>


<div class="content ingame onblue">
  
<div class="menu">
  <ul>
    
    <li><span><span><a href="/index.html"><span><span>Home</span></span></a></li>
    
    <li><span><span><a href="/play.html#membership"><span><span>Membership</span></span></a></li>
    
    <li><span><span><a href="/blog"><span><span>Community</span></span></a></li>
    
    <li><span><span><a href="/contact_us.html"><span><span>Contact us</span></span></a></li>
    
    <li class="play"><a href="/play.html#login"></a></li>
  </ul>
</div> 
<pre>
</pre>
<script>
$('.menu li:has(a[href$='+window.location.pathname+window.location.hash+']),.menu li:first').eq(0).addClass('current');
$('div.menu > ul > li a').click(function(){
  $('.menu li.current').removeClass('current');  
  $('.menu li:has(a[href$='+this.pathname+this.hash+'])').addClass('current');
})
</script>
	<div class="logo">
		<a href="/"><img src="/images/logo.png" alt="Chobots" /></a>
	</div> <!-- logo -->
	<div class="game">
    
	</div> <!-- game -->
  <script type="text/javascript">
  //<![CDATA[
    window.ch_dimention = window.original_ch_dimention = {width:'100%', height:'517px'};
    $(function(){
      ch_install_swf("MainLoader.swf", window.ch_dimention);
      $('a[href^=/play]').click(function(){ch_change_flash_mode(this.hash.substring(1));return false;});
    })

    ch_set_mode(window.location.hash.substring(1));
  //]]>
  </script>
</div>


<script type="text/javascript" charset="utf-8">
window.ch_dimention={width:'1px', height:'1px'};
$('.ingame .logo a, .menu li a[href^=/index]').click(ch_back);
$('.gallery li').click(function(){
  var was_started = galeryStop();
  $('.gallery li[selected=true]').attr('selected', false);
  $(this).attr('selected', true);

  var thumb = $('img', this);
  var new_src = thumb.attr('src').replace('.jpg', '.swf');
  new_src = new_src.replace('/images/gallery/', '/flash/');
  var offset = thumb.offset();

  var current_index = $(this).attr('index');
  var frame_position= -95 + 106*current_index;
  $('#selected_overlap').animate({marginLeft : frame_position+'px'}, 500, 'swing');

  //$('.preview > img').hide().attr('src', new_src).fadeIn(1000);
  $('#previewflash').html('<object width="530" height="230"><param name="movie" value="'+new_src+'"/><embed width="530" height="230" src="'+new_src+'"/></object>');

  var index = $(this).attr('index');
  $('.caption span.number').html(index-0+1);
  $('.caption p').hide();
  $('.caption p:eq('+index+')').show();
  if ( was_started ) {
    galeryStart();
  }
  return false;
})

function galeryStop() {
  var result = window.gallery_timer != null;
  if (result) {  
    window.clearInterval(window.gallery_timer);
    window.gallery_timer = null;
  }
  return result;
}

function galeryStart() {
  window.gallery_timer = window.setInterval(function(){
      // get the next element after the selected one, or the first in the row and CLICK it
      $('.gallery li[selected=true] + li,.gallery li:first').eq(0).click();
    }, 5000);
}

$('.gallery li img').after('<img alt="overlap" width="92" height="64" src="images/thumb_overlap.png" style="margin-left: -92px; position: absolute;"/>')
$('.gallery li:first img:last').after('<img id="selected_overlap" width="98" height="70" alt="overlap selected" src="images/thumb_overlap_selected.png" style="margin-left: -95px; margin-top: -3px; position: absolute; z-index:100"/>')
$('.gallery li').each(function(i){$(this).attr('index', i)})
//galeryStart();

$('.controls > *').click(function(){
    $('.controls > *').toggle();
    if (!galeryStop()){
        galeryStart();
    }
    return false;
});

$(function(){
	var height = $("div.content div.text").height();
	$("div.character").height(height);

  $('.gallery li:first').click();
});

jQuery.preloadImages = function() {
  for(var i = 0; i<arguments.length; i++) {
    jQuery("<img>").attr("src", arguments[i]);
  }
}

function ch_back(){
  $('div.ingame').hide();
  $('div.index').show();
  $('#flashContent').attr(window.ch_dimention);
  return false;
}

$.preloadImages('/images/play.png', '/images/gallery/img1.jpg', '/images/gallery/img2.jpg', '/images/gallery/img3.jpg', '/images/gallery/img4.jpg', '/images/gallery/img5.jpg');
</script>

	</div>
	
    <div id="flashContent">
    <!--  
      <p align="center" style="color:#FFFFFF;font-family:Arial, Helvetica, sans-serif;">
        Flash player is not installed
      </p>
      <p align="center">
        <a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
      </p>
    -->
    </div>
    
  <div class="wrapper">
		<div class="footer">
			<span class="copyright">Chobots &#8482; Vayersoft LLC &copy; 2007-2009. All rights reserved.</span><br />
			<a href="/privacy_policy.html" target="_blank">Privacy Policy</a>
			<a href="/terms_and_conditions.html" target="_blank">Terms and Conditions</a>
			<a href='#' class="lang"><img src="/images/lang.gif" alt="lang" /></a>
		</div>
	</div> <!-- wrapper -->

  <script type="text/javascript">
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<script type="text/javascript">
		var pageTracker = _gat._getTracker("UA-5914122-1");
    pageTracker._setDomainName("none");
    pageTracker._setAllowLinker(true);
    pageTracker._initData();
		pageTracker._trackPageview();
	</script>

  <!-- Start Quantcast tag -->
  <script type="text/javascript">
  _qoptions={
  qacct:"p-0aP0z-r3jkFbM"
  };
  </script>
  <script type="text/javascript" src="http://edge.quantserve.com/quant.js"></script>
  <noscript>
  <img src="http://pixel.quantserve.com/pixel/p-0aP0z-r3jkFbM.gif" style="display: none;" border="0" height="1" width="1" alt="Quantcast"/>
  </noscript>
  <!-- End Quantcast tag -->
</body>
</html>