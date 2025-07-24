<?php

include "../connect.php";

// Get the employeecompanyid and employeeid from the request
$employeeCompanyId = filterRequest('employeecompanyid');
$employeeid = filterRequest('employeeid');

// Check if the employeeCompanyId and employeeid are valid
if ($employeeCompanyId && $employeeid) {
    // Prepare the data to be updated
    $data = array(
        'managerapprove' => 2 // Set managerapprove to 2 (Rejected)
    );

    // Perform the update operation
    $result = updateData("employee_company", $data, "employee_company_id = $employeeCompanyId", false);

    // Check if the update was successful
    if ($result) {
        // Send a notification to the employee
        $messageTitle = "Manager Approval";
        $messageBody = "Your request has been rejected by the manager.";
        
        // Add custom data to the notification
        $customData = [
            'type' => 'employeerejected', // Key to identify the action
            'employeeId' => $employeeid,  // Include employeeId for reference
        ];

        // Send notification to the user (use employeeid as the topic)
        sendNotificationToTopicwithcomposer($messageTitle, $messageBody, $employeeid, $customData);

        // Return a success message as JSON
        echo json_encode(['status' => 'success', 'message' => 'Request rejected.']);
    } else {
        // Return an error message if the update failed
        echo json_encode(['status' => 'error', 'message' => 'Failed to update approval status.']);
    }
} else {
    // Return an error message if employeeCompanyId or employeeid is not valid
    echo json_encode(['status' => 'error', 'message' => 'Invalid employee company ID or employee ID.']);
}

?>