<?php
include "../connect.php";

$companyId = filterRequest("company_id");

if (empty($companyId)) {
    echo json_encode(["status" => "failure", "message" => "Company ID is required."]);
    exit;
}

$stmt = $con->prepare("
    SELECT 
        p.*,
        (SELECT COUNT(*) FROM tasks t WHERE t.project_id = p.project_id) as task_count,
        (SELECT COUNT(*) FROM project_employees pe WHERE pe.project_id = p.project_id) as member_count
    FROM 
        projects p
    WHERE 
        p.company_id = ?
    ORDER BY 
        p.created_at DESC
");

$stmt->execute([$companyId]);
$projects = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(["status" => "success", "data" => $projects]);
?>