<?php


include "../connect.php";


$idfile = filterRequest("id");


deleteData("attachments", "id = $idfile");




