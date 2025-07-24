<?php
include "../connect.php";

$userid = filterRequest("userid");

if (empty($userid)) {
    echo json_encode(["status" => "failure", "message" => "User ID is required."]);
    exit;
}

// --- 1. Fetch Companies the User is a Part Of ---
$companiesQuery = "
    SELECT 
        c.company_ID AS company_id, c.company_name, c.company_description, c.company_job, c.company_image, c.company_nickID, c.company_workes,
        m.users_id AS manager_id, m.users_name AS manager_name, m.users_email AS manager_email, m.users_image AS manager_image
    FROM company c
    JOIN employee_company ec ON c.company_ID = ec.company_id
    LEFT JOIN users m ON c.company_managerID = m.users_id
    WHERE ec.user_id = ? AND ec.managerapprove = 1
";
$stmt_companies = $con->prepare($companiesQuery);
$stmt_companies->execute([$userid]);
$companiesData = $stmt_companies->fetchAll(PDO::FETCH_ASSOC);

foreach ($companiesData as &$company) {
    $employeesQuery = "
        SELECT u.users_id AS employee_id, u.users_name AS employee_name, u.users_email AS employee_email, u.users_phone AS employee_phone, u.users_image AS employee_image
        FROM users u
        JOIN employee_company ec ON u.users_id = ec.user_id
        WHERE ec.company_id = ? AND ec.managerapprove = 1
    ";
    $stmt_employees = $con->prepare($employeesQuery);
    $stmt_employees->execute([$company['company_id']]);
    $company['employees'] = $stmt_employees->fetchAll(PDO::FETCH_ASSOC);
}
unset($company);

// --- 2. Fetch Recent Tasks Assigned to THIS User ---
$tasksQuery = "
    SELECT 
        t.id as task_id, t.title as task_title, t.description as task_description, t.created_on as task_created_on, t.due_date as task_due_date, 
        t.priority as task_priority, t.last_updated as task_updateddate, t.status as task_status, 
        t.company_id, c.company_name, c.company_image
    FROM tasks t
    JOIN assigned_users au ON t.id = au.task_id
    JOIN company c ON t.company_id = c.company_ID
    WHERE au.user_id = ?
    ORDER BY t.created_on DESC
    LIMIT 5
";
$stmt_tasks = $con->prepare($tasksQuery);
$stmt_tasks->execute([$userid]);
$tasksData = $stmt_tasks->fetchAll(PDO::FETCH_ASSOC);

// --- 3. Fetch Active Projects the User is a Member Of ---
$projectsQuery = "
    SELECT 
        p.*,
        c.company_name, -- *** ADD THIS LINE TO GET COMPANY NAME ***
        (SELECT COUNT(*) FROM tasks t WHERE t.project_id = p.project_id) as task_count,
        (SELECT COUNT(*) FROM project_employees pe WHERE pe.project_id = p.project_id) as member_count
    FROM projects p
    JOIN project_employees pe ON p.project_id = pe.project_id
    JOIN company c ON p.company_id = c.company_ID -- *** ADD THIS JOIN ***
    WHERE pe.user_id = ? AND p.status = 'Active'
";
$stmt_projects = $con->prepare($projectsQuery);
$stmt_projects->execute([$userid]);
$projectsData = $stmt_projects->fetchAll(PDO::FETCH_ASSOC);

// --- 4. Assemble the Final JSON Response ---
$response_data = [
    "companies" => $companiesData,
    "newtasks" => $tasksData,
    "projects" => $projectsData
];

echo json_encode(["status" => "success", "data" => $response_data]);

?>