<?php 

include "../connect.php";


$companyid = filterRequest("companyid");


deleteData("company" ,"company_ID = $companyid " );

