<?php
include "../connect.php";

// Get the IDs from the request
$employeeId = filterRequest('employee_id');
$managerName = filterRequest('manager_name'); // We'll get the manager's name to make the notification personal

if (empty($employeeId) || empty($managerName)) {
    echo json_encode(["status" => "failure", "message" => "Required IDs or names are missing."]);
    exit;
}

// Prepare the notification content
$title = "You have a nudge! - لديك نكزة!";
$body = "$managerName just sent you a nudge.";
$arabicBody = "نكزك $managerName.";

// It's good practice to send a generic data payload
$data = ['type' => 'nudge'];

// Send the notification to the employee's user ID topic
// We assume each user subscribes to a topic matching their own user ID
sendNotificationToTopicwithcomposer($title, $body, $employeeId, $data);

// Return a success response
echo json_encode(["status" => "success", "message" => "Nudge sent successfully."]);

?>