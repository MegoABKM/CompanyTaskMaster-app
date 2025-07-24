<?php
include "../connect.php";

ob_start();

// Get and validate input
$username = filterRequest("username");
$email = filterRequest("email");
$phone = filterRequest("phone");

// Check if all required fields are present
if (empty($username) || empty($email) || empty($phone)) {
    echo json_encode(array(
        "status" => "failure",
        "message" => "Missing required fields: " . 
                     (empty($username) ? "username " : "") .
                     (empty($email) ? "email " : "") .
                     (empty($phone) ? "phone" : "")
    ));
    ob_end_flush();
    exit;
}

try {
    // Check for existing phone
    $stmt = $con->prepare("SELECT users_id FROM users WHERE users_phone = ?");
    $stmt->execute(array($phone));
    if ($stmt->rowCount() > 0) {
        echo json_encode(array(
            "status" => "failure",
            "message" => "Phone number already exists"
        ));
        ob_end_flush();
        exit;
    }

    // Check for existing email
    $stmt = $con->prepare("SELECT * FROM users WHERE users_email = ?");
    $stmt->execute(array($email));
    $count = $stmt->rowCount();

    if ($count > 0) {
        // Update existing user
        $stmt = $con->prepare("UPDATE users SET users_name = ?, users_phone = ?, users_approve = 1, users_googlesigned = 1 WHERE users_email = ?");
        $stmt->execute(array($username, $phone, $email));
        $stmt = $con->prepare("SELECT * FROM users WHERE users_email = ?");
        $stmt->execute(array($email));
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        echo json_encode(array(
            "status" => "success",
            "data" => $user
        ));
    } else {
        // Insert new user
        $stmt = $con->prepare("INSERT INTO users (users_name, users_email, users_phone, users_approve, users_googlesigned) VALUES (?, ?, ?, 1, 1)");
        $stmt->execute(array($username, $email, $phone));
        $insertId = $con->lastInsertId();
        $stmt = $con->prepare("SELECT * FROM users WHERE users_id = ?");
        $stmt->execute(array($insertId));
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        echo json_encode(array(
            "status" => "success",
            "data" => $user
        ));
    }
} catch (PDOException $e) {
    echo json_encode(array(
        "status" => "failure",
        "message" => "Database error: " . $e->getMessage()
    ));
}

ob_end_flush();