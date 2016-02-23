<?php
$node = menu_get_object();

if(!empty($node->field_live_article)) {
  if((int)$node->field_live_article[LANGUAGE_NONE][0]['value'] == 1) {
    $nid = $node->nid;
    $fetcher_url = "/ajax/ajax_my_content/" . $nid;

$js =<<<JS
function request_new_body() {
  jQuery('.lexp-live-auto-refresh img').addClass('lexp-spinner');
  var t = new Date();
  t = t.getTime();
  //var aj_url = Drupal.settings.basePath + "$fetcher_url";
  var aj_url = "$fetcher_url";
  jQuery.ajax({
    type : 'POST',
    url : aj_url,
    dataType : 'json',
    data : {"js" : 1, "t" : t},
    complete : function (xhr, status) {
      window.lexp.ajax_body = 'NOT_FOUND';
      if(status === 'success' || status === 'notmodified') {
        var tmp_ajax = jQuery.parseJSON(xhr.responseText);
        jQuery(window.lexp.holder).html(tmp_ajax.fieldRequest);
        if(tmp_ajax.fieldRequest != '') {
          window.lexp.ajax_body = tmp_ajax.fieldRequest;
          if(window.lexp.first_query) {
            jQuery('article .field-name-body .field-item').eq(0).html(window.lexp.ajax_body);
          }
          if(jQuery('article .field-name-body .field-item').eq(0).html() != jQuery(window.lexp.holder).html() && !window.lexp.first_query) {
            jQuery('article .field-name-body .field-item').eq(0).fadeTo(800, 0.1, function() {
              jQuery('article .field-name-body .field-item').eq(0).html(window.lexp.ajax_body);
              jQuery('article .field-name-body .field-item').eq(0).fadeTo(800, 1);
              var scroll_to_pos = Math.floor(jQuery('article .field-name-body .field-item').eq(0).offset().top - 120);
              jQuery("html, body").animate({scrollTop : scroll_to_pos}, 500);
            })
          }
        }
        window.lexp.first_query = false;
        setTimeout(function() { jQuery('.lexp-live-auto-refresh img').removeClass('lexp-spinner'); }, 2000);
      }
    },
  });
}

jQuery(document).ready(function() {
    jQuery('h1#page-title').before('<div class="lexp-live-timer"><img width="40" height="40" src="http://www.lexpress.mu/sites/lexpress/files/site_page/live_clock.png" />LIVE</div>');
    jQuery('h1#page-title').addClass('lexp-live-timer-title');
    jQuery('.view-openpublish-related-content .views-row-first').append('<div class="lexp-live-auto-refresh"><img width="40" height="40" src="http://www.lexpress.mu/sites/lexpress/files/site_page/refresh-icon.png" />Cette page est mise à jour automatiquement, pas besoin de la recharger</div>');
    jQuery('.lexp-live-auto-refresh').parent().css('position', 'relative');
    jQuery('body').append('<div id="lexp-live-notif" style="position:fixed; background-color:#FF7B72; background-color: rgba(255,123,118,0.7); color:#FFFFFF; padding: 10px 60px 10px 20px; cursor:pointer; bottom:4px; left:2%; font-size:12px; border: solid 1px #FF7B76;   border-radius:4px; line-height:24px; background-image:url(http://www.lexpress.mu/sites/lexpress/files/site_page/top_white.png); background-repeat:no-repeat; background-position:146px 12px;">Voir les mises à jour</div>');
});
      
function get_body_init() {
  window.lexp = { ajax_body : "", refresh_after : 120000, holder : document.createElement('div'), first_query : true };
  setTimeout(request_new_body, 10000); 
  setInterval(request_new_body, window.lexp.refresh_after);
}


if(window.addEventListener){
    window.addEventListener('load', get_body_init, false);
} else {
    window.attachEvent('onload', get_body_init); //IE
}

JS;
  drupal_add_js($js, array('type' => 'inline', 'weight' => 70));

  }
}
?>