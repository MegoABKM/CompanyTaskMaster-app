<?php


include "../connect.php";


$idTask = filterRequest("task_id");


deleteData("tasks", "id = $idTask");




