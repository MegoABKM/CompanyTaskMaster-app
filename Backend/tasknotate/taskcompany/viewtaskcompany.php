<?php

include "../connect.php";

$taskid = filterRequest("taskid");

if (!$taskid) {
    echo json_encode(["status" => "error", "message" => "Task ID is required"]);
    exit();
}

$response = [];

try {
    // Fetch subtasks
    $stmtSubtasks = $con->prepare("SELECT id, title, description FROM subtasks WHERE task_id = ?");
    $stmtSubtasks->execute([$taskid]);
    $subtasks = $stmtSubtasks->fetchAll(PDO::FETCH_ASSOC);

    // Fetch assigned users
    $stmtUsers = $con->prepare("
        SELECT 
            users.users_id AS user_id, 
            users_name, 
            users_phone, 
            users_email 
        FROM 
            users 
        JOIN 
            assigned_users 
        ON 
            users.users_id = assigned_users.user_id 
        WHERE 
            task_id = ?
    ");
    $stmtUsers->execute([$taskid]);
    $assignedUsers = $stmtUsers->fetchAll(PDO::FETCH_ASSOC);

    // Fetch attachments
    $stmtAttachments = $con->prepare("
        SELECT 
            id, 
            filename, 
            file_url AS url, 
            uploaded_at 
        FROM 
            attachments 
        WHERE 
            task_id = ?
    ");
    $stmtAttachments->execute([$taskid]);
    $attachments = $stmtAttachments->fetchAll(PDO::FETCH_ASSOC);

    // Build response
    $response["status"] = "success";
    $response["assignedusers"] = $assignedUsers;
    $response["subtasks"] = $subtasks;
    $response["attachments"] = $attachments;

    echo json_encode($response);
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
