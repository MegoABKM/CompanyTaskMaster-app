<?php
include "../connect.php";

// Retrieve and validate input data
$companyid = filterRequest("companyid");
$completedTasks = filterRequest("completed_tasks");

// Check if the progressbar entry exists for the company
$stmt = $con->prepare("SELECT * FROM progressbar WHERE progressbar_companyid = ?");
$stmt->execute([$companyid]);
$existingProgress = $stmt->fetch(PDO::FETCH_ASSOC);

if ($existingProgress) {
    // Update the existing progressbar entry
    $data = [
        "progressbar_taskscompleted" => $completedTasks,
    ];
    $where = "progressbar_companyid = $companyid";
    $result = updateData("progressbar", $data, $where, false);
} else {
    // Insert a new progressbar entry
    $data = [
        "progressbar_companyid" => $companyid,
        "progressbar_taskscompleted" => $completedTasks,
    ];
    $result = insertData("progressbar", $data, false);
}

// Return success or failure response
if ($result > 0) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "failure"]);
}