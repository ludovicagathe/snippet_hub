if(navigator.userAgent.toLowerCase().indexOf('msie 5') != -1 || navigator.userAgent.toLowerCase().indexOf('msie 6') != -1 || navigator.userAgent.toLowerCase().indexOf('msie 7') != -1 || navigator.userAgent.toLowerCase().indexOf('msie 8') != -1) {
	if(!ElecMap.ie_lt9) {
		ElecMap.ie_lt9 = true;
		// jQuery('#wait-spinner img').remove();
	}
	// return;
}