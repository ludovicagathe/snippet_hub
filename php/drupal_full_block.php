<?php
$timeline_js =<<<MY_JS
(function(jQuery) {
window.onload = function() {
setTimeout(function () {
	if(typeof window.lexp_res_circ_update == 'undefined'){
		window.location.reload();
	}
}, 15000);
jQuery.getScript('http://apps.enplass.net/elec_map/elecdashboard/combined.js', init);
window.lexp_ready = 0;
function create_circons(number) {
	var my_table = document.createElement('table');
	my_table.setAttribute('id', 'circons-' + number);
	my_div.setAttribute('class', 'circonscrption');
}
function init() {
	jQuery('#lexp-load-ind').hide();
	var i,j, cir_num = window.lexp_res_circ_update.length;
	var tmp, my_table, tmp_tr, tmp_td1, tmp_td2, tmp_td3, can_num = window.lexp_res_cand_update.length;
	var my_div, my_h1;
	for(i = 0; i < cir_num; i++) {
		my_div = document.createElement('div');
		my_h1 = document.createElement('h1');
		jQuery(my_h1).text(window.lexp_res_circ_update[i].results_cname);
		jQuery(my_div).append(my_h1);
		//jQuery(my_div).append('<div>Nombre total de bulletins : ' + window.lexp_res_circ_update[i].results_bull + '</div><div>Nombre de bulletins dépouillés : ' + window.lexp_res_circ_update[i].results_dep + '</div>');
		my_div.setAttribute('class', 'circonscrption circ-' + (i + 1));
		my_table = document.createElement('table');
		my_table.setAttribute('id', 'circons-' + (i+1));
		pos = 0;
		party = '';
		for(j = 0; j < can_num; j++) {
			if (window.lexp_res_cand_update[j].results_circons == window.lexp_res_circ_update[i].results_cnum){
				pos++;
				tmp_tr = document.createElement('tr');
				if(window.lexp_res_cand_update[j].results_party == 'lepep') {
					tmp_tr.setAttribute('class', 'lepep');
					party = 'Alliance LEPEP';
				} else if(window.lexp_res_cand_update[j].results_party == 'ptr_mmm') {
					tmp_tr.setAttribute('class', 'ptrmmm');
					party = 'PTr-MMM';
				} else {
					party = window.lexp_res_cand_update[j].results_party.toUpperCase().replace('_', '-');
					//tmp_tr.style.backgroundColor = "#AAAAAA";
				}
				tmp_td1 = document.createElement('td');
				tmp_td2 = document.createElement('td');
				tmp_td2.setAttribute('class', 'col-2');
				tmp_td3 = document.createElement('td');
				tmp_td3.setAttribute('class', 'col-3');
				jQuery(tmp_td1).text(pos + '. ' + window.lexp_res_cand_update[j].results_name);
				jQuery(tmp_td2).text(window.lexp_res_cand_update[j].results_percent);
				jQuery(tmp_td3).text(party);
				jQuery(tmp_tr).append(tmp_td1).append(tmp_td2).append(tmp_td3);
				jQuery(my_table).append(tmp_tr);
				//{"results_cname":"No. 1 - GRNO\/Port-Louis ouest","results_elecs":"42 456","results_dep":"132","results_bull":"27 115","results_cnum":"1"}
				//{"results_name":"Armance, Patrice Kursley","results_percent":"0,00","results_circons":"1","results_party":"lepep"}
				
			}
			jQuery(my_div).append(my_table);
		}

		jQuery('#lexp-legis-results-main').append(my_div);
	}
}

}
})(jQuery);
MY_JS;
$timeline_css =<<<MY_CSS
#lexp-legis-results-main table tr {
font-size: 20px;
color: #333333;
height: 40px;
}
table {
width: 100%;
outline: solid 1px #999999;
border-collapse: collapse;
}
#lexp-legis-results-main table td {
padding: 5px;
border: solid 1px #999999;
}
#lexp-legis-results-main table h1 {
font-size: 40px;
line-height: 42px;
}
.lepep .col-3 {
	color: #FFFFFF;
background: #f17f28;
background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2YxN2YyOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUwJSIgc3RvcC1jb2xvcj0iI2YxN2YyOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUxJSIgc3RvcC1jb2xvcj0iIzE5M2E4ZSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMxOTNhOGUiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
background: -moz-linear-gradient(top,  #f17f28 0%, #f17f28 50%, #193a8e 51%, #193a8e 100%);
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f17f28), color-stop(50%,#f17f28), color-stop(51%,#193a8e), color-stop(100%,#193a8e));
background: -webkit-linear-gradient(top,  #f17f28 0%,#f17f28 50%,#193a8e 51%,#193a8e 100%);
background: -o-linear-gradient(top,  #f17f28 0%,#f17f28 50%,#193a8e 51%,#193a8e 100%);
background: -ms-linear-gradient(top,  #f17f28 0%,#f17f28 50%,#193a8e 51%,#193a8e 100%);
background: linear-gradient(to bottom,  #f17f28 0%,#f17f28 50%,#193a8e 51%,#193a8e 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f17f28', endColorstr='#193a8e',GradientType=0 );
}
.ptrmmm .col-3 {
	color: #FFFFFF;
	background: #e60000;
background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2U2MDAwMCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUwJSIgc3RvcC1jb2xvcj0iI2U2MDAwMCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUxJSIgc3RvcC1jb2xvcj0iIzc3MDk3YSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM3NzA5N2EiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
background: -moz-linear-gradient(top,  #e60000 0%, #e60000 50%, #77097a 51%, #77097a 100%);
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#e60000), color-stop(50%,#e60000), color-stop(51%,#77097a), color-stop(100%,#77097a));
background: -webkit-linear-gradient(top,  #e60000 0%,#e60000 50%,#77097a 51%,#77097a 100%);
background: -o-linear-gradient(top,  #e60000 0%,#e60000 50%,#77097a 51%,#77097a 100%);
background: -ms-linear-gradient(top,  #e60000 0%,#e60000 50%,#77097a 51%,#77097a 100%);
background: linear-gradient(to bottom,  #e60000 0%,#e60000 50%,#77097a 51%,#77097a 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#e60000', endColorstr='#77097a',GradientType=0 );
}
.col-3, .col-2 {
width: 210px !important;
text-align: center;
}
#lexp-legis-results-main div {
	font-size: 24px;
	color: #000000;
}
MY_CSS;
drupal_add_js($timeline_js, array('type' => 'inline', 'weight' => 100));
drupal_add_css($timeline_css, array('type' => 'inline', 'weight' => 100));
?>
<div id="lexp-load-ind" style="text-align: center;position: relative;width: 100%;height: 20px;padding: 10px 460px;"><img src="http://apps.enplass.net/elec_map/elecdashboard/loading.gif" height="24px" width="24px" /></div>
<div id="lexp-legis-results-main">
</div>