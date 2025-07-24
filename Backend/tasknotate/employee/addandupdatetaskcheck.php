<?php

include "../connect.php";

// Get the parameters from the request
$taskid = filterRequest("taskid");
$userid = filterRequest("userid");
$checkstate = filterRequest("checkstate");
$username = filterRequest("username");
$tasktitle = filterRequest("tasktitle");

// Get the company_id for the task by querying the task table
$stmt = $con->prepare("SELECT company_id FROM tasks WHERE id = ?");
$stmt->execute([$taskid]);
$task = $stmt->fetch(PDO::FETCH_ASSOC);

if ($task) {
    // Get the company_id associated with this task
    $company_id = $task['company_id'];

    // Get the managerID from the company table using company_id
    $stmt = $con->prepare("SELECT company_managerID FROM company WHERE company_ID = ?");
    $stmt->execute([$company_id]);
    $company = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($company) {
        // Get the manager's ID (this will be used to send the notification)
        $managerID = $company['company_managerID'];

        // Check if the record already exists in checktask table
        $stmt = $con->prepare("SELECT * FROM checktask WHERE checktask_taskid = ? AND checktask_userid = ?");
        $stmt->execute([$taskid, $userid]);
        $count = $stmt->rowCount();

        if ($count > 0) {
            // If exists, update the record
            $data = array("checktask_status" => $checkstate);
            updateData("checktask", $data, "checktask_taskid = '$taskid' AND checktask_userid = '$userid'");
        } else {
            // If not exists, insert a new record
            $data = array(
                "checktask_taskid" => $taskid,
                "checktask_userid" => $userid,
                "checktask_status" => $checkstate
            );
            insertData("checktask", $data);
        }

        // Send notification to the manager's topic
        $messageTitle = "$username Checked The Task $tasktitle";
        $messageBody = "$checkstate";

        // Send notification to the manager using the managerID as the topic
        sendNotificationToTopicWithComposer($messageTitle, $messageBody, $managerID);

        // Return success message
        echo json_encode(['status' => 'success', 'message' => 'Task status updated and notification sent to manager.']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Manager not found for the company.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Task not found.']);
}

?>
