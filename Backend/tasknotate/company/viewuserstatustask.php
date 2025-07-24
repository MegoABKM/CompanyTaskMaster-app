<?php 
include "../connect.php";

$userid = filterRequest("userid");

// SQL Query
$sql = "SELECT 
            checktask.checktask_id, 
            checktask.checktask_status, 
            checktask.checktask_date, 
            tasks.id AS task_id, 
            tasks.title AS task_name, 
            users.users_id AS employee_id, 
            users.users_name AS employee_name, 
            users.users_email AS employee_email, 
            company.company_name, 
            tasks.company_id AS task_company_id
        FROM checktask
        JOIN tasks ON checktask.checktask_taskid = tasks.id
        JOIN users ON checktask.checktask_userid = users.users_id
        JOIN company ON tasks.company_id = company.company_ID
        WHERE company.company_managerID = ?";

// Execute query
$stmt = $con->prepare($sql);
$stmt->execute([$userid]);  // Use the manager's ID here
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Return response as JSON
echo json_encode(["status" => "success", "data" => $data]);
