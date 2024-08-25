<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include "dbUpload.php";

// Retrieve the email_id sent from Flutter through POST request
$email_id = $_POST['email_id'];

// SQL query to retrieve all liked products by the user
$sql = "SELECT * FROM likedproduct WHERE email_id='$email_id'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $products = array();
    while($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    $response = array("status" => "success", "product_details" => $products);
    echo json_encode($response);
} else {
    $response = array("status" => "error", "message" => "No liked products found");
    echo json_encode($response);
}

// Close connection
$conn->close();
?>
