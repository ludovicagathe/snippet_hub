<?php
$js =<<<JS
(function(jQuery) {
  jQuery(document).ready(function(){
    var ca = document.cookie.split(';');
    var toaster_cookie = '';
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        cname = 'lexptoasterhide';
        if (c.indexOf(cname) == 0) toaster_cookie = c.substring(cname.length, c.length);
    }
    if(toaster_cookie == '') {
      jQuery(window).scroll(function(){
        var distanceTop = jQuery('.node-links').offset().top - jQuery(window).height();
        if  (jQuery(window).scrollTop() > distanceTop)
          jQuery('#block-views-article-sponsoris-block-2').show().animate({'right':'-2170px'},300);
        else 
          jQuery('#block-views-article-sponsoris-block-2').stop(true).animate({'right':'-2435px'},50);
      });
      jQuery('.block-views-article-sponsoris-block-2 .view-header p').bind('click',function(){
        jQuery('#block-views-article-sponsoris-block-2').remove();
        var d = new Date();
        d.setTime(d.getTime() + (24*60*60*1000));
        document.cookie = "lexptoasterhide=true; expires=" + d.toUTCString() + "; path=/";
      });
    }

    var parent = jQuery(".view-display-id-block_2 .row-1");
    var divs = parent.children();
    while (divs.length) {
        parent.append(divs.splice(Math.floor(Math.random() * divs.length), 1)[0]);
    }

  });
})(jQuery)
JS;
drupal_add_js($js, array('type' => 'inline', 'weight' => 69));
?>



<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
$(window).scroll(function(){
var distanceTop = $('.node-links').offset().top - $(window).height();

if  ($(window).scrollTop() > distanceTop)
$('#block-views-article-sponsoris-block-2').show().animate({'right':'-2170px'},300);
else 
$('#block-views-article-sponsoris-block-2').stop(true).animate({'right':'-2435px'},50);
});
$('.block-views-article-sponsoris-block-2 .view-header p').bind('click',function(){
$('#block-views-article-sponsoris-block-2').remove();
document.cookie="username=John Doe; expires=Thu, 18 Dec 2013 12:00:00 UTC";
});
});
</script>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
$(function () {
    var parent = $(".view-display-id-block_2 .row-1");
    var divs = parent.children();
    while (divs.length) {
        parent.append(divs.splice(Math.floor(Math.random() * divs.length), 1)[0]);
    }
});
</script>