(function(jQuery) {
/*****  Overlay Dans Sa  *****/

function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + "; " + expires + "; path=/";
}

var news_cookie = 'lexpnewsletter';
var news_cookie_val = '';

var name = news_cookie + "=";
var ca = document.cookie.split(';');
for(var i = 0; i < ca.length; i++) {
  var c = ca[i];
  while (c.charAt(0) == ' ') { c = c.substring(1); }
  if (c.indexOf(name) != -1) { news_cookie_val = c.substring(name.length,c.length); }
}

function my_load_fn(){
    if(news_cookie_val == '') {
      if(typeof window.geoip_ajax != 'undefined') {
        if(window.geoip_ajax != 'MU' || window.geoip_ajax != 'NOT_FOUND' || window.geoip_ajax != 'NOT_AVAILABLE') {
          jQuery('#lexp-ovlay-body').css({'background-image' : 'url(http://www.lexpress.mu/sites/lexpress/files/site_page/lexp-persp.jpg)'});
        } else {
          jQuery('#lexp-ovlay-body').css({'background-image' : 'url(http://www.lexpress.mu/sites/lexpress/files/site_page/mauri-news.jpg)'});
        }
      } else {
        jQuery('#lexp-ovlay-body').css({'background-image' : 'url(http://www.lexpress.mu/sites/lexpress/files/site_page/mauri-news.jpg)'});
      }
      jQuery('#lexp-ovlay-main').fadeIn(600);
    }
}
if(window.addEventListener) {
  window.addEventListener('load',my_load_fn,false); //W3C
} else {
  window.attachEvent('onload',my_load_fn); //IE
}

/*
function check_by_ajax (str) {
  var encode_array = ['#dumhdkf.shjfgj.fgjn#dum', '#dumjkdhgs.fkdhjgh.fdsg#dum', '#dum34jkjh9fg3g54g4jklnncv#dum'];
  var t = new Date();
  t = t.getTime();
  var aj_url = 'http://52.16.203.178/services/ajax/mailertools/add';
  jQuery.ajax({
    type : 'POST',
    url : aj_url,
    dataType : 'json',
    data : {"js" : 1, "t" : t, 'receiver' : 'ludovic@test.com'},
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

function createCORSRequest(method, url) {
  var xhr = new XMLHttpRequest();
  if ("withCredentials" in xhr) {
    xhr.open(method, url, true);
  } else if (typeof XDomainRequest != "undefined") {
    xhr = new XDomainRequest();
    xhr.open(method, url);
  } else {
    xhr = null;
  }
  return xhr;
}

var lexp_stats = createCORSRequest('GET', "http://apps.enplass.net/lexpstats/in.php?t=" + Math.random());
if (!lexp_stats) {
  throw new Error('CORS not supported');
}
lexp_stats.onload = function() {
 window.lexp_stats_resp = lexp_stats.responseText;
 var countData = document.getElementById('lexp-counter-main');
 countData.innerHTML = '<a href="' + window.lexp_dashboard_nid + '" target="_blank"><img height="20" width="20" src="http://www.lexpress.mu/sites/lexpress/files/site_page/download.png" />' + window.lexp_stats_resp + " pages consultées aujourd'hui</a>";
 countData.style.display = 'block';
};

lexp_stats.onerror = function() {
  window.lexp_stats_resp = 0;
};

lexp_stats.send();
*/
})(jQuery)