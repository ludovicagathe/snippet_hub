function detect_non_html5() {
	var user_agent = window.navigator.userAgent.toLowerCase();
	if(user_agent.indexOf('msie 5') != -1 || user_agent.indexOf('msie 6') != -1 || user_agent.indexOf('msie 7') != -1 || user_agent.indexOf('msie 8') != -1 || user_agent.indexOf('series40') != -1  || user_agent.indexOf('symbianos') != -1  || user_agent.indexOf('nokian73') != -1  || user_agent.indexOf('series60') != -1) {
		return false;
	} else {
		return true;
	}
}