<?php 

include "../connect.php";

// Filter the input data using the filterRequest function
$companyid = filterRequest("companyid");
$companyname = filterRequest("companyname");
$companydescription = filterRequest("companydescription");
$companynickid = filterRequest("companynickid");
$companyworkers = filterRequest("companyworkers");
$companyrole = filterRequest("companyjob");
$companyimage = filterRequest("companyimage"); // assuming image URL or file path is passed

// Prepare the data array for updating the company table
$data = array(
    "company_name" => $companyname,
    "company_description" => $companydescription,
    "company_nickID" => $companynickid,
    "company_workes" => $companyworkers,
    "company_job" => $companyrole
);

// If the image is provided (not null), include it in the update
if (!empty($companyimage)) {
    $data["company_image"] = $companyimage;
}

// Update the company data in the database based on the company ID
updateData("company", $data, "company_ID = $companyid");

?>
