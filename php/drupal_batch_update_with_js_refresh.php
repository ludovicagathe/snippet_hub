<?php
echo "<h2>Code Block</h2>";
$limit = 500;
$params = drupal_get_query_parameters();
if(!empty($params) && isset($params['start']) && $params['start'] > 0 && $params['start'] < 260050) {
//$sql = 'SELECT n.nid, n.title, n.created FROM {node} AS n WHERE n.type = :type AND n.nid > 68450 AND n.nid <= 68500';
$sql = 'SELECT n.nid, n.title, n.created FROM {node} AS n WHERE n.type = :type AND n.nid > ' . $params['start'] . ' AND n.nid <= ' . ((int)$params['start'] + $limit);

$results = db_query($sql, array(
  ':type' => 'epaper_lexpress',
));

foreach ($results as $result){
  echo '<p><a href="/node/' . $result->nid . '">' . $result->title . '</a></p>';
  $node = node_load( $result->nid);

  echo '<p>Publication Date : ' . $node->field_publication_date[LANGUAGE_NONE][0]['value'] . '</p>';
  echo '<p>Creation Date : ' . date("Y-m-d 00:00:01", (int)$node->created) . '</p>';
  $node->field_publication_date[LANGUAGE_NONE][0]['value']  = date("Y-m-d 00:00:01", (int)$node->created);

  node_save($node);
}
$js = 'window.setTimeout(function() { window.location.assign("http://lexpress/users/ludovicagathe?start=' . ((int)$params[start] + $limit) . '"); }, 1000);';
drupal_add_js($js, array('type' => 'inline', 'weight' => 100));
}
?>