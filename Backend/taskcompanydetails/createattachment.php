<?php
include "../connect.php";

    $taskid = filterRequest("taskid");
    $filename = filterRequest("filename");
    $url = filterRequest('url');
   
     
$data = array("task_id"=>$taskid,"filename"=>$filename,"file_url"=>$url);

insertData("attachments" , $data)


?>
