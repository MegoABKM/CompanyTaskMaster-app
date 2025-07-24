<?php

include "../connect.php";

// Get the incoming request parameters
$employeeCompanyId = filterRequest('employeecompanyid');
$employeeId = filterRequest('employeeid');

// Check if the employeeCompanyId and employeeId are valid
if ($employeeCompanyId && $employeeId) {
    // Prepare the data to be updated
    $data = array(
        'managerapprove' => 1 // Set managerapprove to 1 (Accepted)
    );

    // Perform the update operation to mark the request as accepted
    $result = updateData("employee_company", $data, "employee_company_id = $employeeCompanyId", false);

    // Check if the update was successful
    if ($result) {
        // Send a notification to the specific user (employee)
        $messageTitle = "Manager Approval";
        $messageBody = "Your request has been accepted by the manager.";
        
        // Add custom data to the notification
        $customData = [
            'type' => 'employeeaccepted', // Key to identify the action
            'employeeId' => $employeeId,  // Optional: Include employeeId for reference
        ];

        // Send notification to the user (use employeeId as the topic)
        sendNotificationToTopicwithcomposer($messageTitle, $messageBody, $employeeId, $customData);

        // Return a success message as JSON
        echo json_encode(['status' => 'success', 'message' => 'Request accepted and notification sent.']);
    } else {
        // Return an error message if the update failed
        echo json_encode(['status' => 'error', 'message' => 'Failed to update approval status.']);
    }
} else {
    // Return an error message if employeeCompanyId or employeeId is not valid
    echo json_encode(['status' => 'error', 'message' => 'Invalid employee company ID or employee ID.']);
}

?>