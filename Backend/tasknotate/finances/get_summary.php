<?php
include "../connect.php";

$company_id = filterRequest("company_id");

if (empty($company_id)) {
    echo json_encode(["status" => "failure", "message" => "Company ID is required."]);
    exit;
}

// 1. Get Company-level finances
$stmt = $con->prepare("SELECT * FROM company_finances WHERE company_id = ? ORDER BY date DESC");
$stmt->execute([$company_id]);
$companyFinances = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 2. Get Project-level finances for all projects in the company
$stmt = $con->prepare("
    SELECT pf.* 
    FROM project_finances pf
    JOIN projects p ON pf.project_id = p.project_id
    WHERE p.company_id = ? 
    ORDER BY pf.date DESC
");
$stmt->execute([$company_id]);
$projectFinances = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 3. Get all projects for the company to provide names
$stmt = $con->prepare("SELECT project_id, project_name FROM projects WHERE company_id = ?");
$stmt->execute([$company_id]);
$projects = $stmt->fetchAll(PDO::FETCH_ASSOC);

$data = [
    "company_finances" => $companyFinances,
    "project_finances" => $projectFinances,
    "projects" => $projects
];

echo json_encode(["status" => "success", "data" => $data]);
?>