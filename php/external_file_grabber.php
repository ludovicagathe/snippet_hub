<?php
// grabber.php

function origin(){
    if(isset($_SERVER['HTTPS'])) {
        $protocol = ($_SERVER['HTTPS'] && $_SERVER['HTTPS'] != "off") ? "https" : "http";
    }
    else {
        $protocol = 'http';
    }
    $host = '';
    if($_SERVER['HTTP_HOST'] == 'elec_map') {
      $host = $_SERVER['HTTP_HOST'];
    } else {
      $host = $_SERVER['HTTP_HOST'] . '/elec_map';
    }
    return $protocol . "://" . $host;
}
function update_feeds_js($csv_file, $var) {
  $js_str = 'window.' . $var  . ' = [];';

  $url = origin() . $csv_file;
  $file = fopen($url,"r");

  while(!feof($file)){
    $tmp_titles = fgetcsv($file);
    if(empty($tmp_titles)) {
      break;
    }
    $tmp_json = array('action_time' => $tmp_titles[0], 'action_title' => $tmp_titles[1]);
    $tmp_json = json_encode($tmp_json);
    $tmp_str = "window." . $var . ".push($tmp_json);";
    $js_str .= $tmp_str;
  }
  //$js_str .= "if (window." . $var . "[window." . $var . ".length - 1].action_time == null) { window." . $var . ".pop(); }"

  fclose($file);
  return $js_str;
}

$current_time = time();
/*if(!file_exists('time.conf')) {
  file_put_contents('time_short.conf', $current_time);
} else {
  $ref_time = (int)trim(file_get_contents('time.conf'));
}*/
if(!file_exists('time-full.conf')) {
  file_put_contents('time-full.conf', $current_time);
} else {
  $ref_time_full = (int)trim(file_get_contents('time-full.conf'));
}
/*if($current_time > ($ref_time + 120)) {
  file_put_contents('lexpnewsfeedshort.js', update_feeds_js("/elecadmin/article-feed.csv", 'lexp_news_short'));
  file_put_contents('time.conf', $current_time);
}*/
if ($current_time > ($ref_time_full + 180)){
  file_put_contents('lexpnewsfeedfull.js', update_feeds_js("/elecadmin/article-feed-full.csv", 'lexp_news_full'));
  file_put_contents('time-full.conf', $current_time);
}

?>