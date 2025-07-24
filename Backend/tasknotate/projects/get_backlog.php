<?php
include "../connect.php";

$projectId = filterRequest("project_id");

if (empty($projectId)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

// Fetch tasks that are in the backlog (sprint_id IS NULL)
$stmt = $con->prepare("SELECT * FROM tasks WHERE project_id = ? AND sprint_id IS NULL ORDER BY priority DESC, id DESC");
$stmt->execute([$projectId]);
$backlogTasks = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(["status" => "success", "data" => $backlogTasks]);
?>