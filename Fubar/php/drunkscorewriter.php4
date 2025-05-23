<?php 
$content = "Score=".$HTTP_POST_VARS['hs_score']; 
$fp = fopen("drunkscore.txt","wb"); 
fwrite($fp,$content); 
fclose($fp); 
?>

