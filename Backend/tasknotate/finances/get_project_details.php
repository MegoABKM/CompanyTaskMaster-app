<?php
// c:/xampp/htdocs/tasknotate/finances/get_project_details.php
include "../connect.php";

$project_id = filterRequest("project_id");

if (empty($project_id)) {
    echo json_encode(["status" => "failure", "message" => "Project ID is required."]);
    exit;
}

$stmt = $con->prepare("SELECT * FROM project_finances WHERE project_id = ? ORDER BY date DESC");
$stmt->execute([$project_id]);
$projectFinances = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(["status" => "success", "data" => $projectFinances]);
?>