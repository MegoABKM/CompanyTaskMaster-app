<?php

include "../connect.php";



$attachmentid = filterRequest("id");
$attachmentname = filterRequest("filename");



$data = array("filename" => $attachmentname);
updateData("attachments", $data , "id = $attachmentid" );