<?php
include "../connect.php";

// Prevent unwanted output
ob_start();
$email = filterRequest("email");

try {
    $stmt = $con->prepare("SELECT * FROM users WHERE users_email = ?");
    $stmt->execute(array($email));
    $count = $stmt->rowCount();

    if ($count > 0) {
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($user['users_googlesigned'] == 1 && $user['users_approve'] == 1) {
            // Approved Google user
            echo json_encode(array(
                "status" => "success",
                "navigate" => "company",
                "data" => $user
            ));
        } else {
            // Existing but not fully set up
            $stmt2 = $con->prepare("UPDATE users SET users_googlesigned = ? WHERE users_email = ?");
            $stmt2->execute(array(1, $email));
            $user['users_googlesigned'] = 1; // Update in memory for response
            echo json_encode(array(
                "status" => "success",
                "navigate" => "createprofile",
                "data" => $user
            ));
        }
    } else {
        // New user
        echo json_encode(array(
            "status" => "success",
            "navigate" => "createprofile",
            "data" => null
        ));
    }
} catch (PDOException $e) {
    echo json_encode(array(
        "status" => "failure",
        "message" => "Database error: " . $e->getMessage()
    ));
}

ob_end_flush();