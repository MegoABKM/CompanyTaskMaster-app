<?php

define("MB", 1048576);

function filterRequest($requestname)
{
    return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function getAllData($table, $where = null, $values = null, $json = true)
{
    global $con;
    $data = array();
    if ($where == null) {
        $stmt = $con->prepare("SELECT  * FROM $table  ");
    } else {
        $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    }

    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        }
     else {
        echo json_encode(array("status" => "failure"));
    }

    return $count;
    }

else {if ($count > 0) {
    return array("status" => "success", "data"=> $data);
} else {
    return  array("status" => "failure");
}}
    
}




function getAllDataNotAll($table,$column ,  $where = null, $values = null, $json = true)
{
    global $con;
    $data = array();
    if ($where == null) {
        $stmt = $con->prepare("SELECT $column  FROM $table  ");
    } else {
        $stmt = $con->prepare("SELECT $column FROM $table WHERE   $where ");
    }

    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        }
     else {
        echo json_encode(array("status" => "failure"));
    }

    return $count;
    }

else {if ($count > 0) {
    return array("status" => "success", "data"=> $data);
} else {
    return  array("status" => "failure");
}}
    
}


// function insertData($table, $data, $json = true)
// {
//     global $con;
//     foreach ($data as $field => $v)
//         $ins[] = ':' . $field;
//     $ins = implode(',', $ins);
//     $fields = implode(',', array_keys($data));
//     $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

//     $stmt = $con->prepare($sql);
//     foreach ($data as $f => $v) {
//         $stmt->bindValue(':' . $f, $v);
//     }
//     $stmt->execute();
//     $count = $stmt->rowCount();
//     if ($json == true) {
//         if ($count > 0) {
//             echo json_encode(array("status" => "success"));
//         } else {
//             echo json_encode(array("status" => "failure"));
//         }
//     }
//     return $count;
// }


// Function to insert data into the database
function insertData($table, $data)
{
    global $con;
    $fields = implode(',', array_keys($data));
    $placeholders = ':' . implode(', :', array_keys($data));

    $sql = "INSERT INTO $table ($fields) VALUES ($placeholders)";
    $stmt = $con->prepare($sql);

    foreach ($data as $field => $value) {
        $stmt->bindValue(":$field", $value);
    }

    $stmt->execute();
    $count = $stmt->rowCount();
   
    // Return success or failure as JSON
    if ($count > 0) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "failure"]);
    }

    return $count;
}
 
function insertDataWithNoJson($table, $data)
{
    global $con;
    $fields = implode(',', array_keys($data));
    $placeholders = ':' . implode(', :', array_keys($data));

    $sql = "INSERT INTO $table ($fields) VALUES ($placeholders)";
    $stmt = $con->prepare($sql);

    foreach ($data as $field => $value) {
        $stmt->bindValue(":$field", $value);
    }

    $stmt->execute();
    $count = $stmt->rowCount();
   
    return $count;
}


function updateDataWithNoJson($table, $data, $condition)
{
    global $con;

    // Prepare the fields for the SET clause
    $setClauses = [];
    foreach ($data as $field => $value) {
        $setClauses[] = "$field = :$field";
    }

    // Combine all SET clauses into one string
    $setClause = implode(', ', $setClauses);

    // Add the condition for the WHERE clause (e.g., task_id = ?)
    $sql = "UPDATE $table SET $setClause WHERE $condition";
    $stmt = $con->prepare($sql);

    // Bind values to the prepared statement
    foreach ($data as $field => $value) {
        $stmt->bindValue(":$field", $value);
    }

    // Execute the query
    $stmt->execute();

    // Return the number of affected rows
    $count = $stmt->rowCount();
    return $count;
}

 

function updateData($table, $data, $where, $json = true)
{
    global $con;
    $cols = array();
    $vals = array();

    foreach ($data as $key => $val) {
        $vals[] = "$val";
        $cols[] = "`$key` =  ? ";
    }
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}
function imageUpload($imageRequest)
{
    global $msgError;
    $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
    $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
    $imagesize  = $_FILES[$imageRequest]['size'];
    $allowExt   = array("jpg", "png", "gif", "jpeg");
    $strToArray = explode(".", $imagename);
    $ext        = strtolower(end($strToArray));

    if (!in_array($ext, $allowExt)) {
        $msgError = "EXT";
        return "fail";
    }

    if ($imagesize > 2 * 1024 * 1024) {
        $msgError = "size";
        return "fail";
    }

    $uploadPath = __DIR__ . "/../upload/images/company/";

    if (move_uploaded_file($imagetmp, $uploadPath . $imagename)) {
        return $imagename;
    } else {
        error_log("Failed to move uploaded file.");
        return "fail";
    }
}


