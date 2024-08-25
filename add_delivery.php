<?php
header("Access-Control-Allow-Origin: *");
require_once 'dbUpload.php';

if (isset($_POST['order_id']) && isset($_POST['delivery_date'])) {

    $order_id = $_POST['order_id'];
    $delivery_date = $_POST['delivery_date'];
    $seller = $_POST['seller'];
    $delivery_service_id = $_POST['delivery_service_id'];
} else {
    echo json_encode("Invalid request");
    mysqli_close($conn);
    return;
}

$query = "INSERT INTO `alldeliveries`(`order_id`, `seller`, `delivery_date`, `delivery_service_id`)
                              VALUES ('$order_id','$seller','$delivery_date','$delivery_service_id')";

$exe = mysqli_query($conn, $query);

if ($exe) {
    echo json_encode("Success");
} else {
    echo json_encode("Failed");
}

mysqli_close($conn);

?>
