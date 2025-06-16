<?php
include "../connect.php";

$userid = filterRequest("userid");
   getAllDataNotAll("users", "users_name , users_email , users_phone , users_image , users_role" , "users_id = $userid" );
?>
