<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$order_id = $_POST['order_id'];
date_default_timezone_set("Asia/Calcutta");
$delivery_date = date('Y-m-d H:i:s');
$sql = "UPDATE `orders` SET `delivery_date`='$delivery_date' WHERE `id` = '$order_id'";


$resultSearch = mysqli_query($conn, $sql);
if ($resultSearch) {
    $data['success'] = true;
    $data["message"] = "Delivery completed.";
    echo json_encode($data);
} else {
    $data['success'] = false;
    $data["message"] = "Failed to complete.";
    echo json_encode($data).mysqli_error($conn);
}


$conn->close();
