<?php
include "../connect.php";

// Get data from the request
$sprintId = filterRequest("sprint_id");
$sprintName = filterRequest("sprint_name");
$sprintGoal = filterRequest("sprint_goal");
$startDate = filterRequest("start_date");
$endDate = filterRequest("end_date");

// Validate required fields
if (empty($sprintId) || empty($sprintName) || empty($startDate) || empty($endDate)) {
    echo json_encode(["status" => "failure", "message" => "Required fields are missing."]);
    exit;
}

// Prepare data for the update
$data = array(
    "sprint_name" => $sprintName,
    "sprint_goal" => $sprintGoal,
    "start_date" => $startDate,
    "end_date" => $endDate
);

// Call the update function
updateData("sprints", $data, "sprint_id = $sprintId");

?>