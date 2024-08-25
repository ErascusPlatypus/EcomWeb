<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Retrieve email sent from Flutter through POST request
$email_id = $_POST['email_id'];

// SQL query to fetch all details of the product based on the provided email
$sql = "SELECT * FROM likedproduct WHERE email_id='$email_id'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Product details found, create an array to store the details
    $product_details = array();
    while ($row = $result->fetch_assoc()) {
        // Append each row (product details) to the array
        $product_details[] = $row;
    }
    // Return the product details as JSON response
    echo json_encode(array("status" => "success", "product_details" => $product_details));
} else {
    // No product details found for the provided email
    echo json_encode(array("status" => "error", "message" => "No product details found for the provided email"));
}

// Close connection
$conn->close();

?>
