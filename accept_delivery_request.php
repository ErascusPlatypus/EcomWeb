<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$order_id = $_POST['order_id'];


$sql = "UPDATE `orders` SET `driver_status`='1' WHERE `id` = '$order_id'";


$resultSearch = mysqli_query($conn, $sql);
if ($resultSearch) {
    $data['success'] = true;
    $data["message"] = "Delivery request accepted.";
    echo json_encode($data);
} else {
    $data['success'] = false;
    $data["message"] = "Failed to accept request.";
    echo json_encode($data);
}


$conn->close();
