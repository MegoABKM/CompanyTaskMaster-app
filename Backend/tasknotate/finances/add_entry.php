<?php
include "../connect.php";

$type = filterRequest("type"); // 'Income', 'Expense', 'Revenue', 'Cost'
$description = filterRequest("description");
$amount = filterRequest("amount");
$date = filterRequest("date");
$category = filterRequest("category");
$company_id = filterRequest("company_id");

// FIX: Only try to get 'project_id' if the request type is for a project.
$project_id = null; // Default to null
if (isset($_POST['project_id'])) {
    $project_id = filterRequest("project_id");
}

if (empty($type) || empty($description) || empty($amount) || empty($date) || empty($company_id)) {
    echo json_encode(["status" => "failure", "message" => "Missing required fields."]);
    exit;
}

if (in_array($type, ['Income', 'Expense'])) {
    // Company Finance Entry
    $data = array(
        "company_id" => $company_id,
        "type" => $type,
        "description" => $description,
        "amount" => $amount,
        "date" => $date,
        "category" => $category
    );
    insertData("company_finances", $data);

} elseif (in_array($type, ['Revenue', 'Cost']) && !empty($project_id)) {
    // Project Finance Entry
    $data = array(
        "project_id" => $project_id,
        "type" => $type,
        "description" => $description,
        "amount" => $amount,
        "date" => $date,
        "category" => $category
    );
    insertData("project_finances", $data);

} else {
    // This handles cases where the type is wrong or a project_id is missing for a project entry
    echo json_encode(["status" => "failure", "message" => "Invalid entry type or missing project ID for this entry type."]);
}
?>