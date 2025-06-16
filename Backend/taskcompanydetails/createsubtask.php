<?php

include "../connect.php";

// Retrieve JSON payload
$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data["taskid"]) || !isset($data["subtasks"])) {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
    exit();
}

$taskid = $data["taskid"];
$subtasks = $data["subtasks"];

if (empty($subtasks)) {
    echo json_encode(["status" => "error", "message" => "No subtasks provided"]);
    exit();
}

foreach ($subtasks as $subtask) {
    $title = $subtask["title"];
    $description = $subtask["description"];

    // Insert each subtask into the database
    $stmt = $con->prepare("INSERT INTO subtasks (task_id, title, description) VALUES (?, ?, ?)");
    $stmt->execute([$taskid, $title, $description]);
}

echo json_encode(["status" => "success"]);
?>
