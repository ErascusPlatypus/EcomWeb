<?php
header("Access-Control-Allow-Origin: *");



include "dbUpload.php";
$email = $_POST['email'];

$sql1 = "SELECT * FROM all_service_users WHERE email='".$email."'";
    $result1 = $conn->query($sql1);
    $response1 = array();
    if($result1->num_rows >0) {
    while($row1 = $result1->fetch_assoc()) {
            array_push($response1, $row1);
    }
}
$driver_id = $response1[0]['id'];
$sql = "SELECT * FROM `orders` WHERE driver_id='$driver_id';";
$result = $conn->query($sql);
$response = array();
if($result) {
    if($result->num_rows >0) {
        while($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }
    $conn->close();
    header('Content-Type: application/json');
    echo json_encode($response);
}





?>
