<?php


include "../connect.php";


$taskid = filterRequest("taskid");


getAllDataNotAll("attachments", "id , filename ,file_url AS url , uploaded_at", "task_id = $taskid ORDER BY id DESC LIMIT 1");
