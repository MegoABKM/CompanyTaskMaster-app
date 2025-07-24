<?php
include "../connect.php";

$sprintId = filterRequest("sprint_id");

if (empty($sprintId)) {
    echo json_encode(["status" => "failure", "message" => "Sprint ID is required."]);
    exit;
}

// When you delete a sprint, the 'ON DELETE SET NULL' constraint on the tasks table
// will automatically set the `sprint_id` of all tasks in this sprint to NULL.
// This effectively moves them back to the project's backlog.
deleteData("sprints", "sprint_id = $sprintId");

?>