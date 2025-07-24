<?php

uploadFile("file");

function uploadFile($fileRequest)
{
    global $msgError;

    // Get the user-provided filename from the POST request
    $userFilename = isset($_POST['filename']) ? sanitizeFileName($_POST['filename']) : '';

    // Get the file extension
    $ext = strtolower(pathinfo($_FILES[$fileRequest]['name'], PATHINFO_EXTENSION));

    // Generate a unique file name: timestamp + random number + user filename + extension
    $filename = time() . rand(1000, 99999) . '_' . $userFilename . '.' . $ext;
    $fileTmp  = $_FILES[$fileRequest]['tmp_name'];
    $fileSize = $_FILES[$fileRequest]['size'];

    // Allowed file extensions
    $allowedExts = ['jpg', 'png', 'gif', 'jpeg', 'pdf', 'pptx', 'mp3', 'wav', 'doc', 'docx', 'mp4', 'avi', 'mkv'];

    // Validate file extension
    if (!in_array($ext, $allowedExts)) {
        $msgError = "Invalid file extension.";
        return jsonResponse("fail", "Invalid file extension.");
    }

    // Validate file size (max 4MB)
    if ($fileSize > 4 * 1024 * 1024) {
        $msgError = "File size exceeds 4MB.";
        return jsonResponse("fail", "File size exceeds 4MB.");
    }

    // Define upload path
    $uploadPath = __DIR__ . "/upload/files/company/";

    // Create the directory if it doesn't exist
    if (!file_exists($uploadPath)) {
        mkdir($uploadPath, 0777, true);
    }

    // Move the uploaded file to the target directory
    if (move_uploaded_file($fileTmp, $uploadPath . $filename)) {
        $url = 'https://localhost:8080/upload/files/company/' . $filename;

        return jsonResponse("success", "File uploaded successfully.", $filename, $url);
    } else {
        return jsonResponse("fail", "Failed to upload file.");
    }
}

// Helper function for standardized JSON response
function jsonResponse($status, $message, $filename = null, $url = null)
{
    $response = [
        "status" => $status,
        "message" => $message,
    ];

    if ($filename) {
        $response["filename"] = $filename;
    }

    if ($url) {
        $response["url"] = $url;
    }

    echo json_encode($response);
    exit;
}

// Helper function to sanitize file names
function sanitizeFileName($name)
{
    // Remove any characters that are not alphanumeric, underscores, or spaces
    return preg_replace('/[^a-zA-Z0-9_\s]/', '', $name);
}

?>
