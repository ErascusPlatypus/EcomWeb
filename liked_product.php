<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Retrieve values sent from Flutter through POST request
$imageurl = $_POST['imageurl'];
$name = $_POST['name'];
$description = $_POST['description'];
$price = $_POST['price'];
$categoryid = $_POST['categoryid'];
$seller_id = $_POST['seller_id'];
$gst = $_POST['gst'];
$email_id = $_POST['email_id'];
$pid = $_POST['pid']; 

// SQL query to check if the row with the same pid and email already exists
$check_sql = "SELECT * FROM likedproduct WHERE pid='$pid' AND email_id='$email_id'";
$check_result = $conn->query($check_sql);

if ($check_result->num_rows > 0) {
    // Row with the same pid and email already exists
    $response = array("status" => "error", "message" => "exists");
    echo json_encode($response);
} else {
    // Row does not exist, proceed with inserting the new row
    $insert_sql = "INSERT INTO likedproduct (pid, imageurl, name, description, price, categoryid, seller_id, gst, email_id) 
                   VALUES ('$pid', '$imageurl', '$name', '$description', '$price', '$categoryid', '$seller_id', '$gst', '$email_id')";

    if ($conn->query($insert_sql) === TRUE) {
        $response = array("status" => "success", "message" => "success");
        echo json_encode($response);
    } else {
        $response = array("status" => "error", "message" => "Error: " . $insert_sql . "<br>" . $conn->error);
        echo json_encode($response) ;
    }
}

// Close connection
$conn->close();

?>
