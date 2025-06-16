<?php
include "../connect.php";




// Handle company data submission
$companyname = filterRequest("companyname");
$companynickid = filterRequest("companynickid");
$companydescription = filterRequest("companydescription");
$companyworkers = filterRequest("companyworkers");
$companyjob = filterRequest("companyjob");
$companyimage = filterRequest("companyimage");

$userid = filterRequest("userid");

$data = array(
    "company_name" => $companyname,
    "company_image" => $companyimage,  // Store the uploaded image's filename or path
    "company_description" => $companydescription,
    "company_job" => $companyjob,
    "company_managerID" => $userid,
    "company_nickID" => $companynickid,
    "company_workes" => $companyworkers,
);




// Insert data into the database
 insertData("company", $data);
