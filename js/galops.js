(function(jQuery){
var data = jQuery('textarea#edit-body-und-0-value').val().trim();
data = data.split("\n");
var i, j, tmp, arr = [];
for (i = 0; i < data.length; i++){
	tmp = data[i].split(',');
	if (tmp[0].indexOf('.') != -1) {
		arr.push(tmp);
	}
}
var fields = ["field-date-txt","field-lap-1","field-lap-2","field-lap-3","field-800m","field-600m","field-400m","field-200m","field-accomp"];
for (i = 0; i < arr.length; i++) {
	for (j = 0; j < fields.length; j++) {
		jQuery('table#field-galops-values #edit-field-galops-und-' + i + '-' + fields[j] + '-und-0-value').val(arr[i][j]);
	}
}
})(jQuery);