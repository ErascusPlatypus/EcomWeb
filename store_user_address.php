<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$email = $_POST['email'];
$street = $_POST['street'];
$flat_number = $_POST['flat_number'];
$postal_code = $_POST['postal_code'];

// SQL query to insert data
$sql = "INSERT INTO user_address (email, street, flat_number, postal_code) VALUES ('$email', '$street', '$flat_number', '$postal_code')";

if (mysqli_query($conn, $sql)) {
    echo json_encode(["status" => "success", "message" => ""]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . mysqli_error($conn)]);
}

// Close connection
$conn->close();
?>