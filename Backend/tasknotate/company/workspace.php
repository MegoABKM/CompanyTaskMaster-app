<?php
include "../connect.php";

$companyid = filterRequest("companyid");

// Fetch progressbar data (only taskscompleted)
$stmt = $con->prepare("SELECT progressbar_taskscompleted FROM progressbar WHERE progressbar_companyid = ?");
$stmt->execute([$companyid]);
$taskscompleted = $stmt->fetch(PDO::FETCH_ASSOC);

// Fetch tasks data
$stmt = $con->prepare("SELECT * FROM tasks WHERE company_id = ?");
$stmt->execute([$companyid]);
$tasks = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Return the combined data
echo json_encode([
    "status" => "success",
    "taskscompleted" => $taskscompleted ? $taskscompleted['progressbar_taskscompleted'] : 0, // Default to 0 if no progressbar data exists
    "tasks" => $tasks,
]);