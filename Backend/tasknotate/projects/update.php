<?php
include "../connect.php";

$projectId = filterRequest("project_id");
$projectName = filterRequest("project_name");
$projectDescription = filterRequest("project_description");
$deadline = filterRequest("deadline");
$priority = filterRequest("priority");

if (empty($projectId)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

// NOTE: We DO NOT update the methodology_type here, as requested.
$data = array(
    "project_name" => $projectName,
    "project_description" => $projectDescription,
    "deadline" => !empty($deadline) ? $deadline : null,
    "priority" => $priority
);

updateData("projects", $data, "project_id = $projectId");

?>