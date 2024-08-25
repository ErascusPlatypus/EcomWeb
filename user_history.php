<?php
include 'dbUpload.php'; // Reuse the existing connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_POST['user_id'];
    $product_id = $_POST['product_id'];
    $product_name = $_POST['product_name'];
    $product_price = $_POST['product_price'];
    $pd_image_url = $_POST['pd_image_url'];
    $seller_id = $_POST['seller_id'];
    $user_email = $_POST['user_email'];

    // Create the SQL query
    $query = "INSERT INTO user_history (user_id, product_id, product_name, product_price, pd_image_url, seller_id, user_email)
              VALUES ('$user_id', '$product_id', '$product_name', '$product_price', '$pd_image_url', '$seller_id', '$user_email')";

    // Execute the query
    if ($conn->query($query) === TRUE) {
        echo json_encode(array("status" => "success", "message" => "Product history added successfully."));
    } else {
        echo json_encode(array("status" => "failed", "message" => "Failed to add product history. Error: " . $conn->error));
    }

    // Close the connection
    $conn->close();
} else {
    echo json_encode(array("status" => "error", "message" => "Invalid request method."));
}
?>
