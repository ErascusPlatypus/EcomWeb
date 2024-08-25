<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";


$$product_id = $_POST['product_id'];
$user_email = $_POST['user_email'];
$rating = $_POST['rating'];
$review = $_POST['review'];

 // inserting the new row
 $insert_sql = "INSERT INTO ratings_and_reviews (product_id, user_email, rating, review) 
 VALUES ('$product_id', '$user_email', '$rating', '$review')";

if ($conn->query($insert_sql) === TRUE) {
$response = array("message" => "Review added successfully");
echo json_encode($response);
} else {
$response = array("status" => "error", "message" => "Error: " . $insert_sql . "<br>" . $conn->error);
echo json_encode($response) ;
}


// Close the connection
$conn->close();
?>
