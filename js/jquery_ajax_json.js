function geoip_ajax_request () {
  var t = new Date();
  t = t.getTime();
  var aj_url = Drupal.settings.basePath + 'ajax/geoip_ajax';
  jQuery.ajax({
    type : 'POST',
    url : aj_url,
    dataType : 'json',
    data : {"js" : 1, "t" : t},
    complete : function (xhr, status) {
      window.geoip_ajax = 'NOT_FOUND';
      if(status === 'success' || status === 'notmodified') {
        var tmp_ajax = jQuery.parseJSON(xhr.responseText);
        if(tmp_ajax.geoip_reply != '') {
          window.geoip_ajax = tmp_ajax.geoip_reply;
        }
        setCookie('geoipajaxlocation', window.geoip_ajax, 7, '/');
      }
    },
  });
}