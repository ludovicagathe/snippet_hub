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

window._ttf = window._ttf || [];
_ttf.push({
       pid          : 33271
       ,lang        : "en"
       ,slot        : '.field-items .field-item > p'
       ,format      : "inread"
       ,mobile      : false
       ,mutable     : true
       ,css         : "padding: 0px 5px 5px 0px;"
       ,BTF         : false
});

(function (d) {
        var js, s = d.getElementsByTagName('script')[0];
        js = d.createElement('script');
        js.async = true;
        js.src = '//cdn.teads.tv/media/format.js';
        s.parentNode.insertBefore(js, s);
})(window.document);

  }
  
}
});
})(jQuery)
JS;

//drupal_add_js($js, array('type' => 'inline', 'weight' => 50));
?>