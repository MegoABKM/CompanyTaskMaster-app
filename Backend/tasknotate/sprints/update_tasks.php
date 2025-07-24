<?php
include "../connect.php";

$sprintId = filterRequest("sprint_id");
$taskIds = filterRequest("task_ids"); // Expecting a comma-separated string of task IDs

if (empty($sprintId)) {
    echo json_encode(["status" => "failure", "message" => "Sprint ID is required."]);
    exit;
}

try {
    // Start a transaction for atomicity
    $con->beginTransaction();

    // 1. First, remove all tasks currently associated with this sprint.
    // This moves them back to the backlog.
    $stmt = $con->prepare("UPDATE tasks SET sprint_id = NULL WHERE sprint_id = ?");
    $stmt->execute([$sprintId]);
    
    // 2. Now, assign the new set of tasks to this sprint.
    if (!empty($taskIds)) {
        // We use FIND_IN_SET which is safer than IN() for prepared statements with comma-separated strings
        $updateStmt = $con->prepare("UPDATE tasks SET sprint_id = ? WHERE FIND_IN_SET(id, ?)");
        $updateStmt->execute([$sprintId, $taskIds]);
    }
    
    // Commit the transaction
    $con->commit();

    echo json_encode(["status" => "success", "message" => "Sprint tasks updated successfully."]);

} catch (Exception $e) {
    // If anything fails, roll back the changes
    $con->rollBack();
    echo json_encode(["status" => "failure", "message" => "An error occurred: " . $e->getMessage()]);
}
?>