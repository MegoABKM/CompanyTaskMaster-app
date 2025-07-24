<?php
include "../connect.php";

$projectId = filterRequest("project_id");
$employeeIds = filterRequest("employee_ids"); // Expecting a comma-separated string of IDs

if (empty($projectId)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

try {
    // Start a transaction
    $con->beginTransaction();

    // 1. Delete all existing assignments for this project
    $stmt = $con->prepare("DELETE FROM project_employees WHERE project_id = ?");
    $stmt->execute([$projectId]);

    // 2. Insert the new assignments if any are provided
    if (!empty($employeeIds)) {
        $employeeIdArray = explode(',', $employeeIds);
        
        $insertStmt = $con->prepare("INSERT INTO project_employees (project_id, user_id) VALUES (?, ?)");
        
        foreach ($employeeIdArray as $userId) {
            if (is_numeric(trim($userId))) {
                $insertStmt->execute([$projectId, trim($userId)]);
            }
        }
    }
    
    // Commit the transaction
    $con->commit();

    echo json_encode(["status" => "success", "message" => "Project members updated successfully."]);

} catch (Exception $e) {
    // Rollback the transaction on error
    $con->rollBack();
    echo json_encode(["status" => "failure", "message" => "An error occurred: " . $e->getMessage()]);
}
?>