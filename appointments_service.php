<?php
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];
include "dbUpload.php";

$sql = "SELECT phone FROM all_service_users WHERE email='$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $phone = $row['phone'];

    $sql = "SELECT * FROM `repair_booking` WHERE mechanic_phone='$phone'";
    $result = $conn->query($sql);

    $response = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            array_push($response, $row);
        }
    }

    $conn->close();
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    $conn->close();
    echo "No phone number found for the service man.";
}



?>
