<?php  



include "../connect.php";


$email = filterRequest("email");

$verifycode = rand(10000,99999);
$stmt = $con->prepare("SELECT * FROM users WHERE `users_email` = ?");

$stmt->execute(array($email));
$count = $stmt->rowCount();

if($count > 0){
 echo json_encode(array("status" => "success"));
 $data = array("users_verifycode" => $verifycode);
  updateData("users",$data,"users_email = '$email'",false);
    // sendEmail($email,"Verifiy Code Ecommerce App","Verify Code $verifycode");
}

else 
echo json_encode(array("status" => "fail" , "message"=> "email not correct"));
