<?php 



include "../connect.php";

$employeeid = filterRequest("employeeid");
$companyid = filterRequest("companyid");



deleteData("employee_company" , "user_id = $employeeid AND company_id = $companyid");