function deleteFile($dir, $imagename)
{
    if (file_exists($dir . "/" . $imagename)) {
        unlink($dir . "/" . $imagename);
    }
}

function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345") {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }

    // End




}
function result($count)
{
    if ($count > 0) {
        printsuccess();
    } else {
        printfailure();
    }
}

function printfailure($message = "none")
{

    echo json_encode(array("status" => "failure", "message" => $message));
}


function printsuccess($message = "none")
{

    echo json_encode(array("status" => "success", "message" => $message));
}


function sendEmail($to, $title, $body)
{
    $header = "From: Company <Company@gmail.com>\r\n";

    if (!mail($to, $title, $body, $header)) {
        // Log the error or handle it
        echo "Email sending failed.";
        return false;
    }
    return true;
}




function getData($table, $where = null, $values = null,$json = true)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if($json ==true){
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
    }
} else{
    return $count;
}
  
}





// function insertData($table, $data) {
//     global $pdo;
    
//     // Build the SQL query dynamically
//     $columns = implode(", ", array_keys($data));
//     $placeholders = ":" . implode(", :", array_keys($data));

//     // Prepare the SQL query
//     $query = "INSERT INTO $table ($columns) VALUES ($placeholders)";
//     $stmt = $pdo->prepare($query);

//     // Bind the parameters
//     foreach ($data as $key => $value) {
//         $stmt->bindValue(":$key", $value);
//     }

//     // Execute the query and return the inserted ID
//     if ($stmt->execute()) {
//         // Return the last inserted ID for tasks
//         return $pdo->lastInsertId();
//     } else {
//         return false;
//     }
// }


// Insert task into the "tasks" table
function insertDataTaskAndReturnID($table, $data)
{
    global $con;
    $fields = implode(',', array_keys($data));
    $placeholders = ':' . implode(', :', array_keys($data));

    $sql = "INSERT INTO $table ($fields) VALUES ($placeholders)";
    $stmt = $con->prepare($sql);

    foreach ($data as $field => $value) {
        $stmt->bindValue(":$field", $value);
    }

    $stmt->execute();
    $count = $stmt->rowCount();

    // Return success or failure as an array
    if ($count > 0) {
        return true;
    } else {
        return false;
    }
}




require_once 'vendor/autoload.php'; 

use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use Kreait\Firebase\Exception\MessagingException;
use Kreait\Firebase\Exception\FirebaseException;

function sendNotificationToTopicwithcomposer($title, $body, $topic, $data = []) {
    $serviceAccountPath = __DIR__ . '/tasknote-8d716-059fae08c083.json';
    if (!file_exists($serviceAccountPath)) {
        return "Service account file not found";
    }

    try {
        $factory = (new Factory)->withServiceAccount($serviceAccountPath);
        $messaging = $factory->createMessaging();

        $message = CloudMessage::withTarget('topic', $topic)
            ->withNotification(Notification::create($title, $body))
            ->withData($data);

        return $messaging->send($message);
    } catch (MessagingException $e) {
        return 'FCM send failed: ' . $e->getMessage();
    } catch (FirebaseException $e) {
        return 'Firebase Exception: ' . $e->getMessage();
    } catch (Exception $e) {
        return 'General Exception: ' . $e->getMessage();
    }
}




function sendNotificationToDevice($title, $body, $deviceToken, $data = []) {
    $serviceAccountPath = __DIR__ . '/tasknote-8d716-059fae08c083.json';

    if (!file_exists($serviceAccountPath)) {
        return "❌ ERROR: Service account file not found.";
    }

    try {
        $factory = (new Factory)->withServiceAccount($serviceAccountPath);
        $messaging = $factory->createMessaging();

        $message = CloudMessage::withTarget('token', $deviceToken)
            ->withNotification(Notification::create($title, $body))
            ->withData($data);

        $response = $messaging->send($message);
        echo "✅ Sent to device! Response: " . json_encode($response) . "\n";
        return $response;

    } catch (Exception $e) {
        echo "❌ ERROR: " . $e->getMessage() . "\n";
        return $e->getMessage();
    }
}



function insertnotification($title , $body , $userid){

 $title = filterRequest("title");
 $body = filterRequest("body");
 $userid = filterRequest("userid");

$data = array("notification_title" => $title ,"	notification_body" =>$body ,"notification_userid" =>$userid);

 insertData("notification",$data);
}
   
function deletenotification($id){

    $title = filterRequest("title");
    $body = filterRequest("body");
    $userid = filterRequest("userid");
   
   $data = array("notification_view" => 1);
   
    updateData("notification",$data,"notification_id = $id");
   }