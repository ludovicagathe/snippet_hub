function parse_data(data) {
	ElecMap.xml = data;
	ElecMap.num_cir = ElecMap.xml.getElementsByTagName('circonsinfo')[0].getElementsByTagName('circons').length;
	var i = 0, j = 0, n = 0, o = 0;
	var tmp_table = '', tmp_party = '';

	// Get Populs
	n = ElecMap.num_cir;

	for (i = 0; i < n; i++){
		var temp_circ = new Circons();
		temp_circ.cname = jQuery(ElecMap.xml.getElementsByTagName('circonsinfo')[0].getElementsByTagName('circons')[i].getElementsByTagName('cname')[0]).text();
		temp_circ.cnum = jQuery(ElecMap.xml.getElementsByTagName('circonsinfo')[0].getElementsByTagName('circons')[i].getElementsByTagName('cnum')[0]).text();
		temp_circ.popul10 = jQuery(ElecMap.xml.getElementsByTagName('circonsinfo')[0].getElementsByTagName('circons')[i].getElementsByTagName('elecnum2010')[0]).text();
		temp_circ.popul14 = jQuery(ElecMap.xml.getElementsByTagName('circonsinfo')[0].getElementsByTagName('circons')[i].getElementsByTagName('elecnum2014')[0]).text();

		// Get Parties data
		tmp_party = ElecMap.xml.getElementsByTagName('parties2010')[0].getElementsByTagName('parti');
		o = tmp_party.length;
		for (j = 0; j < o; j++) {
			if(jQuery(tmp_party[j].getElementsByTagName('circons')[0]).text() == (i + 1)){
				temp_circ.parties_2010 += jQuery(tmp_party[j].getElementsByTagName('name')[0]).text() + ':' + jQuery(tmp_party[j].getElementsByTagName('votes')[0]).text() + ';';
			}
		}
		tmp_party = ElecMap.xml.getElementsByTagName('parties2014')[0].getElementsByTagName('parti');
		o = tmp_party.length;
		for (j = 0; j < o; j++) {
			if(jQuery(tmp_party[j].getElementsByTagName('circons')[0]).text() == (i + 1)){
				temp_circ.parties_2014 += jQuery(tmp_party[j].getElementsByTagName('name')[0]).text() + ':' + jQuery(tmp_party[j].getElementsByTagName('votes')[0]).text() + ';';
			}
		}

		// Parse Candidate Data
		tmp_party = ElecMap.xml.getElementsByTagName('candidates2010')[0].getElementsByTagName('candid');
		o = tmp_party.length;
		for (j = 0; j < o; j++) {
			if(jQuery(tmp_party[j].getElementsByTagName('circons')[0]).text() == (i + 1)){
				temp_circ.candids_2010.push(j);
			}
		}

		tmp_party = ElecMap.xml.getElementsByTagName('candidates2014')[0].getElementsByTagName('candid');
		o = tmp_party.length;
		for (j = 0; j < o; j++) {
			if(jQuery(tmp_party[j].getElementsByTagName('circons')[0]).text() == (i + 1)){
				temp_circ.candids_2014.push(j);
			}
		}

		tmp_party = ElecMap.xml.getElementsByTagName('candidatesfull')[0].getElementsByTagName('person');
		o = tmp_party.length;
		ElecMap.candi_list = {};
		for (j = 0; j < o; j++) {
			ElecMap.candi_list['node' + jQuery(tmp_party[j].getElementsByTagName('cnid')[0]).text()] = j
		}

		ElecMap.circons.push(temp_circ);
	}
	load_success();
}

function get_xml(){
	if (window.XMLHttpRequest) {
	  xmlhttp = new XMLHttpRequest();
	} else {
	  xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET","xml/elecadmin.xml", false);
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var xmlDoc;
			if(ElecMap.ie_lt9) {
				xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
				xmlDoc.loadXML(xmlhttp.responseText);
			} else {
				xmlDoc = xmlhttp.responseXML;
			}
			parse_data(xmlDoc);
		}
		else if(xmlhttp.readyState == 4 && xmlhttp.status == 404) {
			jQuery("#msg-center .msg").text("Ce service n'est pas disponible pour le moment. Veuillez essayer ultérieurement ou vérifiez votre connexion.");
		}
	}
	xmlhttp.send(null);
}