<?php
$js =<<<JS
(function(jQuery) {
jQuery(document).ready(function() {
var name = "geoipajaxlocation=";
var loc_cookie = '';
var ca = document.cookie.split(';');
for(var i=0; i<ca.length; i++) {
  var c = ca[i];
  while (c.charAt(0) == ' ') { 
    c = c.substring(1);
  }
  if (c.indexOf(name) != -1) {
    loc_cookie = c.substring(name.length,c.length);
  }
}
loc_cookie = 'test';
if(loc_cookie == 'MU') {
  // Rezo Code;
} else {
  var all_parags = jQuery('article .field-name-body .field-items .field-item > p'); 
  var i = 0, count = 0, n = all_parags.length;
  if(n > 3) {
    var adaptv_div = all_parags.eq(2).after('<div class="adaptv-outstream" data-adtag="http://ads.adaptv.advertising.com/a/h/ECpeHlKF2X+o0AUqKs_9hGCpiThvTFpghfQeuvjsvYJM8HrLdfR0LaDrdJaixbMD?cb=' + Math.ceil(Math.random() * 50000) + '&pet=preroll&pageUrl=' + encodeURIComponent(window.location.href) + '&eov=eov" data-height="300" data-width="400" data-audio="hover" data-text="" style="position: relative;"></div>');
  }
}
});
})(jQuery)
JS;

drupal_add_js($js, array('type' => 'inline', 'weight' => 50));
drupal_add_js("http://redir.adap.tv/redir/javascript/outstream.js", array('type' => 'external', 'weight' => 51));
?>