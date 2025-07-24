<?php
include "../connect.php";

$projectId = filterRequest("project_id");

if (empty($projectId)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

// Thanks to 'ON DELETE CASCADE' in the database, 
// deleting a project will also delete its associated sprints, tasks, etc.
deleteData("projects", "project_id = $projectId");
?>