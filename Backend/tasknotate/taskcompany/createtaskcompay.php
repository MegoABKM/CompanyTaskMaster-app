<?php

include "../connect.php";

// Define filterRequest function for sanitization

// Get the incoming request parameters
$taskcompanyid = filterRequest("taskcompanyid");
$projectId = filterRequest("project_id"); // NEW
$tasktitle = filterRequest("tasktitle");
$taskdescription = filterRequest("taskdescription");
$taskcreatedon = filterRequest("taskcreatedon");
$taskduedate = filterRequest("taskduedate");
$taskpriority = filterRequest("taskpriority");
$taskstatus = filterRequest("taskstatus");
$tasklastupdate = filterRequest("tasklastupdate");
$taskstartdate = filterRequest("taskstartdate"); // <-- ADD THIS LINE
$sendnotificationall = filterRequest("tasknotification");

// Prepare task data
$data = array(
    "company_id" => $taskcompanyid,
    "project_id" => !empty($projectId) ? $projectId : null, // NEW
    "title" => $tasktitle,
    "description" => $taskdescription,
    "created_on" => $taskcreatedon,
     "start_date" => !empty($taskstartdate) ? $taskstartdate : null, // <-- ADD 
    "due_date" => $taskduedate,
    "priority" => $taskpriority,
    "status" => $taskstatus,
    "last_updated" => $tasklastupdate
);


// Call the insertData function and insert the task
$insertSuccess = insertDataTaskAndReturnID("tasks", $data);

if ($insertSuccess) {
    $stmt = $con->prepare("SELECT MAX(id) AS task_id FROM tasks WHERE company_id = :company_id");
    $stmt->bindValue(":company_id", $taskcompanyid);
    $stmt->execute();
    $taskData = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($taskData && isset($taskData['task_id'])) {
        // Send response immediately
        echo json_encode(['status' => 'success', 'task_id' => $taskData['task_id']]);
        ob_flush();
        flush();

        // Allow script to continue even if the client disconnects
        ignore_user_abort(true);

        
        if ($sendnotificationall === "true"){ sendNotificationToTopicwithcomposer("New Task Added", "$tasktitle", "$taskcompanyid");}
       
    } else {
        echo json_encode(['status' => 'failure', 'message' => 'Could not fetch task ID']);
    }
}

?>
