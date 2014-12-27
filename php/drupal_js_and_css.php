<?php
$timeline_js =<<<MY_JS
(function(jQuery) {
function lexp_timeline_build() {
  var n = window.lexp_news_full.length;
  var i = 0;
  var time_table = jQuery('<table/>', {
    id: 'lexp-timeline-table',
  });
  for (i = 0; i < n; i++) {
    time_table.append('<tr><td class="col col-1">' + window.lexp_news_full[i].action_time + '</td><td class="col col-2">' + window.lexp_news_full[i].action_title + '</td></tr>');
  }
  jQuery('#lexp-timeline-main').append(time_table);
}
jQuery(document).ready(function () {
jQuery.getScript('http://apps.enplass.net/elec_map/elecdashboard/lexpnewsfeedfull.js', lexp_timeline_build);
});
})(jQuery);
MY_JS;
$timeline_css =<<<MY_CSS
table#lexp-timeline-table {
color: #333333;
font-size: 20px;
border-collapse: separate;
border-spacing: 0 20px;
}
#lexp-timeline-table .col.col-1 {
background-color: #2e358d;
padding: 4px 8px;
vertical-align: middle;
height: 72px;
color: #FFFFFF;
font-weight: bold;
}
#lexp-timeline-table .col.col-2 {
border-bottom: groove 1px #CCCCCC;
border-top: groove 1px #CCCCCC;
border-right: groove 1px #CCCCCC;
padding-left: 10px;
}
MY_CSS;
drupal_add_js($timeline_js, array('type' => 'inline', 'weight' => 100));
drupal_add_css($timeline_css, array('type' => 'inline', 'weight' => 100));
?>
<div id="lexp-timeline-main"></div>