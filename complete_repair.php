<?php

header("Access-Control-Allow-Origin: *");
include "dbUpload.php";
$repair_id = $_POST['repair_id'];
date_default_timezone_set("Asia/Calcutta");
$repair_time = date('Y-m-d H:i:s');
$sql = "UPDATE `repair_booking` SET `repair_time`='$repair_time' WHERE `id` = '$repair_id'";


$resultSearch = mysqli_query($conn, $sql);
if ($resultSearch) {
    $data['success'] = true;
    $data["message"] = "Repair Order completed.";
    echo json_encode($data);
} else {
    $data['success'] = false;
    $data["message"] = "Failed to complete.";
    echo json_encode($data).mysqli_error($conn);
}


$conn->close();
