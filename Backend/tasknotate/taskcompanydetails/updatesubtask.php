<?php
include "../connect.php";

// Get the raw POST data
$json = file_get_contents('php://input');
$data = json_decode($json, true);

$taskid = $data['taskid'];
$subtasks = $data['subtasks'];

if (empty($taskid)) {
    echo json_encode(["status" => "failure", "message" => "Task ID is required."]);
    exit;
}

try {
    // Begin a transaction
    $con->beginTransaction();

    // 1. Get all current subtask IDs for the given task from the database
    $stmt = $con->prepare("SELECT id FROM subtasks WHERE task_id = ?");
    $stmt->execute([$taskid]);
    $existingDbIds = $stmt->fetchAll(PDO::FETCH_COLUMN);

    $incomingIds = [];

    // 2. Loop through incoming subtasks: update existing ones, insert new ones
    foreach ($subtasks as $subtask) {
        $id = $subtask['id'];
        $title = $subtask['title'];
        $description = $subtask['description'];
        
        // Keep track of incoming IDs
        if (is_numeric($id) && $id > 0) {
           $incomingIds[] = $id;
        }

        // Check if the subtask exists by checking if the id is in our DB list
        if (is_numeric($id) && in_array($id, $existingDbIds)) {
            // It exists, so UPDATE it
            $updateStmt = $con->prepare("UPDATE subtasks SET title = ?, description = ? WHERE id = ?");
            $updateStmt->execute([$title, $description, $id]);
        } else {
            // It's a new subtask (ID is not in DB or is a placeholder), so INSERT it
            $insertStmt = $con->prepare("INSERT INTO subtasks (task_id, title, description) VALUES (?, ?, ?)");
            $insertStmt->execute([$taskid, $title, $description]);
        }
    }

    // 3. Determine which subtasks to DELETE
    // These are IDs that were in the database but not in the incoming data
    $idsToDelete = array_diff($existingDbIds, $incomingIds);
    if (!empty($idsToDelete)) {
        // Use IN clause to delete multiple IDs at once
        $placeholders = rtrim(str_repeat('?,', count($idsToDelete)), ',');
        $deleteStmt = $con->prepare("DELETE FROM subtasks WHERE id IN ($placeholders)");
        $deleteStmt->execute(array_values($idsToDelete));
    }

    // If all operations were successful, commit the transaction
    $con->commit();

    echo json_encode(["status" => "success", "message" => "Subtasks updated successfully"]);

} catch (Exception $e) {
    // If any error occurs, roll back the transaction
    $con->rollBack();
    echo json_encode(["status" => "failure", "message" => "An error occurred: " . $e->getMessage()]);
}

?>