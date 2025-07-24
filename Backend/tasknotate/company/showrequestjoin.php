<?php

include "../connect.php";

$managerid = filterRequest("userid");

// Single query with JOIN to fetch pending requests along with user details
$query = "
    SELECT 
        ec.employee_company_id, 
        ec.user_id, 
        ec.daterequest, 
        ec.company_id, 
        c.company_name, 
        c.company_nickID, 
        c.company_workes,
        u.users_name, 
        u.users_email, 
        u.users_phone, 
        u.users_image
    FROM 
        employee_company ec
    JOIN 
        company c 
    ON 
        ec.company_id = c.company_ID
    JOIN
        users u
    ON
        ec.user_id = u.users_id
    WHERE 
        c.company_managerID = $managerid AND ec.managerapprove = 0
";

$stmt = $con->prepare($query);
$stmt->execute();
$requests = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Return the results as JSON
echo json_encode(["status" => "success", "data" => $requests]);

?>
