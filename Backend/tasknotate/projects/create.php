<?php
include "../connect.php";

$name = filterRequest("project_name");
$methodology = filterRequest("methodology_type");
$description = filterRequest("project_description");
$companyId = filterRequest("company_id");
$managerId = filterRequest("manager_id");
$deadline = filterRequest("deadline");
$priority = filterRequest("priority");
$budget = filterRequest("budget"); // NEW: Get budget from request

if (empty($name) || empty($methodology) || empty($companyId) || empty($managerId)) {
    echo json_encode(["status" => "failure", "message" => "Required fields are missing."]);
    exit;
}

$data = array(
    "project_name" => $name,
    "methodology_type" => $methodology,
    "project_description" => $description,
    "company_id" => $companyId,
    "manager_id" => $managerId,
    "deadline" => !empty($deadline) ? $deadline : null,
    "priority" => !empty($priority) ? $priority : 'Medium',
    "budget" => !empty($budget) ? $budget : 0.00 // NEW: Add budget to data array
);

insertData("projects", $data);
?>