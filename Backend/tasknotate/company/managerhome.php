<?php
include "../connect.php";

// Get the manager's user ID from the request
$managerId = filterRequest("userid");

// ==========================================================
// 1. Fetch Company Data (Existing Code - No Changes Needed Here)
// ==========================================================
$companyQuery = "
    SELECT 
        company.company_ID AS company_id,
        company.company_name,
        company.company_image,
        company.company_job,
        company.company_nickID,
        company.company_workes,
        company.company_description,
        company.company_managerID,
        manager.users_id AS manager_id,
        manager.users_name AS manager_name,
        manager.users_email AS manager_email,
        manager.users_image AS manager_image,
        users.users_id AS employee_id,
        users.users_name AS employee_name,
        users.users_email AS employee_email,
        users.users_phone AS employee_phone,
        users.users_image AS employee_image
    FROM 
        company
    LEFT JOIN 
        employee_company ON company.company_ID = employee_company.company_id 
        AND employee_company.managerapprove = 1
    LEFT JOIN 
        users ON employee_company.user_id = users.users_id
    LEFT JOIN 
        users AS manager ON company.company_managerID = manager.users_id
    WHERE 
        company.company_managerID = ?
";

$stmt = $con->prepare($companyQuery);
$stmt->execute(array($managerId));
$companyData = $stmt->fetchAll(PDO::FETCH_ASSOC);

$company = [];
foreach ($companyData as $row) {
    $companyId = $row['company_id'];
    if (!isset($company[$companyId])) {
        $company[$companyId] = [
            'company_id' => $companyId,
            'company_name' => $row['company_name'],
            'company_description' => $row['company_description'],
            'company_job' => $row['company_job'],
            'company_image' => $row['company_image'],
            'company_nickID' => $row['company_nickID'],
            'company_workes' => $row['company_workes'],
            'manager' => [
                'manager_id' => $row['manager_id'],
                'manager_name' => $row['manager_name'],
                'manager_email' => $row['manager_email'],
                'manager_image' => $row['manager_image']
            ],
            'employees' => []
        ];
    }
    if (!empty($row['employee_id'])) {
        $company[$companyId]['employees'][] = [
            'employee_id' => $row['employee_id'],
            'employee_name' => $row['employee_name'],
            'employee_email' => $row['employee_email'],
            'employee_phone' => $row['employee_phone'],
            'employee_image' => $row['employee_image']
        ];
    }
}


// ==========================================================
// 2. Fetch Task Check Data (Existing Code - No Changes Needed Here)
// ==========================================================
$checktaskQuery = "
    SELECT 
        checktask.checktask_id, 
        checktask.checktask_status, 
        checktask.checktask_date, 
        tasks.id AS task_id, 
        tasks.title AS task_name, 
        users.users_id AS employee_id, 
        users.users_name AS employee_name, 
        users.users_email AS employee_email, 
        users.users_image AS employee_image, 
        company.company_name, 
        tasks.company_id AS task_company_id
    FROM checktask
    JOIN tasks ON checktask.checktask_taskid = tasks.id
    JOIN users ON checktask.checktask_userid = users.users_id
    JOIN company ON tasks.company_id = company.company_ID
    WHERE company.company_managerID = ?
    ORDER BY checktask.checktask_date DESC
    LIMIT 5
";

$stmt = $con->prepare($checktaskQuery);
$stmt->execute([$managerId]);
$checktaskData = $stmt->fetchAll(PDO::FETCH_ASSOC);


// ==========================================================
// 3. THE FIX: Fetch Active Projects
// ==========================================================
// We find the company ID first, assuming a manager only has one company.
$companyIdForProjects = null;
if (!empty($company)) {
    // Get the first company's ID from the processed array
    $companyIdForProjects = reset($company)['company_id'];
}

$projectsData = []; // Default to empty array
if ($companyIdForProjects) {
    // We can re-use the `projects/get_all.php` logic here
    $projectsQuery = "
        SELECT 
            p.*,
            (SELECT COUNT(*) FROM tasks t WHERE t.project_id = p.project_id) as task_count,
            (SELECT COUNT(*) FROM project_employees pe WHERE pe.project_id = p.project_id) as member_count
        FROM 
            projects p
        WHERE 
            p.company_id = ? AND p.status = 'Active'
        ORDER BY 
            p.created_at DESC
        LIMIT 5
    ";
    $stmt = $con->prepare($projectsQuery);
    $stmt->execute([$companyIdForProjects]);
    $projectsData = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// ==========================================================
// 4. Assemble the Final Response
// ==========================================================
$response = [
    'status' => 'success',
    'data' => [
        'company' => array_values($company),
        'taskcheck' => $checktaskData,
        'active_projects' => $projectsData // Add the projects data to the response
    ]
];

// Return the combined data as a JSON response
echo json_encode($response);
?>