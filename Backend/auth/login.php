<?php  



include "../connect.php";

$email = filterRequest("email");
$password = sha1($_POST['password']);

// $stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? AND users_password = ? AND users_approve = 1");

// $stmt->execute(array($email, $password));
// // result($count);

// $count = $stmt->rowCount();

// if($count > 0){
//  echo json_encode(array("status" => "success"));


// }

// else 
// echo json_encode(array("status" => "fail" , "message"=> "email or password not correct or not aprrove"));
getData("users","users_email = ? AND users_password = ?", array($email, $password));