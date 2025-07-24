<?php
// c:/xampp/htdocs/tasknotate/finances/delete_entry.php
include "../connect.php";

$id = filterRequest("id");
$type = filterRequest("type"); // Expected: 'company' or 'project'

if (empty($id) || empty($type)) {
    echo json_encode(["status" => "failure", "message" => "ID and type are required."]);
    exit;
}

if ($type === 'company') {
    deleteData("company_finances", "id = $id");
} elseif ($type === 'project') {
    deleteData("project_finances", "id = $id");
} else {
    echo json_encode(["status" => "failure", "message" => "Invalid entry type."]);
}
?>