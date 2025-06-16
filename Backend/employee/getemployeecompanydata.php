<?php
include "../connect.php";

$userid = filterRequest("userid");

// Fetch company details
$stmt = $con->prepare("
    SELECT 
        c.company_ID AS company_id,
        c.company_name,
        c.company_description,
        c.company_image,
        c.company_nickID,
        c.company_workes,
        c.company_managerID,
        c.company_job,
        m.users_id AS manager_id,
        m.users_name AS manager_name,
        m.users_email AS manager_email,
        m.users_image AS manager_image
    FROM 
        employee_company ec
    JOIN 
        company c ON ec.company_id = c.company_ID
    LEFT JOIN 
        users m ON c.company_managerID = m.users_id
    WHERE 
        ec.managerapprove = 1
        AND c.company_ID IN (
            SELECT ec2.company_id FROM employee_company ec2 WHERE ec2.user_id = ?
        )
");

$stmt->execute([$userid]);
$companies = $stmt->fetchAll(PDO::FETCH_ASSOC);

$result = [];

// Store company details
foreach ($companies as $company) {
    $companyId = $company['company_id'];
    $result[$companyId] = [
        "company" => [
            "company_id" => $company['company_id'],
            "company_name" => $company['company_name'],
            "company_description" => $company['company_description'],
            "company_job" => $company['company_job'],
            "company_image" => $company['company_image'],
            "company_nickID" => $company['company_nickID'],
            "company_workes" => $company['company_workes'],
            "manager" => [
                "manager_id" => $company['manager_id'],
                "manager_name" => $company['manager_name'],
                "manager_email" => $company['manager_email'],
                "manager_image" => $company['manager_image']
            ],
            "employees" => []
        ],
        "newtasks" => []
    ];

    // Fetch latest 2 tasks per company by MAX(task_id)
    $stmtTasks = $con->prepare("
        SELECT 
            t.id AS task_id,
            t.title AS task_title,
            t.description AS task_description,
            t.created_on AS task_created_on,
            t.due_date AS task_due_date,
            t.priority AS task_priority,
            t.last_updated AS task_updateddate,
            t.status AS task_status,
            t.company_id,
            c.company_name,
            c.company_image
        FROM 
            tasks t
        JOIN company c ON t.company_id = c.company_ID
        WHERE 
            t.company_id = ?
        ORDER BY 
            t.id DESC
        LIMIT 2
    ");

    $stmtTasks->execute([$companyId]);
    $tasks = $stmtTasks->fetchAll(PDO::FETCH_ASSOC);

    $result[$companyId]["newtasks"] = $tasks;

    // Fetch employees for each company
    $stmtEmployees = $con->prepare("
        SELECT 
            u.users_id AS employee_id,
            u.users_name AS employee_name,
            u.users_email AS employee_email,
            u.users_image AS employee_image,
            u.users_phone AS employee_phone
        FROM 
            employee_company ec
        JOIN 
            users u ON ec.user_id = u.users_id
        WHERE 
            ec.managerapprove = 1 AND ec.company_id = ?
    ");

    $stmtEmployees->execute([$companyId]);
    $employees = $stmtEmployees->fetchAll(PDO::FETCH_ASSOC);

    // Add employees inside "company" under "manager"
    $result[$companyId]["company"]["employees"] = $employees;
}

// Re-index the array
$response = array_values($result);

// Return data as JSON
if (!empty($response)) {
    echo json_encode(["status" => "success", "data" => $response]);
} else {
    echo json_encode(["status" => "failure", "message" => "No data found"]);
}
