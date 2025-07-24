<?php
include "../connect.php";

$projectId = filterRequest("project_id");
$status = filterRequest("status"); // Expected values: 'Active', 'Completed', 'Archived'

if (empty($projectId) || empty($status)) {
    echo json_encode(["status" => "failure", "message" => "Project ID and status are required."]);
    exit;
}

$data = array(
    "status" => $status
);

updateData("projects", $data, "project_id = $projectId");

?>