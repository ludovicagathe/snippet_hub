// Get article node
var i, c = 0;
var ins_aft;
var article_divs = document.getElementsByTagName('article')[0].querySelectorAll('div.field-name-body .field-item.even');
var l = article_divs[0].childNodes.length;
for(i = 0; i < l; i++) {
  if(article_divs[0].childNodes[i].nodeName.toLowerCase() == 'p' || article_divs[0].childNodes[i].nodeName.toLowerCase() == 'div') {
    ins_aft = article_divs[0].childNodes[i];
    break;
  }
}

adaptv = document.createElement('div');
adaptv.setAttribute('id', 'test');

ins_aft.parentNode.insertBefore(adaptv, ins_aft.nextSibling);