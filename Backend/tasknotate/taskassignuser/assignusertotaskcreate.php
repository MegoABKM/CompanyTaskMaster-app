<?php

include '../connect.php';

// Retrieve task ID and user IDs from the request
$task_id = filterRequest("task_id");
$user_ids = filterRequest("user_id"); // Expecting a comma-separated string

// Split the string into an array
$user_ids_array = explode(",", $user_ids);

// Validate the data
if (is_array($user_ids_array) && !empty($user_ids_array)) {
    $allSuccessful = true;

    // Loop through each user ID and insert data
    foreach ($user_ids_array as $user_id) {
        $user_id = trim($user_id); // Clean any whitespace
        $data = array(
            "task_id" => $task_id,
            "user_id" => $user_id,
        );

        // Check the result of the insertion
        $result = insertDataWithNoJson('assigned_users', $data);

        if (!$result) {
            $allSuccessful = false;
            break;
        }
    }

    // Return response based on the insertion result
    if ($allSuccessful) {
        // Fetch task details for notification content
        $stmt = $con->prepare("SELECT title FROM tasks WHERE id = :task_id");
        $stmt->bindValue(":task_id", $task_id);
        $stmt->execute();
        $task = $stmt->fetch(PDO::FETCH_ASSOC);
        $task_title = $task ? $task['title'] : "Unnamed Task";

        // Send notification to each user's topic
        foreach ($user_ids_array as $user_id) {
            $user_id = trim($user_id);
            sendNotificationToTopicwithcomposer(
                "New Task Assigned",
                "You’ve been assigned: $task_title",
                "$user_id" // Unique topic per user
            );
        }

        echo json_encode([
            "status" => "success",
            "message" => "All users assigned successfully and notifications sent."
        ]);
    } else {
        echo json_encode([
            "status" => "failure",
            "message" => "Failed to assign some or all users."
        ]);
    }
} else {
    // Handle invalid input
    echo json_encode([
        "status" => "failure",
        "message" => "Invalid or empty user list."
    ]);
}

?>
