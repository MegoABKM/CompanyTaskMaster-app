<?php


imageeUpload("image");

function imageeUpload($imageRequest)
{
    global $msgError;

    // Generate unique image name
    $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
    $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
    $imagesize  = $_FILES[$imageRequest]['size'];

    // Allowed file extensions
    $allowExt   = array("jpg", "png", "gif", "jpeg");

    // Get the file extension
    $strToArray = explode(".", $imagename);
    $ext        = strtolower(end($strToArray));

    // Validate file extension
    if (!in_array($ext, $allowExt)) {
        $msgError = "Invalid file extension (only jpg, png, gif, jpeg allowed).";
        return "fail";
    }

    // Validate file size (max 2MB)
    if ($imagesize > 2 * 1024 * 1024) {
        $msgError = "File size exceeds 2MB.";
        return "fail";
    }

    // Define the upload path
    $uploadPath = __DIR__ . "/./upload/images/company/";

    // Create the directory if it doesn't exist
    if (!file_exists($uploadPath)) {
        mkdir($uploadPath, 0777, true);
    }

    // Move the uploaded file to the target directory
    if (move_uploaded_file($imagetmp, $uploadPath . $imagename)) {
        echo json_encode([
            "status" => "success",
            "message" => "File uploaded successfully.",
            "filename" => $imagename
        ]);
        return $imagename;
    } else {
        error_log("Failed to move uploaded file.");
        echo json_encode([
            "status" => "fail",
            "message" => "Failed to upload file."
        ]);
        return "fail";
    }
}


