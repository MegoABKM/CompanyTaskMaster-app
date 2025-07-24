<?php
include "../connect.php";

// Get data from the request
$sprintId = filterRequest("sprint_id");
$status = filterRequest("status");

// Validate required fields
if (empty($sprintId) || empty($status)) {
    echo json_encode(["status" => "failure", "message" => "Sprint ID and status are required."]);
    exit;
}

// Prepare data for the update
$data = array(
    "status" => $status
);

// Call the update function
updateData("sprints", $data, "sprint_id = $sprintId");

?>