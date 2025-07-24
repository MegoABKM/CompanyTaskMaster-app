<?php
// c:/xampp/htdocs/tasknotate/finances/update_entry.php
include "../connect.php";

$id = filterRequest("id");
$type = filterRequest("type"); // Expected: 'company' or 'project'

// --- START OF FIX ---

// Check for required base parameters
if (empty($id) || empty($type)) {
    echo json_encode(["status" => "failure", "message" => "Entry ID and type are required for an update."]);
    exit;
}

// Initialize an empty array to hold the data we want to update
$data = array();

// Check each field individually. If it was sent in the request, add it to our data array.
if (isset($_POST['description'])) {
    $data["description"] = filterRequest("description");
}
if (isset($_POST['amount'])) {
    $data["amount"] = filterRequest("amount");
}
if (isset($_POST['date'])) {
    $data["date"] = filterRequest("date");
}
if (isset($_POST['category'])) {
    $data["category"] = filterRequest("category");
}

// If the $data array is empty, it means no fields were sent to be updated.
if (empty($data)) {
    echo json_encode(["status" => "failure", "message" => "No fields provided to update."]);
    exit;
}

// --- END OF FIX ---

// Determine the table to update
if ($type === 'company') {
    updateData("company_finances", $data, "id = $id");
} elseif ($type === 'project') {
    updateData("project_finances", $data, "id = $id");
} else {
    echo json_encode(["status" => "failure", "message" => "Invalid entry type."]);
}
?>