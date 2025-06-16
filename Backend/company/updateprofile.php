<?php
include "../connect.php";

// Extract parameters from the request
$userid = filterRequest("userid");
$username = filterRequest("username");
$userphone = filterRequest("userphone");
$userimage = filterRequest("userimage");

// Prepare the data to be updated in the database
$data = array(
    "users_name" => $username,
    "users_phone" => $userphone
);

// Only add the image URL to the data if it's not empty
if (!empty($userimage)) {
    $data["users_image"] = $userimage;
}

// Update user data in the database
updateData("users", $data, "users_id = $userid", false);

// Send a success response
echo json_encode(["status" => "success"]);
