<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include "dbUpload.php";

$sellerId = $_POST['seller_id'];

// Select total_orders for the given seller_id
$result = mysqli_query($conn, "SELECT total_orders FROM seller_orders WHERE seller_id = $sellerId");

if ($row = mysqli_fetch_assoc($result)) {
    echo json_encode(array("success" => true, "total_orders" => $row['total_orders']));
} else {
    echo json_encode(array("success" => false, "message" => "Seller ID not found"));
}

mysqli_close($conn);
?>
