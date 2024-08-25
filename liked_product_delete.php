<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Retrieve values sent from Flutter through POST request
$pid = $_POST['pid'];
$email_id = $_POST['email_id'];

// SQL query to delete record from likedproduct table
$sql = "DELETE FROM likedproduct WHERE pid = '$pid' AND email_id = '$email_id'";

if ($conn->query($sql) === TRUE) {
    $response = array("status" => "success", "message" => "Record deleted successfully");
    echo json_encode($response);
} else {
    $response = array("status" => "error", "message" => "Error: " . $sql . "<br>" . $conn->error);
    echo json_encode($response);
}

// Close connection
$conn->close();

?>
