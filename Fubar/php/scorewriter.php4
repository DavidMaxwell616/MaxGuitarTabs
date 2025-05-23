<?php 
$content = "Name=".$HTTP_POST_VARS['hs_name']."&Score=".$HTTP_POST_VARS['hs_score']; 
$fp = fopen("score.txt","wb"); 
fwrite($fp,$content); 
fclose($fp); 
?>

