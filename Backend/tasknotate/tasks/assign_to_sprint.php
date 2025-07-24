<?php
include "../../connect.php";

$taskId = filterRequest("task_id");
$sprintId = filterRequest("sprint_id");

$data = array("sprint_id" => $sprintId);

updateData("tasks", $data, "id = $taskId");
?>