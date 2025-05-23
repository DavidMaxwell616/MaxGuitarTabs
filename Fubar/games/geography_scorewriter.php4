<?php 
$content = "Name=".$HTTP_POST_VARS['hs_name']."&Score=".$HTTP_POST_VARS['hs_score']; 
$fp = fopen("geography_score.txt","wb"); 
fwrite($fp,$content); 
fclose($fp); 
?> 