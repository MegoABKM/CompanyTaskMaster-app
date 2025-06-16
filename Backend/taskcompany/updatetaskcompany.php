<?php

include "../connect.php";

// Define filterRequest function for sanitization

// Get the incoming request parameters
$taskid = filterRequest("taskid");
$tasktitle = filterRequest("tasktitle");
$taskdescription = filterRequest("taskdescription");
$taskduedate = filterRequest("taskduedate");
$taskpriority = filterRequest("taskpriority");
$taskstatus = filterRequest("taskstatus");
$tasklastupdate = filterRequest("tasklastupdate");
$companyid = filterRequest("companyid");

if (!$companyid) {
  echo json_encode(['status' => 'failure', 'message' => 'Company ID is required']);
  exit;  // Stop further execution if companyid is missing
}


// Prepare task data
$data = array(
    "title" => $tasktitle,
    "description" => $taskdescription,
    "due_date" => $taskduedate,
    "priority" => $taskpriority,
    "status" => $taskstatus,
    "last_updated" => $tasklastupdate
);
$updateSuccess = updateData("tasks", $data, "id = $taskid", false);

if ($updateSuccess) {
    // Send notification after updating task
    sendNotificationToTopicwithcomposer("Task Updated", "$tasktitle", "$companyid");
    echo json_encode(['status' => 'success', 'message' => 'Task updated successfully']);
} else {
    echo json_encode(['status' => 'failure', 'message' => 'Failed to update task']);
}
?>
