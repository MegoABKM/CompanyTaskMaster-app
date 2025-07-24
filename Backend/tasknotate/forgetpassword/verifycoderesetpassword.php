<?php  



include "../connect.php";



$email = filterRequest("email");
$verifycode = filterRequest("verifycode");
$stmt = $con->prepare("SELECT * FROM users WHERE users_email = '$email' AND users_verifycode= '$verifycode' ");

$stmt->execute();
$count = $stmt->rowCount();

if($count > 0){
 echo json_encode(array("status" => "success"));
}

else 
echo json_encode(array("status" => "fail" , "message"=> "verify not correct"));



