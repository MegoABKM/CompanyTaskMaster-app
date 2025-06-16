<?php

// Function to delete the file from the server
function deleteFile($filename)
{
    global $msgError;

    // Define the path to the file
    $filePath = __DIR__ . "/upload/files/company/" . $filename;

    // Check if the file exists
    if (file_exists($filePath)) {
        
        // Attempt to delete the file
        if (unlink($filePath)) {
            // Return success response
            echo json_encode(["status" => "success", "message" => "File deleted successfully."]);
        } else {
            // Return fail response
            echo json_encode(["status" => "fail", "message" => "Failed to delete file."]);
        }
    } else {
        // Return fail response when file not found
        echo json_encode(["status" => "fail", "message" => "File not found."]);
    }
}


if (isset($_POST['delete_filename'])) {
    $filename = $_POST['delete_filename']; // The filename to delete
    deleteFile($filename); // Call the deleteFile function
    exit;
}
?>
