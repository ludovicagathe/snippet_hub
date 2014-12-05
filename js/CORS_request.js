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