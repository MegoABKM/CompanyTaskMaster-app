<?php
include "../connect.php";

$projectId = filterRequest("project_id");
$sprintName = filterRequest("sprint_name");
$sprintGoal = filterRequest("sprint_goal");
$startDate = filterRequest("start_date");
$endDate = filterRequest("end_date");

$data = array(
    "project_id" => $projectId,
    "sprint_name" => $sprintName,
    "sprint_goal" => $sprintGoal,
    "start_date" => $startDate,
    "end_date" => $endDate
);

// Use the new function that returns the created sprint's ID
insertDataAndReturnId("sprints", $data);
?>