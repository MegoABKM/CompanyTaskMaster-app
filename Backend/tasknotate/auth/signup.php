<?php
ob_start(); // Buffer output
include "../connect.php";

header('Content-Type: application/json'); // Force JSON content type

$username = filterRequest("username");
$password = sha1($_POST["password"]);
$email = filterRequest("email");
$phone = filterRequest("phone");
$verifycode = rand(10000, 99999);

// Check for duplicates
$stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? OR users_phone = ?");
$stmt->execute(array($email, $phone));
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(["status" => "failure", "message" => "Phone or email already exists"]);
} else {
    $data = array(
        "users_name" => $username,
        "users_email" => $email,
        "users_password" => $password,
        "users_phone" => $phone,
        "users_verifycode" => $verifycode,
    );

    $success = insertDataWithNoJson("users", $data);

    if ($success) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "failure", "message" => "Database error"]);
    }
}

ob_end_flush();