<?php
include "../connect.php";

$projectId = filterRequest("project_id");

if (empty($projectId)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

// 1. Fetch Project Details
$stmt = $con->prepare("SELECT * FROM projects WHERE project_id = ?");
$stmt->execute([$projectId]);
$projectDetails = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$projectDetails) {
    echo json_encode(["status" => "failure", "message" => "Project not found."]);
    exit;
}

// 2. Fetch all Sprints for this project
$stmt = $con->prepare("SELECT * FROM sprints WHERE project_id = ? ORDER BY start_date DESC");
$stmt->execute([$projectId]);
$sprints = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 3. Fetch All Tasks for the project
$stmt = $con->prepare("SELECT * FROM tasks WHERE project_id = ? ORDER BY id DESC");
$stmt->execute([$projectId]);
$allTasks = $stmt->fetchAll(PDO::FETCH_ASSOC);

// --- THE FIX IS HERE ---
// 4. Filter the $allTasks array to create the $backlogTasks array
$backlogTasks = [];
foreach ($allTasks as $task) {
    // A task is in the backlog if its 'sprint_id' is null OR an empty string.
    // This is a more robust check.
    if (!isset($task['sprint_id']) || empty($task['sprint_id'])) {
        $backlogTasks[] = $task;
    }
}
// --- END OF FIX ---

// 5. Fetch assigned project members
$stmtMembers = $con->prepare("
    SELECT u.users_id as employee_id, u.users_name as employee_name, u.users_email as employee_email, u.users_phone as employee_phone, u.users_image as employee_image 
    FROM project_employees pe 
    JOIN users u ON pe.user_id = u.users_id 
    WHERE pe.project_id = ?
");
$stmtMembers->execute([$projectId]);
$projectMembers = $stmtMembers->fetchAll(PDO::FETCH_ASSOC);

// Add the members list to the project details
$projectDetails['members'] = $projectMembers;

// 6. Assemble the response
$response = [
    "status" => "success",
    "data" => [
        "project" => $projectDetails,
        "sprints" => $sprints,
        "tasks" => $allTasks,
        "backlog" => $backlogTasks, // Now this will be correctly populated
        "members" => $projectMembers
    ]
];

echo json_encode($response);
?>