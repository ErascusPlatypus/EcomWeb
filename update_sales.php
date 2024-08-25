<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include "dbUpload.php";

$sellerId = $_POST['seller_id'];

// Check if the seller_id exists in the seller_orders table
$checkQuery = "SELECT total_orders FROM seller_orders WHERE seller_id = ?";
$stmt = $conn->prepare($checkQuery);
$stmt->bind_param("i", $sellerId);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // Seller exists, increment total_orders
    $stmt->bind_result($totalOrders);
    $stmt->fetch();
    $totalOrders++;
    
    $updateQuery = "UPDATE seller_orders SET total_orders = ? WHERE seller_id = ?";
    $updateStmt = $conn->prepare($updateQuery);
    $updateStmt->bind_param("ii", $totalOrders, $sellerId);
    
    if ($updateStmt->execute()) {
        echo json_encode(array("success" => true, "total_orders" => $totalOrders));
    } else {
        echo json_encode(array("success" => false, "message" => "Failed to update orders."));
    }
    $updateStmt->close();
} else {
    // Seller doesn't exist, insert new row with total_orders = 1
    $insertQuery = "INSERT INTO seller_orders (seller_id, total_orders) VALUES (?, 1)";
    $insertStmt = $conn->prepare($insertQuery);
    $insertStmt->bind_param("i", $sellerId);
    
    if ($insertStmt->execute()) {
        echo json_encode(array("success" => true, "total_orders" => 1));
    } else {
        echo json_encode(array("success" => false, "message" => "Failed to insert new order."));
    }
    $insertStmt->close();
}

$stmt->close();
$conn->close();
