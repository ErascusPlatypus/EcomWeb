<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";
$repair_id = $_POST['repair_id'];


$sql = "UPDATE `repair_booking` SET `serviceman_status`='1' WHERE `id` = '$repair_id'";


$resultSearch = mysqli_query($conn, $sql);
if ($resultSearch) {
    $data['success'] = true;
    $data["message"] = "Repair request accepted.";
    echo json_encode($data);
} else {
    $data['success'] = false;
    $data["message"] = "Failed to accept request.";
    echo json_encode($data);
}


$conn->close();
