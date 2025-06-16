<?php

include "../connect.php";

$userid = filterRequest("userid");
$companyid = filterRequest("companyid");

try {
    // Step 1: Check if the company exists and fetch manager_id
    $stmt = $con->prepare("SELECT company_ID, company_managerID FROM company WHERE company_ID = ?");
    $stmt->execute([$companyid]);
    $company = $stmt->fetch();

    if ($company) {
        $managerId = $company['company_managerID'];

        // Step 2: Prevent managers from joining as employees
        if ($userid == $managerId) {
            echo json_encode(array(
                "status" => "failed",
                "message" => "You're already the captain of this ship! No need to join as an employee."
            ));
            exit; 
        }

        // Step 3: Check if the employee has already sent a request or is already part of the company
        $stmt = $con->prepare("SELECT COUNT(*) AS count FROM employee_company WHERE user_id = ? AND company_id = ?");
        $stmt->execute([$userid, $companyid]);
        $result = $stmt->fetch();

        if ($result['count'] > 0) {
            // Request already sent
            echo json_encode(array("status" => "failed", "message" => "Request already sent. Please wait for approval."));
        } else {
            // Step 4: Insert the request if it doesn't exist
            $data = array(
                'user_id' => $userid,
                'company_id' => $companyid
            );

            $count = insertDataWithNoJson("employee_company", $data);

            if ($count > 0) {
                // Step 5: Send a notification to the manager
                $messageTitle = "New Join Request";
                $messageBody = "An employee has requested to join your company.";
                
                // Add custom data to the notification
                $customData = [
                    'type' => 'joinrequest', // Key to identify the action
                    'userId' => $userid,    // Include userId for reference
                    'companyId' => $companyid // Include companyId for reference
                ];

                // Send notification to the manager (use managerId as the topic)
                sendNotificationToTopicwithcomposer($messageTitle, $messageBody, $managerId, $customData);

                echo json_encode(array("status" => "success", "message" => "Submitted, waiting for manager approval."));
            } else {
                echo json_encode(array("status" => "failed", "message" => "Failed to submit request. Please try again."));
            }
        }
    } else {
        echo json_encode(array("status" => "failed", "message" => "Invalid company ID."));
    }
} catch (PDOException $e) {
    error_log("PDOException: " . $e->getMessage());

    echo json_encode(array("status" => "failed", "message" => "Database error. Please try again later."));
}

?>