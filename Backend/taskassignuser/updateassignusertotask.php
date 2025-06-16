<?php

include '../connect.php';


$task_id = filterRequest("task_id");
$user_ids = filterRequest("user_id"); 



if (!$task_id) {
    echo json_encode(["status" => "failure", "message" => "Invalid task ID."]);
    exit;
}


$user_ids_array = explode(",",$user_ids);

  
$count = deleteData('assigned_users', "task_id = $task_id" , false);



if (is_array($user_ids_array) && !empty($user_ids_array)) {
    $allSuccessful = true;

  
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
        echo json_encode(["status" => "success", "message" => "All users assigned update successfully."]);
    } else {
        echo json_encode(["status" => "failure", "message" => "Failed to assign some or all users."]);
    }
} else {
    // Handle invalid input
    echo json_encode(["status" => "failure", "message" => "Invalid or empty user list."]);
}

?>
