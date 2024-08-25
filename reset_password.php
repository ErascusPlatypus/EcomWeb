<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";
$user_email = $_POST['email'];
$password = $_POST["password"];

$sql = "UPDATE `allusers` SET `password`='$password' WHERE `email` = '$user_email'";


$resultsearch = mysqli_query($conn, $sql);
if ($resultsearch) {
    $data['success'] = true;
    $data["message"] = "Password updated successfully";
    echo json_encode($data);
} else {
    $data['success'] = false;
    $data["message"] = "Failed to update your password";
    echo json_encode($data);
}


$conn->close();
